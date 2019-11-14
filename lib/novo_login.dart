import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NovoLogin extends StatefulWidget {
  @override
  _NovoLoginState createState() => _NovoLoginState();
}

class _NovoLoginState extends State<NovoLogin> {
  var focusNomeUsuario = new FocusNode();
  var focusSenhaUsuario = new FocusNode();
  var tipoUsuario;
  var nomeTipo = ["Técnico", "Comum"];

  TextEditingController nomeUsuario = TextEditingController();
  TextEditingController senhaUsuario = TextEditingController();
  TextEditingController tipos = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cadastro de Usuário"),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 60, left: 40, right: 40),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 40,
                  height: 40,
                ),
                TextFormField(
                  focusNode: focusNomeUsuario,
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  validator: (valor) {
                    if (valor.isEmpty) {
                      FocusScope.of(context).requestFocus(focusNomeUsuario);
                      return "Informe o nome";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Usuário", icon: Icon(Icons.people)),
                  keyboardType: TextInputType.text,
                  controller: nomeUsuario,
                ),
                TextFormField(
                  focusNode: focusSenhaUsuario,
                  autofocus: true,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  validator: (valor) {
                    if (valor.isEmpty) {
                      FocusScope.of(context).requestFocus(focusSenhaUsuario);
                      return "Informe a senha";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Senha", icon: Icon(Icons.lock)),
                  keyboardType: TextInputType.text,
                  controller: senhaUsuario,
                ),
                DropdownButton<String>(
                  hint: Text("Selecione um tipo"),
                  style: TextStyle(color: Colors.blue),
                  items: nomeTipo.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      tipoUsuario = value;
                    });
                  },
                  value: tipoUsuario,
                  elevation: 2,
                  iconSize: 20.0,
                ),
                RaisedButton(
                    child: Text(
                      "Registrar-se",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                    onPressed: () {
                      if (formkey.currentState.validate()) {
                        Firestore.instance
                            .collection("usuarios")
                            .document()
                            .setData({
                          'login': nomeUsuario.text,
                          'senha': senhaUsuario.text,
                          'tipos': tipoUsuario
                        });
                      }
                    }),
              ],
            ),
          ),
        ));
  }
}
