import 'package:flutter/material.dart';
import 'package:interdisciplinar/andamento.dart';
import 'package:interdisciplinar/concluido.dart';
import 'package:interdisciplinar/espera.dart';
import 'package:interdisciplinar/novo_login.dart';

void main() => runApp(MaterialApp());

class PaginaInicial extends StatefulWidget {
  @override
  _PaginaInicialState createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  List<Widget> containers = [
    Container(
      color: Colors.white,
    ),
    Container(
      color: Colors.white,
    ),
    Container(
      color: Colors.white,
    ),
    Container(
      color: Colors.white,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Gerenciador de Chamados"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.hourglass_empty),
              ),
              Tab(
                icon: Icon(Icons.build),
              ),
              Tab(
                icon: Icon(Icons.check_circle_outline),
              ),
              Tab(
                icon: Icon(Icons.person_add),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Espera(),
            Andamento(),
            Concluido(),
            NovoLogin(),
          ],
        ),
      ),
    );
  }
}
