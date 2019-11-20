import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:interdisciplinar/chamados_pesquisar.dart';
import 'package:interdisciplinar/chamados_ver.dart';

class ChamadosPesquisar extends StatefulWidget {
  @override
  _ChamadosPesquisarState createState() => _ChamadosPesquisarState();
}

class _ChamadosPesquisarState extends State<ChamadosPesquisar> {
  
  String nomeCampo="";
  String filtro="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Filtro de Chamados",
          style: TextStyle(fontSize: 20),
        ),
        actions: <Widget>[
          PopupMenuButton<int>(
            itemBuilder: (context) => <PopupMenuEntry<int>>[
              
              PopupMenuItem<int>(
                child: Text("Matriz"),
                value: 2,
              ),
              PopupMenuItem<int>(
                child: Text("Filial 01"),
                value: 3,
              ),
              PopupMenuItem<int>(
                child: Text("Filial 02"),
                value: 4,
              ),
              PopupMenuItem<int>(
                child: Text("Filial 03"),
                value: 5,
              ),
              PopupMenuItem<int>(
                child: Text("Filial 04"),
                value: 6,
              ),
              PopupMenuItem<int>(
                child: Text("Filial 05"),
                value: 7,
              ),
              PopupMenuItem<int>(
                child: Text("Filial 06"),
                value: 8,
              ),
              PopupMenuItem<int>(
                child: Text("Filial 07"),
                value: 9,
              ),
              PopupMenuItem<int>(
                child: Text("Filial 08"),
                value: 10,
              ),
              PopupMenuItem<int>(
                child: Text("Filial 09"),
                value: 11,
              ),
              PopupMenuItem<int>(
                child: Text("Filial 10"),
                value: 12,
              ),
              PopupMenuItem<int>(
                child: Text("Hardware"),
                value: 13,
              ),
              PopupMenuItem<int>(
                child: Text("Software"),
                value: 14,
              ),
              PopupMenuItem<int>(
                child: Text("Requisição"),
                value: 15,
              ),
              PopupMenuItem<int>(
                child: Text("Serviço"),
                value: 16,
              ),
            ],
            onSelected: (int resultado) {
              setState(() {

                  if (resultado == 2) {
                   nomeCampo="filiais";
                   filtro = "Matriz";
                  }
                
                if (resultado == 3) {
                  nomeCampo="filiais";
                  filtro = "Filial 01";
                }
                  if (resultado == 4) {
                    nomeCampo= "filiais"; filtro= "Filial 02";
                  }
                  if (resultado == 5) {
                    nomeCampo="filiais"; filtro = "Filial 03";
                  }
                  if (resultado == 6) {
                    nomeCampo= "filiais"; filtro = "Filial 04";
                  }
                  if (resultado == 7) {
                    nomeCampo= "filiais"; filtro = "Filial 05";
                  }
                  if (resultado == 8) {
                    nomeCampo= "filiais"; filtro = "Filial 06";
                  }
                  if (resultado == 9) {
                    nomeCampo= "filiais"; filtro = "Filial 07";
                  }
                  if (resultado == 10) {
                    nomeCampo= "filiais"; filtro = "Filial 08";
                  }
                  if (resultado == 11) {
                    nomeCampo= "filiais"; filtro = "Filial 09";
                  }
                  if (resultado == 12) {
                    nomeCampo= "filiais"; filtro = "Filial 10";
                  }
                  if (resultado == 13) {
                    nomeCampo= "categoria"; filtro = "Hardware";
                  }
                  if (resultado == 14) {
                    nomeCampo= "categoria"; filtro = "Software";
                  }
                  if (resultado == 15) {
                     nomeCampo= "tipo"; filtro = "Requisição";
                  }
                  if (resultado == 16) {
                     nomeCampo= "tipo"; filtro = "Incidente";
                  }
                
              });
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                  stream: Firestore.instance
                      .collection("chamados")
                      .where("status", isEqualTo: "3")
                      .where(nomeCampo, isEqualTo: filtro)
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
