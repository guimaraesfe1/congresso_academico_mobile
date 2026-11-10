import 'package:flutter/material.dart';
import '../../models/academic_paper.dart';
import '../../viewmodels/papers_viewmodel.dart';
import '../../widgets/area_badge.dart';
import '../../widgets/info_tile.dart';
import 'submit_question_view.dart';

/// Tela 2: Detalhes Completos do Trabalho Acadêmico.
/// Otimizada: tema verde escuro, sem sombras pesadas de GPU, sem animações desnecessárias.
class PaperDetailView extends StatelessWidget {
  final String paperId;
  final PapersViewModel viewModel;

  const PaperDetailView({
    super.key,
    required this.paperId,
    required this.viewModel,
  });

  void _openQuestionScreen(BuildContext context, AcademicPaper paper) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SubmitQuestionView(
          paper: paper,
          viewModel: viewModel,
        ),
      ),
    );
  }

  void _handleToggleFavorite(BuildContext context, AcademicPaper paper) {
    final isSaved = viewModel.toggleFavorite(paper.id);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isSaved
              ? 'Trabalho salvo com sucesso!'
              : 'Trabalho removido dos salvos.',
        ),
        backgroundColor: const Color(0xFF1B4332),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final paper = viewModel.getPaperById(paperId);

        if (paper == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Trabalho não encontrado')),
            body: const Center(child: Text('Este trabalho acadêmico não foi localizado.')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Detalhes do Trabalho',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            actions: [
              // Botão de Favoritar
              IconButton(
                icon: Icon(
                  paper.isFavorite
                      ? Icons.bookmark_added_rounded
                      : Icons.bookmark_add_outlined,
                  color: paper.isFavorite ? const Color(0xFF52B788) : Colors.white,
                ),
                tooltip: paper.isFavorite
                    ? 'Remover dos Salvos'
                    : 'Salvar Trabalho',
                onPressed: () => _handleToggleFavorite(context, paper),
              ),
              IconButton(
                icon: const Icon(Icons.share_outlined, color: Colors.white),
                tooltip: 'Compartilhar artigo',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Link do artigo copiado!'),
                      backgroundColor: Color(0xFF1B4332),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              const SizedBox(width: 4),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 90.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Badges e Metadados
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    AreaBadge(area: paper.knowledgeArea),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE8F2EC),
                        borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      ),
                      child: Text(
                        paper.modality,
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1B4332),
                        ),
                      ),
                    ),
                    if (paper.status.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD8F3DC),
                          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                          border: Border.all(color: const Color(0xFF74C69D)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star_rounded, size: 13, color: Color(0xFF1B4332)),
                            const SizedBox(width: 3),
                            Text(
                              paper.status,
                              style: const TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1B4332),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),

                // 2. Título
                Text(
                  paper.title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0B2016),
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 12),

                // 3. Autores e Instituição
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    border: Border.all(color: const Color(0xFFD3E0D8)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.people_alt_outlined, size: 16, color: Color(0xFF1B4332)),
                          SizedBox(width: 6),
                          Text(
                            'AUTORES',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1B4332),
                              letterSpacing: 0.6,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ...paper.authors.map(
                        (author) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Row(
                            children: [
                              Container(
                                width: 5,
                                height: 5,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF2D6A4F),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 7),
                              Expanded(
                                child: Text(
                                  author,
                                  style: const TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1D2D24),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.school_outlined, size: 15, color: Color(0xFF708D81)),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              paper.institution,
                              style: const TextStyle(
                                fontSize: 11.5,
                                color: Color(0xFF708D81),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // 4. Detalhes da Apresentação
                const Text(
                  'Detalhes da Apresentação',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F261C),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    border: Border.all(color: const Color(0xFFD3E0D8)),
                  ),
                  child: Column(
                    children: [
                      InfoTile(
                        icon: Icons.calendar_today_rounded,
                        label: 'Data da Sessão',
                        value: paper.presentationDate,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0),
                        child: Divider(height: 1, color: Color(0xFFE2ECE5)),
                      ),
                      InfoTile(
                        icon: Icons.schedule_rounded,
                        label: 'Horário Previsto',
                        value: paper.presentationTime,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0),
                        child: Divider(height: 1, color: Color(0xFFE2ECE5)),
                      ),
                      InfoTile(
                        icon: Icons.meeting_room_rounded,
                        label: 'Sala / Auditório',
                        value: paper.room,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0),
                        child: Divider(height: 1, color: Color(0xFFE2ECE5)),
                      ),
                      InfoTile(
                        icon: Icons.grade_rounded,
                        label: 'Avaliação da Comissão',
                        value: '${paper.score.toStringAsFixed(1)} / 10.0',
                        iconColor: const Color(0xFF2D6A4F),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // 5. Resumo
                const Text(
                  'Resumo',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F261C),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    border: Border.all(color: const Color(0xFFD3E0D8)),
                  ),
                  child: Text(
                    paper.abstractText,
                    style: const TextStyle(
                      fontSize: 13.0,
                      height: 1.5,
                      color: Color(0xFF23352C),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 16),

                // 6. Palavras-chave
                const Text(
                  'Palavras-chave',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F261C),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6.0,
                  runSpacing: 6.0,
                  children: paper.keywords.map((kw) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 4.0),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE8F2EC),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      child: Text(
                        kw,
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1B4332),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 18),

                // 7. Seção de Perguntas
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Perguntas para os Autores (${paper.questions.length})',
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F261C),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () => _openQuestionScreen(context, paper),
                      icon: const Icon(Icons.add_comment_outlined, size: 15, color: Color(0xFF1B4332)),
                      label: const Text(
                        'Perguntar',
                        style: TextStyle(color: Color(0xFF1B4332), fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                if (paper.questions.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                      border: Border.all(color: const Color(0xFFD3E0D8)),
                    ),
                    child: const Center(
                      child: Text(
                        'Nenhuma pergunta enviada ainda. Seja o primeiro a perguntar!',
                        style: TextStyle(fontSize: 12.0, color: Color(0xFF708D81)),
                      ),
                    ),
                  )
                else
                  ...paper.questions.map(
                    (q) => Container(
                      margin: const EdgeInsets.only(bottom: 6.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                        border: Border.all(color: const Color(0xFFD3E0D8)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.question_answer_outlined,
                            size: 16,
                            color: Color(0xFF1B4332),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              q,
                              style: const TextStyle(fontSize: 12.5, color: Color(0xFF1D2D24)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Barra inferior plana (sem sombra pesada boxShadow para poupar GPU)
          bottomSheet: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Color(0xFFD3E0D8), width: 1.0),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: paper.isFavorite
                            ? const Color(0xFF2D6A4F)
                            : const Color(0xFF1B4332),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                      ),
                      onPressed: () => _handleToggleFavorite(context, paper),
                      icon: Icon(
                        paper.isFavorite
                            ? Icons.bookmark_added_rounded
                            : Icons.bookmark_add_outlined,
                        size: 18,
                      ),
                      label: Text(
                        paper.isFavorite
                            ? 'Trabalho Salvo'
                            : 'Salvar Trabalho',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    tooltip: 'Enviar pergunta aos autores',
                    icon: const Icon(Icons.question_answer_rounded, color: Color(0xFF1B4332)),
                    style: IconButton.styleFrom(
                      backgroundColor: const Color(0xFFE8F2EC),
                      padding: const EdgeInsets.all(12.0),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    onPressed: () => _openQuestionScreen(context, paper),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
