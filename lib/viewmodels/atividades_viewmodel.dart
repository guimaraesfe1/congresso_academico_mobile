import 'package:flutter/foundation.dart';
import '../models/atividade_model.dart';
import '../data/congresso_repository.dart';

/// ViewModel responsável pela regra de negócio das Palestras e Atividades
/// do 22º Congresso Estudantil de Pesquisa e Pós-Graduação da UNIMAM 2026.
class AtividadesViewModel extends ChangeNotifier {
  final List<AtividadeModel> _atividades = [];
  TipoAtividade? _filtroTipo;
  String _termoBusca = '';

  AtividadesViewModel({required CongressoRepository repository}) {
    _atividades.addAll(repository.obterAtividadesIniciais());
  }

  List<AtividadeModel> get todasAtividades => List.unmodifiable(_atividades);

  TipoAtividade? get filtroTipo => _filtroTipo;

  String get termoBusca => _termoBusca;

  /// Lista filtrada de atividades conforme categoria e busca textual.
  List<AtividadeModel> get atividadesFiltradas {
    return _atividades.where((atividade) {
      final correspondeTipo =
          _filtroTipo == null || atividade.tipo == _filtroTipo;
      final busca = _termoBusca.trim().toLowerCase();
      final correspondeBusca = busca.isEmpty ||
          atividade.titulo.toLowerCase().contains(busca) ||
          atividade.palestrante.toLowerCase().contains(busca) ||
          atividade.local.toLowerCase().contains(busca);
      return correspondeTipo && correspondeBusca;
    }).toList();
  }

  /// Lista apenas das palestras e atividades em que o estudante está inscrito.
  List<AtividadeModel> get atividadesInscritas =>
      _atividades.where((a) => a.inscrito).toList();

  /// Total de horas acumuladas nas atividades inscritas.
  int get totalHorasInscritas => atividadesInscritas.fold(
        0,
        (soma, item) => soma + item.cargaHorariaHoras,
      );

  /// Total de atividades com presença já confirmada.
  int get totalPresencasConfirmadas =>
      _atividades.where((a) => a.presencaConfirmada).length;

  void definirFiltroTipo(TipoAtividade? tipo) {
    _filtroTipo = tipo;
    notifyListeners();
  }

  void atualizarBusca(String termo) {
    _termoBusca = termo;
    notifyListeners();
  }

  void alternarInscricao(String id) {
    final index = _atividades.indexWhere((a) => a.id == id);
    if (index != -1) {
      _atividades[index].inscrito = !_atividades[index].inscrito;
      if (!_atividades[index].inscrito) {
        _atividades[index].presencaConfirmada = false;
      }
      notifyListeners();
    }
  }

  void alternarPresencaConfirmada(String id, bool? valor) {
    final index = _atividades.indexWhere((a) => a.id == id);
    if (index != -1) {
      final confirmado = valor ?? !_atividades[index].presencaConfirmada;
      _atividades[index].presencaConfirmada = confirmado;
      if (confirmado) {
        _atividades[index].inscrito = true;
      }
      notifyListeners();
    }
  }

  void adicionarAtividade({
    required String titulo,
    required String palestrante,
    required String horario,
    required String local,
    required TipoAtividade tipo,
    String data = '20/11/2026',
    String descricao = 'Atividade cadastrada na programação do 22º Congresso UNIMAM 2026.',
    int cargaHorariaHoras = 4,
  }) {
    if (titulo.trim().isEmpty) return;

    final nova = AtividadeModel(
      id: 'ativ_${DateTime.now().millisecondsSinceEpoch}',
      titulo: titulo.trim(),
      palestrante: palestrante.trim().isEmpty
          ? 'Comissão Científica UNIMAM'
          : palestrante.trim(),
      titulacaoPalestrante: 'Docente / Pesquisador Convidado - UNIMAM',
      tipo: tipo,
      data: data.trim().isEmpty ? '20/11/2026' : data.trim(),
      horario: horario.trim().isEmpty ? '14:00 às 17:00' : horario.trim(),
      local: local.trim().isEmpty ? 'Auditório UNIMAM' : local.trim(),
      descricao: descricao.trim(),
      cargaHorariaHoras: cargaHorariaHoras,
      inscrito: true,
    );

    _atividades.insert(0, nova);
    notifyListeners();
  }

  void removerAtividade(String id) {
    _atividades.removeWhere((a) => a.id == id);
    notifyListeners();
  }
}
