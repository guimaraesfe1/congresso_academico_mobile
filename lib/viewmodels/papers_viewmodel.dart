import 'package:flutter/foundation.dart';
import '../data/mock_papers_data.dart';
import '../models/academic_paper.dart';

/// ViewModel responsável pelo gerenciamento de estado e regras de negócio
/// do Módulo 4: Trabalhos Acadêmicos, seguindo o padrão MVVM.
class PapersViewModel extends ChangeNotifier {
  List<AcademicPaper> _papers = [];
  String _searchQuery = '';
  String _selectedArea = 'Todas';

  PapersViewModel({List<AcademicPaper>? initialPapers}) {
    _papers = List.from(initialPapers ?? mockPapers);
  }

  // --- Getters ---

  /// Lista completa de trabalhos.
  List<AcademicPaper> get allPapers => List.unmodifiable(_papers);

  /// Termo de busca atual.
  String get searchQuery => _searchQuery;

  /// Área de conhecimento atualmente filtrada.
  String get selectedArea => _selectedArea;

  /// Quantidade total de trabalhos cadastrados.
  int get totalCount => _papers.length;

  /// Quantidade de trabalhos salvos / favoritos.
  int get favoriteCount => _papers.where((p) => p.isFavorite).length;

  /// Lista de áreas de conhecimento disponíveis para filtro (iniciando com 'Todas').
  List<String> get availableKnowledgeAreas {
    final areas = _papers.map((p) => p.knowledgeArea).toSet().toList()..sort();
    return ['Todas', ...areas];
  }

  /// Lista de trabalhos salvos / favoritos pelo congressista.
  List<AcademicPaper> get savedPapers {
    return _papers.where((p) => p.isFavorite).toList();
  }

  /// Lista filtrada dinamicamente pelo termo de busca e pela área de conhecimento selecionada.
  List<AcademicPaper> get filteredPapers {
    return _papers.where((paper) {
      // Filtro por Área
      final matchesArea =
          _selectedArea == 'Todas' || paper.knowledgeArea == _selectedArea;

      // Filtro por termo de busca (título, autores, resumo ou palavras-chave)
      final query = _searchQuery.trim().toLowerCase();
      final matchesSearch = query.isEmpty ||
          paper.title.toLowerCase().contains(query) ||
          paper.authorsFormatted.toLowerCase().contains(query) ||
          paper.abstractText.toLowerCase().contains(query) ||
          paper.keywords.any((kw) => kw.toLowerCase().contains(query));

      return matchesArea && matchesSearch;
    }).toList();
  }

  // --- Ações / Mutações de Estado ---

  /// Atualiza o termo de busca e notifica a interface.
  void setSearchQuery(String query) {
    if (_searchQuery != query) {
      _searchQuery = query;
      notifyListeners();
    }
  }

  /// Define a área de conhecimento selecionada e notifica a interface.
  void setSelectedArea(String area) {
    if (_selectedArea != area) {
      _selectedArea = area;
      notifyListeners();
    }
  }

  /// Limpa os filtros de busca e área.
  void clearFilters() {
    _searchQuery = '';
    _selectedArea = 'Todas';
    notifyListeners();
  }

  /// Alterna o estado de favorito de um trabalho específico.
  /// Produz uma alteração significativa no estado da aplicação.
  bool toggleFavorite(String paperId) {
    final index = _papers.indexWhere((p) => p.id == paperId);
    if (index != -1) {
      final current = _papers[index];
      final newFavoriteState = !current.isFavorite;
      _papers[index] = current.copyWith(isFavorite: newFavoriteState);
      notifyListeners();
      return newFavoriteState;
    }
    return false;
  }

  /// Registra uma dúvida ou pergunta enviada pelo participante para os autores.
  void addQuestion(String paperId, String question) {
    final trimmed = question.trim();
    if (trimmed.isEmpty) return;

    final index = _papers.indexWhere((p) => p.id == paperId);
    if (index != -1) {
      final current = _papers[index];
      final updatedQuestions = List<String>.from(current.questions)..add(trimmed);
      _papers[index] = current.copyWith(questions: updatedQuestions);
      notifyListeners();
    }
  }

  /// Busca um trabalho específico pelo seu identificador.
  AcademicPaper? getPaperById(String paperId) {
    try {
      return _papers.firstWhere((p) => p.id == paperId);
    } catch (_) {
      return null;
    }
  }
}
