import 'package:flutter/foundation.dart';
import '../models/aviso_model.dart';
import '../data/congresso_repository.dart';

/// Filtros disponíveis para o mural de avisos do Congresso.
enum FiltroAviso {
  todos('Todos'),
  urgentes('Urgentes'),
  naoLidos('Não lidos');

  final String label;
  const FiltroAviso(this.label);
}

/// ViewModel responsável pela lógica dos Avisos e Comunicados sobre
/// palestras e atividades do 22º Congresso UNIMAM 2026.
class AvisosViewModel extends ChangeNotifier {
  final List<AvisoModel> _avisos = [];
  FiltroAviso _filtroAtual = FiltroAviso.todos;

  AvisosViewModel({required CongressoRepository repository}) {
    _avisos.addAll(repository.obterAvisosIniciais());
  }

  List<AvisoModel> get todosAvisos => List.unmodifiable(_avisos);

  FiltroAviso get filtroAtual => _filtroAtual;

  int get quantidadeNaoLidos => _avisos.where((a) => !a.lido).length;

  List<AvisoModel> get avisosUrgentes =>
      _avisos.where((a) => a.urgente).toList();

  List<AvisoModel> get avisosFiltrados {
    switch (_filtroAtual) {
      case FiltroAviso.urgentes:
        return _avisos.where((a) => a.urgente).toList();
      case FiltroAviso.naoLidos:
        return _avisos.where((a) => !a.lido).toList();
      case FiltroAviso.todos:
        return List.unmodifiable(_avisos);
    }
  }

  void definirFiltro(FiltroAviso novoFiltro) {
    _filtroAtual = novoFiltro;
    notifyListeners();
  }

  void alternarLido(String id) {
    final index = _avisos.indexWhere((a) => a.id == id);
    if (index != -1) {
      _avisos[index].lido = !_avisos[index].lido;
      notifyListeners();
    }
  }

  void marcarTodosComoLidos() {
    for (final aviso in _avisos) {
      aviso.lido = true;
    }
    notifyListeners();
  }

  void publicarAviso({
    required String titulo,
    required String mensagem,
    required String localOuReferencia,
    required CategoriaAviso categoria,
    bool urgente = false,
  }) {
    if (titulo.trim().isEmpty || mensagem.trim().isEmpty) return;

    final novoAviso = AvisoModel(
      id: 'aviso_${DateTime.now().millisecondsSinceEpoch}',
      titulo: titulo.trim(),
      mensagem: mensagem.trim(),
      horarioPublicacao: 'Agora mesmo',
      localOuReferencia: localOuReferencia.trim().isEmpty
          ? 'Coordenação do 22º Congresso UNIMAM'
          : localOuReferencia.trim(),
      categoria: categoria,
      urgente: urgente,
      lido: false,
    );

    _avisos.insert(0, novoAviso);
    notifyListeners();
  }

  void removerAviso(String id) {
    _avisos.removeWhere((a) => a.id == id);
    notifyListeners();
  }
}
