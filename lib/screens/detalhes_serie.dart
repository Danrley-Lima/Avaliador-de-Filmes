import 'package:flutter/material.dart';
import 'package:und1_mobile/models/producao.dart';
import '../mocks/mock_avaliacao.dart';
import '../models/avaliacao.dart';
import '../models/serie.dart';

class DetalhesSerie extends StatefulWidget {
  final Function(Producao) foiCurtido;
  final Function(Producao) foiNaoCurtido;
  final Function(Producao) toggleNaoCurtido;
  final Function(Producao) toggleCurtido;

  const DetalhesSerie({
    super.key,
    required this.foiCurtido,
    required this.foiNaoCurtido,
    required this.toggleCurtido,
    required this.toggleNaoCurtido,
  });

  @override
  State<DetalhesSerie> createState() => _DetalhesSerieState();
}

class _DetalhesSerieState extends State<DetalhesSerie> {
  @override
  Widget build(BuildContext context) {
    var serie = ModalRoute.of(context)?.settings.arguments as Serie;
    final ColorScheme cores = Theme.of(context).colorScheme;

    List<Avaliacao> listaAvaliacoes = [
      mockAvaliacao1,
      mockAvaliacao2,
    ];
    serie.avaliacoes = listaAvaliacoes;

    return Scaffold(
      backgroundColor: const Color.fromARGB(52, 150, 9, 9),
      appBar: AppBar(
        title: const Text('Detalhes da Série'),
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
                    serie.titulo,
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
                          image: Image.network(serie.posterUrl).image,
                          //height: 270,
                          fit: BoxFit.fill,
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
                          serie.anoLancamento,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: cores.onSecondary,
                          ),
                        ),
                        Text(
                          "Lançamento ",
                          style: TextStyle(
                            fontSize: 16,
                            color: cores.onSecondary,
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Text(
                          serie.numeroTemporadas,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: cores.onSecondary,
                          ),
                        ),
                        Text(
                          "Temporadas ",
                          style: TextStyle(
                            fontSize: 16,
                            color: cores.onSecondary,
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Text(
                          serie.numeroEpisodios,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: cores.onSecondary,
                          ),
                        ),
                        Text(
                          "Episódios ",
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
              serie.sinopse,
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
            if (serie.avaliacoes != null)
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: serie.avaliacoes!.length,
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
          Container(
            margin: const EdgeInsets.all(5),
            child: FloatingActionButton(
              heroTag: "rating1",
              onPressed: () => {},
              child: const Icon(Icons.star),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                child: FloatingActionButton(
                  heroTag: "like1",
                  backgroundColor:
                      widget.foiCurtido(serie) ? Colors.green : Colors.grey,
                  onPressed: () => {widget.toggleCurtido(serie)},
                  child: Icon(widget.foiCurtido(serie)
                      ? Icons.thumb_up
                      : Icons.thumb_up_alt_outlined),
                ),
              ),
              Container(
                  margin: EdgeInsets.all(5),
                  child: FloatingActionButton(
                    heroTag: "unlike1",
                    backgroundColor:
                        widget.foiNaoCurtido(serie) ? Colors.red : Colors.grey,
                    onPressed: () => {widget.toggleNaoCurtido(serie)},
                    child: Icon(widget.foiNaoCurtido(serie)
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
