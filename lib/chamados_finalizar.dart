import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChamadosFinalizar extends StatefulWidget {
  final String tipoEdicao;
  final DocumentSnapshot dadosChamado;

  ChamadosFinalizar(this.tipoEdicao, this.dadosChamado);

  @override
  _ChamadosFinalizarState createState() => _ChamadosFinalizarState();
}

class _ChamadosFinalizarState extends State<ChamadosFinalizar> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var focusFinalizar = new FocusNode();

  TextEditingController finalizar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Finalizar Chamado"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                focusNode: focusFinalizar,
                autofocus: true,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Text("Finalizar"),
                      onPressed: () {
                        Firestore.instance
                            .collection("chamados")
                            .document(widget.dadosChamado.documentID)
                            .updateData({
                          "finalizar": finalizar.text,
                          "status": "3",
                        });
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
