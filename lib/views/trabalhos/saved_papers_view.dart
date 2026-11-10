import 'package:flutter/material.dart';
import '../../models/academic_paper.dart';
import '../../viewmodels/papers_viewmodel.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/paper_card.dart';
import 'paper_detail_view.dart';

/// Tela 3: Trabalhos Salvos pelo participante.
/// Otimizada: sem gradientes pesados de renderização, tema verde escuro.
class SavedPapersView extends StatelessWidget {
  final PapersViewModel viewModel;

  const SavedPapersView({
    super.key,
    required this.viewModel,
  });

  void _navigateToDetail(BuildContext context, AcademicPaper paper) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PaperDetailView(
          paperId: paper.id,
          viewModel: viewModel,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final savedList = viewModel.savedPapers;
        final oralCount = savedList.where((p) => p.modality.contains('Oral')).length;
        final posterCount = savedList.where((p) => p.modality.contains('Pôster')).length;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Trabalhos Salvos',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
          body: savedList.isEmpty
              ? EmptyState(
                  icon: Icons.bookmark_border_rounded,
                  title: 'Nenhum trabalho salvo',
                  message:
                      'Você ainda não salvou nenhum trabalho acadêmico. Navegue pelo catálogo e favorite as apresentações de seu interesse!',
                  actionLabel: 'Explorar Trabalhos',
                  onAction: () => Navigator.of(context).pop(),
                )
              : Column(
                  children: [
                    // Card Informativo com Resumo dos Salvos (Container plano, sem gradiente)
                    Container(
                      margin: const EdgeInsets.fromLTRB(14.0, 10.0, 14.0, 6.0),
                      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F2EC),
                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                        border: Border.all(color: const Color(0xFFC3D8CC)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatColumn(
                            count: savedList.length.toString(),
                            label: 'Total Salvos',
                            icon: Icons.bookmark_added_rounded,
                          ),
                          Container(
                            height: 30,
                            width: 1,
                            color: const Color(0xFFC3D8CC),
                          ),
                          _buildStatColumn(
                            count: oralCount.toString(),
                            label: 'Apres. Orais',
                            icon: Icons.record_voice_over_rounded,
                          ),
                          Container(
                            height: 30,
                            width: 1,
                            color: const Color(0xFFC3D8CC),
                          ),
                          _buildStatColumn(
                            count: posterCount.toString(),
                            label: 'Pôsteres',
                            icon: Icons.dashboard_outlined,
                          ),
                        ],
                      ),
                    ),

                    // Lista de Trabalhos Salvos
                    Expanded(
                      child: ListView.builder(
                        itemCount: savedList.length,
                        padding: const EdgeInsets.only(top: 2.0, bottom: 20.0),
                        itemBuilder: (context, index) {
                          final paper = savedList[index];

                          return Dismissible(
                            key: Key('dismiss_${paper.id}'),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20.0),
                              color: const Color(0xFFC84B31),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.delete_outline, color: Colors.white, size: 20),
                                  SizedBox(width: 6),
                                  Text(
                                    'Remover',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onDismissed: (_) {
                              viewModel.toggleFavorite(paper.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('"${paper.title}" removido dos salvos.'),
                                  backgroundColor: const Color(0xFF1B4332),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            child: PaperCard(
                              paper: paper,
                              onTap: () => _navigateToDetail(context, paper),
                              onToggleFavorite: () {
                                viewModel.toggleFavorite(paper.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Artigo removido dos salvos.'),
                                    backgroundColor: Color(0xFF1B4332),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
                            ),
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

  Widget _buildStatColumn({
    required String count,
    required String label,
    required IconData icon,
  }) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: const Color(0xFF1B4332)),
            const SizedBox(width: 4),
            Text(
              count,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F261C),
              ),
            ),
          ],
        ),
        const SizedBox(height: 1),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11.0,
            color: Color(0xFF52615B),
          ),
        ),
      ],
    );
  }
}
