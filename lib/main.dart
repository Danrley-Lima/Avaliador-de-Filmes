import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:und1_mobile/models/producao.dart';
import 'package:und1_mobile/screens/detalhes_filme.dart';
import 'package:und1_mobile/screens/detalhes_serie.dart';
import 'package:und1_mobile/screens/pagina_inicial.dart';
import 'package:und1_mobile/styles.dart';
import 'package:und1_mobile/utils/app_routes.dart';

import 'mocks/mock_filme.dart';
import 'mocks/mock_serie.dart';

void main() => runApp(MainApp());

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final List<dynamic> naoAvaliados = [];
  final List<dynamic> curtidos = [];
  final List<dynamic> naoCurtidos = [];

  _naoGostei(int index) {
    setState(() {
      debugPrint(naoAvaliados[index].titulo);
      naoCurtidos.add(naoAvaliados[index]);
      naoAvaliados.removeAt(index);
    });
  }

  _foiCurtido(Producao producao) {
    return curtidos.contains(producao);
  }

  _foiNaoCurtido(Producao producao) {
    return naoCurtidos.contains(producao);
  }

  _toggleCurtido(Producao producao) {
    setState(() {
      if (_foiCurtido(producao)) {
        debugPrint(curtidos.length.toString());
        curtidos.remove(producao);
        debugPrint(curtidos.length.toString());
        naoAvaliados.add(producao);
      }
      if (_foiNaoCurtido(producao)) naoCurtidos.remove(producao);
      curtidos.add(producao);
      naoAvaliados.remove(producao);
    });
  }

  _toggleNaoCurtido(Producao producao) {
    setState(() {
      if (_foiNaoCurtido(producao)) {
        naoCurtidos.remove(producao);
        naoAvaliados.add(producao);
      }
      naoCurtidos.add(producao);
      if (_foiCurtido(producao)) curtidos.remove(producao);
      naoAvaliados.remove(producao);
    });
  }

  _gostei(int index) {
    setState(() {
      debugPrint(naoAvaliados[index].titulo);
      curtidos.add(naoAvaliados[index]);
      naoAvaliados.removeAt(index);
    });
  }

  _removerCurtido(int index) {
    setState(() {
      naoAvaliados.add(curtidos[index]);
      curtidos.removeAt(index);
    });
  }

  _removerNaoCurtido(int index) {
    setState(() {
      // debugPrint(naoCurtidos[index].titulo);
      debugPrint(index.toString());
      naoAvaliados.add(naoCurtidos[index]);
      naoCurtidos.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    naoAvaliados.addAll(FILMES);
    naoAvaliados.addAll(SERIES);
    naoAvaliados.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
      ).copyWith(
        colorScheme: lightColorScheme,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.HOME,
      routes: {
        AppRoutes.HOME: (context) => PaginaInicial(
              _gostei,
              _naoGostei,
              _removerCurtido,
              _removerNaoCurtido,
              producoes: naoAvaliados,
              producoesCurtidas: curtidos,
              producoesNaoCurtidas: naoCurtidos,
            ),
        AppRoutes.DETALHES_FILME: (context) => DetalhesFilme(
              foiCurtido: _foiCurtido,
              foiNaoCurtido: _foiNaoCurtido,
              toggleCurtido: _toggleCurtido,
              toggleNaoCurtido: _toggleNaoCurtido,
            ),
        AppRoutes.DETALHES_SERIE: (context) => DetalhesSerie(
              foiCurtido: _foiCurtido,
              foiNaoCurtido: _foiNaoCurtido,
              toggleCurtido: _toggleCurtido,
              toggleNaoCurtido: _toggleNaoCurtido,
            ),
      },
    );
  }
}
