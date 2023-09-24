import 'package:flutter/material.dart';
import 'package:und1_mobile/screens/detalhes_filme.dart';
import '../models/filme.dart';
import 'package:und1_mobile/screens/bottom_navigation_bar_teste.dart';

class NaoGostei extends StatefulWidget {
  const NaoGostei({super.key});

  @override
  State<NaoGostei> createState() => _NaoGosteiState();
}

class _NaoGosteiState extends State<NaoGostei> {
  List<Filme> listarFilmes() {
    List<Filme> filmes = [
      Filme(
        id: "1",
        titulo: "Gran Turismo – De Jogador a Corredor",
        sinopse:
            "Baseado na história de Jann Mardenborough, e relata a trajetória de um jogador de videogame que utilizou suas habilidades nos simuladores para se tornar um piloto profissional de verdade.",
        diretor: "Neill Blomkamp",
        posterUrl: "assets/filme1.jpg",
        anoLancamento: "2023",
        avaliacoes: null,
      ),
      Filme(
        id: "2",
        titulo: "Need for Speed",
        sinopse:
            "Um jovem piloto de rua se envolve em uma corrida ilegal e acaba sendo perseguido pela polícia.",
        diretor: "Scott Waugh",
        posterUrl: "assets/filme2.jpg",
        anoLancamento: "2014",
        avaliacoes: null,
      ),
      Filme(
        id: "3",
        titulo: "Rush",
        sinopse:
            "A rivalidade entre os pilotos de Fórmula 1 James Hunt e Niki Lauda nos anos 1970.",
        diretor: "Ron Howard",
        posterUrl: "assets/filme3.jpg",
        anoLancamento: "2013",
        avaliacoes: null,
      ),
      Filme(
        id: "4",
        titulo: "Ford vs Ferrari",
        sinopse:
            "A história real da Ford e da Ferrari na disputa pelo Campeonato Mundial de Carros Sports de 1966.",
        diretor: "James Mangold",
        posterUrl: "assets/filme4.jpg",
        anoLancamento: "2019",
        avaliacoes: null,
      ),
      Filme(
        id: "5",
        titulo: "Drive",
        sinopse:
            "Um motorista de fuga misterioso e solitário se envolve em um perigoso jogo de gato e rato com a polícia e uma gangue de criminosos.",
        diretor: "Nicolas Winding Refn",
        posterUrl: "assets/filme5.jpg",
        anoLancamento: "2011",
        avaliacoes: null,
      ),
    ];

    return filmes;
  }

  Filme getFilmeSelecionado(int index) {
    return listarFilmes()[index];
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cores = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Filme"),
      ),
      body: ListView.builder(
        itemCount: listarFilmes().length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              color: cores.onBackground,
              child: ListTile(
                title: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        listarFilmes()[index].titulo,
                        style: TextStyle(
                          color: cores.onPrimary,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image(
                          image: AssetImage(listarFilmes()[index].posterUrl),
                          height: 450,
                          fit: BoxFit.cover,
                          // width: double.infinity,
                        ),
                      ),
                    ),
                    TextButton(
                      child: Text(
                        "Ver detalhes",
                        style: TextStyle(color: cores.onPrimary),
                      ),
                      onPressed: () {
                        final filme = getFilmeSelecionado(index);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetalhesFilme(
                              filme: filme,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomNavigationBarTeste(),
    );
  }
}
