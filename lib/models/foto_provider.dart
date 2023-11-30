import 'package:flutter/cupertino.dart';

class FotoProvider with ChangeNotifier {
  String? _fotoUrl;

  String? get fotoUrl => _fotoUrl;

  set fotoUrl(String? novoFotoUrl) {
    _fotoUrl = novoFotoUrl;
    notifyListeners();
  }
}
