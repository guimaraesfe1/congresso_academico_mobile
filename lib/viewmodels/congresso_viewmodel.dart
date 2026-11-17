import 'package:flutter/foundation.dart';
import '../models/evento_info_model.dart';
import '../data/congresso_repository.dart';

/// ViewModel responsável pela navegação principal e dados institucionais
/// do 22º Congresso Estudantil de Pesquisa e Pós-Graduação da UNIMAM 2026.
class CongressoViewModel extends ChangeNotifier {
  final EventoInfoModel _eventoInfo;
  int _abaAtualIndex = 0;

  CongressoViewModel({required CongressoRepository repository})
      : _eventoInfo = repository.obterInfoEvento();

  EventoInfoModel get eventoInfo => _eventoInfo;

  int get abaAtualIndex => _abaAtualIndex;

  void selecionarAba(int novoIndex) {
    if (_abaAtualIndex != novoIndex) {
      _abaAtualIndex = novoIndex;
      notifyListeners();
    }
  }
}
