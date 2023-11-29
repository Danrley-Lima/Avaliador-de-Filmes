import 'package:flutter/material.dart';
import 'package:und1_mobile/models/avaliacao_model.dart';

class ListaAvaliacoes extends ChangeNotifier {
  List<Avaliacao> _avaliacoes = [];

  List<Avaliacao> avaliacoesPorProducao(String id) =>
      _avaliacoes.where((p) => p.producaoid == id).toList();
  List<Avaliacao> avaliacoesPorUsuario(String id) =>
      _avaliacoes.where((p) => p.userid == id).toList();

  set avaliacoes(List<Avaliacao> avaliacoes) => _avaliacoes = avaliacoes;

  List<Avaliacao> get avaliacoes => _avaliacoes;

  adicionar(Avaliacao avaliacao) {
    if (_avaliacoes
        .where((element) =>
            element.producaoid == avaliacao.producaoid &&
            element.userid == avaliacao.userid)
        .isEmpty) {
      avaliacao.id = _avaliacoes.length.toString();
      _avaliacoes.add(avaliacao);
      avaliacao.adicionar();
      notifyListeners();
    }
  }

  bool jaAvaliou(String idProducao, String idUsuario) {
    return _avaliacoes
        .where((element) =>
            element.producaoid == idProducao && element.userid == idUsuario)
        .isNotEmpty;
  }

  editar(Avaliacao avaliacao) {
    int idx = _avaliacoes.indexWhere((element) =>
        element.producaoid == avaliacao.producaoid &&
        element.userid == avaliacao.userid);
    if (idx >= 0) {
      _avaliacoes[idx] = avaliacao;
      avaliacao.atualizar();
      notifyListeners();
    }
  }

  remover(Avaliacao avaliacao) {
    if (avaliacao.id != null) {
      _avaliacoes.removeWhere((element) =>
          element.producaoid == avaliacao.producaoid &&
          element.userid == avaliacao.userid);
      Avaliacao.remover(avaliacao.id!);
      notifyListeners();
    }
  }
}
