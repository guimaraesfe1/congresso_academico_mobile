import 'package:flutter/material.dart';

import '../../models/academic_paper.dart';
import '../../viewmodels/papers_viewmodel.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/paper_card.dart';
import 'paper_detail_view.dart';
import 'saved_papers_view.dart';

/// Tela 1: Catálogo e Listagem dos Trabalhos Acadêmicos do Congresso.
/// Otimizada para tema verde escuro e alta performance sem animações pesadas.
class PapersListView extends StatefulWidget {
  final PapersViewModel viewModel;

  const PapersListView({super.key, required this.viewModel});

  @override
  State<PapersListView> createState() => _PapersListViewState();
}

class _PapersListViewState extends State<PapersListView> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: widget.viewModel.searchQuery,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _navigateToDetail(AcademicPaper paper) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            PaperDetailView(paperId: paper.id, viewModel: widget.viewModel),
      ),
    );
  }

  void _navigateToSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SavedPapersView(viewModel: widget.viewModel),
      ),
    );
  }

  void _handleToggleFavorite(AcademicPaper paper) {
    final isSaved = widget.viewModel.toggleFavorite(paper.id);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isSaved
              ? 'Artigo salvo com sucesso!'
              : 'Artigo removido dos salvos.',
        ),
        backgroundColor: const Color(0xFF1B4332),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Ver Salvos',
          textColor: const Color(0xFF95D5B2),
          onPressed: _navigateToSaved,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ListenableBuilder reconstrói reativamente a tela de forma direta
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        final filteredList = widget.viewModel.filteredPapers;
        final totalCount = widget.viewModel.totalCount;
        final favoriteCount = widget.viewModel.favoriteCount;
        final areas = widget.viewModel.availableKnowledgeAreas;
        final selectedArea = widget.viewModel.selectedArea;

        return Scaffold(
          appBar: AppBar(
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Trabalhos Acadêmicos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'CEPP UNIMAM 2026',
                  style: TextStyle(fontSize: 11, color: Color(0xFFD8F3DC)),
                ),
              ],
            ),
            actions: [
              // Botão para Trabalhos Salvos com indicador numérico
              IconButton(
                tooltip: 'Trabalhos Salvos',
                icon: Badge(
                  isLabelVisible: favoriteCount > 0,
                  backgroundColor: const Color(0xFF52B788),
                  textColor: const Color(0xFF081C15),
                  label: Text(
                    '$favoriteCount',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  child: const Icon(
                    Icons.bookmark_rounded,
                    color: Colors.white,
                  ),
                ),
                onPressed: _navigateToSaved,
              ),
              const SizedBox(width: 6),
            ],
          ),
          body: Column(
            children: [
              // Campo de Busca
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 10.0, 14.0, 6.0),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) => widget.viewModel.setSearchQuery(value),
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Buscar por título, autor, resumo...',
                    hintStyle: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF708D81),
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF2D6A4F),
                      size: 20,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(
                              Icons.clear,
                              size: 18,
                              color: Color(0xFF708D81),
                            ),
                            onPressed: () {
                              _searchController.clear();
                              widget.viewModel.setSearchQuery('');
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(color: Color(0xFFD3E0D8)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(
                        color: Color(0xFF1B4332),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),

              // Filtros Horizontais por Área do Conhecimento
              SizedBox(
                height: 42,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 2.0,
                  ),
                  itemCount: areas.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 6),
                  itemBuilder: (context, index) {
                    final area = areas[index];
                    final isSelected = area == selectedArea;

                    return FilterChip(
                      selected: isSelected,
                      label: Text(area),
                      labelStyle: TextStyle(
                        fontSize: 12.0,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF1B4332),
                      ),
                      selectedColor: const Color(0xFF1B4332),
                      backgroundColor: Colors.white,
                      showCheckmark: false,
                      side: BorderSide(
                        color: isSelected
                            ? const Color(0xFF1B4332)
                            : const Color(0xFFD3E0D8),
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      ),
                      onSelected: (_) => widget.viewModel.setSelectedArea(area),
                    );
                  },
                ),
              ),

              // Indicador de Resultados
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 6.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Exibindo ${filteredList.length} de $totalCount trabalhos',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFF52615B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (selectedArea != 'Todas' ||
                        _searchController.text.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          widget.viewModel.clearFilters();
                        },
                        child: const Text(
                          'Limpar filtros',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Color(0xFF1B4332),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Lista Otimizada de Trabalhos
              Expanded(
                child: filteredList.isEmpty
                    ? EmptyState(
                        icon: Icons.search_off_rounded,
                        title: 'Nenhum trabalho encontrado',
                        message: 'Não encontramos trabalhos correspondentes aos critérios de busca.',
                        actionLabel: 'Redefinir filtros',
                        onAction: () {
                          _searchController.clear();
                          widget.viewModel.clearFilters();
                        },
                      )
                    : ListView.builder(
                        itemCount: filteredList.length,
                        padding: const EdgeInsets.only(bottom: 20.0),
                        itemBuilder: (context, index) {
                          final paper = filteredList[index];
                          return PaperCard(
                            paper: paper,
                            onTap: () => _navigateToDetail(paper),
                            onToggleFavorite: () =>
                                _handleToggleFavorite(paper),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
