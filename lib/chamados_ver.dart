import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  TextEditingController categoria = TextEditingController();
  TextEditingController tipo = TextEditingController();
  TextEditingController prioridade = TextEditingController();
  TextEditingController finalizar = TextEditingController();
  TextEditingController dataCriacao = TextEditingController();
  TextEditingController dataAndamento = TextEditingController();
  TextEditingController dataFinalizar = TextEditingController();


  @override
  void initState() {
    super.initState();

    if (widget.tipoEdicao == "alt") {
      titulo.text = widget.dadosChamado.data["titulo"].toString();
      descricao.text = widget.dadosChamado.data["descricao"].toString();
      finalizar.text = widget.dadosChamado.data["finalizar"].toString();
      filiais.text = widget.dadosChamado.data["filiais"].toString();
      categoria.text = widget.dadosChamado.data["categoria"].toString();
      prioridade.text = widget.dadosChamado.data["prioridade"].toString();
      tipo.text = widget.dadosChamado.data["tipo"].toString();
      dataCriacao.text = widget.dadosChamado.data["data_criacao"].toString();
      dataAndamento.text = widget.dadosChamado.data["data_andamento"].toString();
      dataFinalizar.text = widget.dadosChamado.data["data_finalizar"].toString();
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
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    enabled: widget.tipoEdicao == "alt" ? false : true,
                    decoration: InputDecoration(
                        labelText: "Local",
                        labelStyle:
                            TextStyle(color: Colors.blueAccent, fontSize: 18)),
                    textAlign: TextAlign.left,
                    controller: filiais,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Informe uma Filial";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    enabled: widget.tipoEdicao == "alt" ? false : true,
                    decoration: InputDecoration(
                        labelText: "Categoria",
                        labelStyle:
                            TextStyle(color: Colors.blueAccent, fontSize: 18)),
                    textAlign: TextAlign.left,
                    controller: categoria,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Informe uma Categoria";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    enabled: widget.tipoEdicao == "alt" ? false : true,
                    decoration: InputDecoration(
                        labelText: "Prioridade",
                        labelStyle:
                            TextStyle(color: Colors.blueAccent, fontSize: 18)),
                    textAlign: TextAlign.left,
                    controller: prioridade,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Informe uma Prioridade";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    enabled: widget.tipoEdicao == "alt" ? false : true,
                    decoration: InputDecoration(
                        labelText: "Tipo",
                        labelStyle:
                            TextStyle(color: Colors.blueAccent, fontSize: 18)),
                    textAlign: TextAlign.left,
                    controller: tipo,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Informe uma Tipo";
                      }
                      return null;
                    },
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
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    enabled: widget.tipoEdicao == "alt" ? false : true,
                    decoration: InputDecoration(
                        labelText: "Data de Criação",
                        labelStyle:
                            TextStyle(color: Colors.blueAccent, fontSize: 18)),
                    textAlign: TextAlign.left,
                    controller: dataCriacao,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Informe uma Data";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    enabled: widget.tipoEdicao == "alt" ? false : true,
                    decoration: InputDecoration(
                        labelText: "Data de Atendimento",
                        labelStyle:
                            TextStyle(color: Colors.blueAccent, fontSize: 18)),
                    textAlign: TextAlign.left,
                    controller: dataAndamento,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Informe uma Data";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    enabled: widget.tipoEdicao == "alt" ? false : true,
                    decoration: InputDecoration(
                        labelText: "Data de Finalização",
                        labelStyle:
                            TextStyle(color: Colors.blueAccent, fontSize: 18)),
                    textAlign: TextAlign.left,
                    controller: dataFinalizar,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Informe uma data";
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
                ],
              ),
            )));
  }
}
