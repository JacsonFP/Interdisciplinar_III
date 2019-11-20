import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:interdisciplinar/chamados_editar.dart';

class Espera extends StatefulWidget {
  @override
  _EsperaState createState() => _EsperaState();
}

class _EsperaState extends State<Espera> {
  DocumentSnapshot dadosBranco;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chamado em espera",
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChamadosEditar("inc", dadosBranco)));
        },
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                  stream: Firestore.instance
                      .collection("chamados")
                      .where("status", isEqualTo: "1")
                      .orderBy("data_criacao")
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
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.build),
                                      color: Colors.black,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChamadosEditar(
                                                        "alt",
                                                        snapshot.data.documents[
                                                            index])));
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      color: Colors.black,
                                      onPressed: () {
                                        confirmaExclusao(
                                            context, index, snapshot);
                                      },
                                    ),
                                  ],
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

  confirmaExclusao(BuildContext context, index, snapshot) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Atenção !"),
          content: Text("Confirma a exclusão de : \n" +
              snapshot.data.documents[index].data["titulo"]
                  .toString()
                  .toUpperCase()),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Firestore.instance
                    .collection('chamados')
                    .document(
                        snapshot.data.documents[index].documentID.toString())
                    .delete();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
