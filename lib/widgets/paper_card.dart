import 'package:flutter/material.dart';

import '../models/academic_paper.dart';
import 'area_badge.dart';

/// Widget reutilizável PaperCard
class PaperCard extends StatelessWidget {
  final AcademicPaper paper;
  final VoidCallback onTap;
  final VoidCallback onToggleFavorite;

  const PaperCard({
    super.key,
    required this.paper,
    required this.onTap,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(
          color: const Color(0xFFD3E0D8), // Borda verde acinzentada suave
          width: 1.0,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: const Color(
          0x101B4332,
        ), // Leve feedback visual estático
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Linha Superior: Área de Conhecimento + Modalidade + Botão de Favorito
              Row(
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        AreaBadge(area: paper.knowledgeArea, isCompact: true),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7.0,
                            vertical: 3.0,
                          ),
                          decoration: const BoxDecoration(
                            color: Color(0xFFE9F3ED),
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                          ),
                          child: Text(
                            paper.modality,
                            style: const TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1B4332),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Botão de Favoritar otimizado
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    splashRadius: 18,
                    icon: Icon(
                      paper.isFavorite
                          ? Icons.bookmark_added_rounded
                          : Icons.bookmark_add_outlined,
                      color: paper.isFavorite
                          ? const Color(0xFF2D6A4F) // Verde destaque
                          : const Color(0xFF8D99AE),
                      size: 22,
                    ),
                    tooltip: paper.isFavorite
                        ? 'Remover dos Salvos'
                        : 'Salvar Trabalho',
                    onPressed: onToggleFavorite,
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Título do Artigo
              Text(
                paper.title,
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  height: 1.25,
                  color: Color(0xFF0B2016),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),

              // Autores
              Row(
                children: [
                  const Icon(
                    Icons.people_outline,
                    size: 15,
                    color: Color(0xFF2D6A4F),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      paper.authorsFormatted,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF40534C),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),

              // Instituição
              Row(
                children: [
                  const Icon(
                    Icons.school_outlined,
                    size: 14,
                    color: Color(0xFF708D81),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      paper.institution,
                      style: const TextStyle(
                        fontSize: 11.0,
                        color: Color(0xFF708D81),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Resumo curto
              Text(
                paper.abstractText,
                style: const TextStyle(
                  fontSize: 12.0,
                  height: 1.3,
                  color: Color(0xFF52615B),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),

              const Divider(height: 1, color: Color(0xFFE2ECE5)),
              const SizedBox(height: 8),

              // Rodapé: Data/Hora e Sala
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.schedule_rounded,
                        size: 14,
                        color: Color(0xFF1B4332),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${paper.presentationDate} • ${paper.presentationTime}',
                        style: const TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1B4332),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: Color(0xFF2D6A4F),
                      ),
                      const SizedBox(width: 3),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 125),
                        child: Text(
                          paper.room,
                          style: const TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2D6A4F),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
