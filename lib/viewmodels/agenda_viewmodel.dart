import 'package:flutter/foundation.dart';

import '../models/atividade.dart';
import '../models/item_agenda.dart';

/// ViewModel do Módulo 5: Minha Agenda.
///
/// Guarda as atividades escolhidas pelo participante, permite
/// adicionar, remover e marcar atividades como favoritas.
class AgendaViewModel extends ChangeNotifier {
  final List<ItemAgenda> _itens = [];
  bool _somenteFavoritas = false;

  // --- Getters ---

  bool get somenteFavoritas => _somenteFavoritas;

  int get total => _itens.length;

  int get totalFavoritas => _itens.where((i) => i.favorita).length;

  /// Itens da agenda em ordem cronológica, respeitando o filtro de favoritas.
  List<ItemAgenda> get itens {
    final lista = _somenteFavoritas
        ? _itens.where((i) => i.favorita).toList()
        : List.of(_itens);
    lista.sort((a, b) => a.atividade.inicio.compareTo(b.atividade.inicio));
    return lista;
  }

  bool contem(String atividadeId) =>
      _itens.any((i) => i.atividade.id == atividadeId);

  bool isFavorita(String atividadeId) =>
      _itens.any((i) => i.atividade.id == atividadeId && i.favorita);

  /// Retorna a atividade da agenda que acontece no mesmo horário, se houver.
  Atividade? conflitoCom(Atividade atividade) {
    for (final item in _itens) {
      final outra = item.atividade;
      if (outra.id == atividade.id) continue;
      final sobrepoe =
          atividade.inicio.isBefore(outra.fim) && outra.inicio.isBefore(atividade.fim);
      if (sobrepoe) return outra;
    }
    return null;
  }

  // --- Ações ---

  void adicionar(Atividade atividade) {
    if (contem(atividade.id)) return;

    _itens.add(ItemAgenda(atividade: atividade));
    notifyListeners();
  }

  void remover(String atividadeId) {
    _itens.removeWhere((i) => i.atividade.id == atividadeId);
    notifyListeners();
  }

  /// Adiciona ou remove a atividade. Retorna true se ela ficou na agenda.
  bool alternar(Atividade atividade) {
    if (contem(atividade.id)) {
      remover(atividade.id);
      return false;
    }
    adicionar(atividade);
    return true;
  }

  void alternarFavorita(String atividadeId) {
    final index = _itens.indexWhere((i) => i.atividade.id == atividadeId);
    if (index == -1) return;
    _itens[index] = _itens[index].copyWith(favorita: !_itens[index].favorita);
    notifyListeners();
  }

  void alternarFiltroFavoritas() {
    _somenteFavoritas = !_somenteFavoritas;
    notifyListeners();
  }
}
