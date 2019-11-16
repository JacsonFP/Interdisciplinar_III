import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';

class ChamadosVer extends StatefulWidget {
  @override
  _ChamadosVerState createState() => _ChamadosVerState();
}

class _ChamadosVerState extends State<ChamadosVer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TabBarView(
      children: <Widget>[
        StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("chamados").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return new Center(
                  child: CircularProgressIndicator(),
                );
              } else
                return new ListView(
                    children: snapshot.data.documents.map((document) {
                  int status = document["status"];
                  return new Card(
                      elevation: 5.0,
                      margin: EdgeInsets.all(8),
                      child: ExpansionTile(
                          title: Text(
                            "${document["titulo"]}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[700],
                            ),
                          ),
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Titulo: ${document["chamados"]["titulo"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4.0,
                                      ),
                                      Text(
                                          "Descrição: ${document["descricao"]}"),
                                      SizedBox(
                                        height: 4.0,
                                      ),
                                      Text("Local: ${document["filiais"]}"),
                                      SizedBox(
                                        height: 4.0,
                                      ),
                                      Text(
                                          "Categoria: ${document["categoria"]}"),
                                      SizedBox(
                                        height: 4.0,
                                      ),
                                      Text(
                                          "Prioridade: ${document["prioridade"]}"),
                                      SizedBox(
                                        height: 4.0,
                                      ),
                                      Text(
                                          "Tipo de Serviço: ${document["tipo"]}"),
                                      SizedBox(
                                        height: 4.0,
                                      ),
                                    ]))
                          ]));
                }).toList());
            }),
      ],
    ));
  }
}
