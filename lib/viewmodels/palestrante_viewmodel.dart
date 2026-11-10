import 'package:flutter/foundation.dart';

import '../data/mock_palestrantes.dart';
import '../models/palestrante.dart';

/// ViewModel do Módulo 2: Palestrantes.
class PalestranteViewModel extends ChangeNotifier {
  final List<Palestrante> _palestrantes = List.of(mockPalestrantes);

  List<Palestrante> get palestrantes => List.unmodifiable(_palestrantes);

  Palestrante? buscarPorId(String id) {
    for (final palestrante in _palestrantes) {
      if (palestrante.id == id) return palestrante;
    }
    return null;
  }

  void adicionarPalestrante(Palestrante novoPalestrante) {
    _palestrantes.add(novoPalestrante);
    notifyListeners();
  }
}
