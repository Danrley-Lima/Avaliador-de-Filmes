import 'package:flutter/material.dart';
import 'package:und1_mobile/mocks/mock_avaliacao.dart';
import 'package:und1_mobile/models/avaliacao.dart';
import 'package:und1_mobile/models/producao.dart';

import '../models/filme.dart';

class DetalhesFilme extends StatefulWidget {
  final Function(Producao) foiCurtido;
  final Function(Producao) foiNaoCurtido;
  final Function(Producao) toggleNaoCurtido;
  final Function(Producao) toggleCurtido;

  const DetalhesFilme(
      {super.key,
      required this.foiCurtido,
      required this.foiNaoCurtido,
      required this.toggleCurtido,
      required this.toggleNaoCurtido});

  @override
  State<DetalhesFilme> createState() => _DetalhesFilmeState();
}

class _DetalhesFilmeState extends State<DetalhesFilme> {
  void initState() {
    super.initState();
  }

  _gostei(Filme filme){
    setState(() {
      widget.toggleCurtido(filme);
      Navigator.of(context).pop();
    });
  }

  _naoGostei(Filme filme){
    setState(() {
      widget.toggleNaoCurtido(filme);
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    var filme = ModalRoute.of(context)?.settings.arguments as Filme;

    final ColorScheme cores = Theme.of(context).colorScheme;
    List<Avaliacao> listaAvaliacoes = [
      mockAvaliacao1,
      mockAvaliacao2,
    ];
    filme.avaliacoes = listaAvaliacoes;

    return Scaffold(
      backgroundColor: const Color.fromARGB(52, 150, 9, 9),
      appBar: AppBar(
        title: const Text('Detalhes do Filme'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    filme.titulo,
                    style: TextStyle(
                      color: cores.onSecondary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.white30, // Cor da borda
                          width: 2.0, // Largura da borda
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image(
                          image: Image.network(filme.posterUrl).image,
                          height: 270,
                          fit: BoxFit.cover,
                          // width: double.infinity,
                        ),
                      ),
                    )),
                const Expanded(child: SizedBox()),
                Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          filme.diretor,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: cores.onSecondary,
                          ),
                        ),
                        Text(
                          "Diretor ",
                          style: TextStyle(
                            fontSize: 16,
                            color: cores.onSecondary,
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Text(
                          filme.anoLancamento,
                          style: TextStyle(
                            fontSize: 18,
                            color: cores.onSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Lançamento ",
                          style: TextStyle(
                            fontSize: 16,
                            color: cores.onSecondary,
                          ),
                        ),
                      ],
                    ))
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Sinopse:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: cores.onSecondary,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              filme.sinopse,
              style: TextStyle(
                fontSize: 16,
                color: cores.onSecondary,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              'Avaliações dos usuários: ${listaAvaliacoes.length}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: cores.onSecondary,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            if (filme.avaliacoes != null)
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: filme.avaliacoes!.length,
                itemBuilder: (context, index) {
                  final avaliacao = listaAvaliacoes[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${avaliacao.usuario}:',
                            style: TextStyle(
                              color: cores.onSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Row(
                            children: List.generate(
                              5,
                              (starIndex) => Icon(
                                Icons.star,
                                color: starIndex < int.parse(avaliacao.nota)
                                    ? Colors.orange
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        avaliacao.comentario ?? "",
                        style: TextStyle(
                          color: cores.onSecondary,
                        ),
                      ),
                      const SizedBox(
                          height: 8), // Espaçamento entre as avaliações
                    ],
                  );
                },
              ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          // Container(
          //   margin: const EdgeInsets.all(5),
          //   child: FloatingActionButton(
          //     heroTag: "rating1",
          //     onPressed: () => {},
          //     child: const Icon(Icons.star),
          //   ),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                child: FloatingActionButton(
                  heroTag: "like1",
                  backgroundColor:
                      widget.foiCurtido(filme) ? Colors.green : Colors.grey,
                  onPressed: () => {_gostei(filme)},
                  child: Icon(widget.foiCurtido(filme)
                      ? Icons.thumb_up
                      : Icons.thumb_up_alt_outlined),
                ),
              ),
              Container(
                  margin: EdgeInsets.all(5),
                  child: FloatingActionButton(
                    heroTag: "unlike1",
                    backgroundColor:
                        widget.foiNaoCurtido(filme) ? Colors.red : Colors.grey,
                    onPressed: () => {_naoGostei(filme)},
                    child: Icon(widget.foiNaoCurtido(filme)
                        ? Icons.thumb_down
                        : Icons.thumb_down_alt_outlined),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
