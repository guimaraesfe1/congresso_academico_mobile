import 'package:flutter/foundation.dart';

import '../data/mock_atividades.dart';
import '../models/atividade.dart';

/// ViewModel do Módulo 1: Programação.
///
/// Concentra a lista de atividades e os filtros por dia e por tipo
/// selecionados pelo usuário.
class ProgramacaoViewModel extends ChangeNotifier {
  final List<Atividade> _atividades;
  DateTime? _diaSelecionado;
  TipoAtividade? _tipoSelecionado;

  ProgramacaoViewModel({List<Atividade>? atividades})
      : _atividades = List.of(atividades ?? mockAtividades)
          ..sort((a, b) => a.inicio.compareTo(b.inicio));

  // --- Getters ---

  List<Atividade> get atividades => List.unmodifiable(_atividades);

  /// Dia selecionado no filtro (null = todos os dias).
  DateTime? get diaSelecionado => _diaSelecionado;

  /// Tipo selecionado no filtro (null = todos os tipos).
  TipoAtividade? get tipoSelecionado => _tipoSelecionado;

  bool get temFiltroAtivo => _diaSelecionado != null || _tipoSelecionado != null;

  /// Dias do congresso, sem repetição e em ordem cronológica.
  List<DateTime> get dias {
    final dias = _atividades
        .map((a) => DateTime(a.inicio.year, a.inicio.month, a.inicio.day))
        .toSet()
        .toList()
      ..sort();
    return dias;
  }

  /// Atividades filtradas pelo dia e pelo tipo selecionados.
  List<Atividade> get atividadesFiltradas {
    return _atividades.where((a) {
      final mesmoDia = _diaSelecionado == null || _mesmoDia(a.inicio, _diaSelecionado!);
      final mesmoTipo = _tipoSelecionado == null || a.tipo == _tipoSelecionado;
      return mesmoDia && mesmoTipo;
    }).toList();
  }

  /// Atividades agrupadas pelo local onde acontecem.
  Map<String, List<Atividade>> get atividadesPorLocal {
    final mapa = <String, List<Atividade>>{};
    for (final atividade in _atividades) {
      mapa.putIfAbsent(atividade.local, () => []).add(atividade);
    }
    return mapa;
  }

  int quantidadePorTipo(TipoAtividade tipo) =>
      _atividades.where((a) => a.tipo == tipo).length;

  Atividade? buscarPorId(String id) {
    for (final atividade in _atividades) {
      if (atividade.id == id) return atividade;
    }
    return null;
  }

  // --- Ações ---

  void selecionarDia(DateTime? dia) {
    if (_diaSelecionado != dia) {
      _diaSelecionado = dia;
      notifyListeners();
    }
  }

  void selecionarTipo(TipoAtividade? tipo) {
    if (_tipoSelecionado != tipo) {
      _tipoSelecionado = tipo;
      notifyListeners();
    }
  }

  void limparFiltros() {
    _diaSelecionado = null;
    _tipoSelecionado = null;
    notifyListeners();
  }

  /// Rótulo curto de um dia do congresso, ex.: "Sáb, 24/10".
  static String rotuloDia(DateTime dia) {
    const semana = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];
    final dd = dia.day.toString().padLeft(2, '0');
    final mm = dia.month.toString().padLeft(2, '0');
    return '${semana[dia.weekday - 1]}, $dd/$mm';
  }

  static bool _mesmoDia(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
