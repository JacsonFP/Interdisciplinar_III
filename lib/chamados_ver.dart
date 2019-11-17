import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chamados_finalizar.dart';

class ChamadosVer extends StatefulWidget {
  final String tipoEdicao;
  final DocumentSnapshot dadosChamado;

  ChamadosVer(this.tipoEdicao, this.dadosChamado);

  @override
  _ChamadosVerState createState() => _ChamadosVerState();
}

class _ChamadosVerState extends State<ChamadosVer> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var valorFilial;
  var nomeFilial = [
    "Matriz",
    "Filial 01",
    "Filial 02",
    "Filial 03",
    "Filial 04",
    "Filial 05",
    "Filial 06",
    "Filial 07",
    "Filial 08",
    "Filial 09",
    "Filial 10",
  ];
  var valorCategoria;
  var nomeCategoria = ["Hardware", "Software"];
  var valorPrioridade;
  var nomePrioridade = ["Baixa", "Média", "Alta"];
  var valorTipo;
  var nomeTipo = ["Requisição de Serviço", "Incidente"];

  var focusTitulo = new FocusNode();
  var focusDescricao = new FocusNode();

  TextEditingController titulo = TextEditingController();
  TextEditingController descricao = TextEditingController();
  TextEditingController filiais = TextEditingController();
  TextEditingController finalizar = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.tipoEdicao == "alt") {
      titulo.text = widget.dadosChamado.data["titulo"].toString();
      descricao.text = widget.dadosChamado.data["descricao"].toString();
      finalizar.text = widget.dadosChamado.data["finalizar"].toString();
      valorFilial = widget.dadosChamado.data["filiais"].toString();
      valorCategoria = widget.dadosChamado.data["categoria"].toString();
      valorPrioridade = widget.dadosChamado.data["prioridade"].toString();
      valorTipo = widget.dadosChamado.data["tipo"].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.tipoEdicao == "inc"
              ? "Incluir Chamados"
              : "Informações do Chamado"),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    focusNode: focusTitulo,
                    //autofocus: true,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    enabled: widget.tipoEdicao == "alt" ? false : true,
                    decoration: InputDecoration(
                        labelText: "Título",
                        labelStyle:
                            TextStyle(color: Colors.blueAccent, fontSize: 18)),
                    textAlign: TextAlign.left,
                    controller: titulo,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Informe um titulo";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    focusNode: focusDescricao,
                    //autofocus: true,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    enabled: widget.tipoEdicao == "alt" ? false : true,
                    decoration: InputDecoration(
                        labelText: "Descrição",
                        labelStyle:
                            TextStyle(color: Colors.blueAccent, fontSize: 18)),
                    textAlign: TextAlign.left,
                    controller: descricao,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Informe uma descrição";
                      }
                      return null;
                    },
                  ),
                  DropdownButton<String>(
                    hint: Text("Selecione uma Filial"),
                    style: TextStyle(color: Colors.blue),
                    items: nomeFilial.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        valorFilial = value;
                      });
                    },
                    value: valorFilial,
                    elevation: 2,
                    iconSize: 20.0,
                  ),
                  DropdownButton<String>(
                    hint: Text("Selecione uma Categoria"),
                    style: TextStyle(color: Colors.blue),
                    items: nomeCategoria.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        valorCategoria = value;
                      });
                    },
                    value: valorCategoria,
                    elevation: 2,
                    iconSize: 20.0,
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  DropdownButton<String>(
                    hint: Text("Selecione uma Prioridade"),
                    style: TextStyle(color: Colors.blue),
                    items: nomePrioridade.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        valorPrioridade = value;
                      });
                    },
                    value: valorPrioridade,
                    elevation: 2,
                    iconSize: 20.0,
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  DropdownButton<String>(
                    hint: Text("Selecione um Tipo"),
                    style: TextStyle(color: Colors.blue),
                    items: nomeTipo.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        valorTipo = value;
                      });
                    },
                    value: valorTipo,
                    elevation: 2,
                    iconSize: 20.0,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    enabled: widget.tipoEdicao == "alt" ? false : true,
                    decoration: InputDecoration(
                        labelText: "Solução",
                        labelStyle:
                            TextStyle(color: Colors.blueAccent, fontSize: 18)),
                    textAlign: TextAlign.left,
                    controller: finalizar,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Informe uma Solução";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  /*Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Text("Salvar"),
                        onPressed: () {
                          if (widget.tipoEdicao == "inc") {
                            Firestore.instance.collection("chamados").add({
                              "titulo": titulo.text,
                              "descricao": descricao.text,
                              "filiais": valorFilial,
                              "status": "1",
                            });
                          } else {
                            Firestore.instance
                                .collection("chamados")
                                .document(widget.dadosChamado.documentID)
                                .updateData({
                              "filiais": valorFilial,
                              "categoria": valorCategoria,
                              "prioridade": valorPrioridade,
                              "tipo": valorTipo,
                              
                            });
                          }
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),*/
                ],
              ),
            )));
  }
}
