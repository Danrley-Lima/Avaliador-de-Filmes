import 'package:flutter/material.dart';
import 'package:und1_mobile/components/lista_producao.dart';
import 'package:und1_mobile/screens/pagina_filmes_nao_avaliados.dart';
import 'package:und1_mobile/styles.dart';

import 'pagina_curtidos.dart';
import 'pagina_nao_curtidos.dart';

class PaginaInicial extends StatefulWidget {
  List<dynamic> producoes;
  List<dynamic> producoesCurtidas;
  List<dynamic> producoesNaoCurtidas;
  final Function(int) gostei;
  final Function(int) naoGostei;
  final Function(int) removerCurtido;
  final Function(int) removerNaoCurtido;

  PaginaInicial(
      this.gostei, this.naoGostei, this.removerCurtido, this.removerNaoCurtido,
      {super.key,
      required this.producoes,
      required this.producoesCurtidas,
      required this.producoesNaoCurtidas});

  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  int _selectedIndex = 1;

  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  late List<Widget> _screens;
  final List<String> _titulosDaPagina = [
    'Filmes Não Curtidos',
    'Não Avaliados',
    'Filmes Curtidos'
  ];

  @override
  void initState() {
    super.initState();
    _screens = [
      PaginaNaoCurtidos(widget.removerNaoCurtido,
          producoes: widget.producoesNaoCurtidas),
      PaginaFilmesNaoAvaliados(widget.gostei, widget.naoGostei,
          producoes: widget.producoes),
      PaginaCurtidos(widget.removerCurtido,
          producoes: widget.producoesCurtidas),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cores = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          _titulosDaPagina[_selectedIndex],
          style: estiloSubTitulo1,
        )),
      ),
      body: Container(
        child: _screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.thumb_down),
            label: 'Não gostei',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Não avaliados',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.thumb_up),
            label: 'Gostei',
            backgroundColor: Colors.green,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: cores.onPrimary,
        unselectedItemColor: cores.onSecondaryContainer,
        onTap: _onItemTapped,
        backgroundColor: cores.onBackground,
      ),
    );
  }
}
