import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Concluido extends StatefulWidget {
  @override
  _ConcluidoState createState() => _ConcluidoState();
}

class _ConcluidoState extends State<Concluido> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                  stream: Firestore.instance
                      .collection("chamados")
                      .where("status", isEqualTo: "3")
                      .orderBy("titulo")
                      .snapshots(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.done:
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        if (snapshot.data.documents.length == 0) {
                          //
                          return Center(
                            child: Text(
                              "Não há dados!",
                              style: TextStyle(
                                  color: Colors.redAccent, fontSize: 20),
                            ),
                          );
                        }

                        return ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              return Card(
                                  // Lista os produtos
                                  child: ListTile(
                                //snapshot.data.documents[index].documentID.toString(),
                                title: Text(
                                    snapshot
                                        .data.documents[index].data["titulo"],
                                    style: TextStyle(fontSize: 15)),
                                subtitle: Text(
                                    snapshot
                                        .data.documents[index].data["descricao"]
                                        .toString(),
                                    style: TextStyle(fontSize: 15)),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[],
                                ),
                              ));
                            });
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
