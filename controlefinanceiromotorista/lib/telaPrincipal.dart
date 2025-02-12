import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:controlefinanceiromotorista/helper/condutorHelper.dart';
import 'package:controlefinanceiromotorista/telaCadastro.dart';
import 'package:controlefinanceiromotorista/telaLancamento.dart';

class telaPrincipal extends StatefulWidget {
  final Condutor condutor;

  telaPrincipal({this.condutor});

  @override
  _telaPrincipalState createState() => _telaPrincipalState();
}

class _telaPrincipalState extends State<telaPrincipal> {
  Condutor _condutor;

  @override
  void initState() {
    super.initState();
    if (widget.condutor != null) {
      _condutor = Condutor.from(widget.condutor.toMap());
    }
  }

  void _showTelaLancamentos() async{
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => TelaLancamento()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Criação do MENU
      drawer: Drawer(
        child: ListView(
          children: ListTile.divideTiles(context: context, tiles: [
            DrawerHeader(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  image: _condutor.imagem != null && _condutor.imagem.isNotEmpty
                      ? MemoryImage(base64Decode(_condutor.imagem))
                      : AssetImage("images/person.png"),
                ),
              ),
              child: null,
            ),
            ListTile(
              title: Text('Cadastrar Serviços'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => telaCadastro(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Atualizar Dados'),
              onTap: () async {
                final Condutor condutor = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => telaCadastro(
                      condutor: _condutor,
                    ),
                  ),
                );
                if (condutor != null) {
                  setState(() {
                    _condutor = condutor;
                  });
                }
              },
            ),
          ]).toList(),
        ),
      ),
      appBar: AppBar(
        title: Text(("Tela Principal")),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.blueAccent,
            onPressed: (){
              _showTelaLancamentos();
            },

          ),
        )
      ),
    );
  }
}
