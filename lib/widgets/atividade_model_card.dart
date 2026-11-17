import 'package:flutter/material.dart';

import '../models/atividade_model.dart';

/// Card reutilizável para exibir uma palestra ou atividade do Congresso.
class AtividadeModelCard extends StatelessWidget {
  final AtividadeModel atividade;
  final VoidCallback onAlternarInscricao;
  final ValueChanged<bool?>? onAlternarPresenca;
  final VoidCallback? onRemover;
  final VoidCallback? onTapDetalhes;

  const AtividadeModelCard({
    super.key,
    required this.atividade,
    required this.onAlternarInscricao,
    this.onAlternarPresenca,
    this.onRemover,
    this.onTapDetalhes,
  });

  IconData _iconePorTipo(TipoAtividade tipo) {
    switch (tipo) {
      case TipoAtividade.palestra:
        return Icons.mic_external_on_rounded;
      case TipoAtividade.posGraduacao:
        return Icons.workspace_premium_rounded;
      case TipoAtividade.minicurso:
        return Icons.laptop_chromebook_rounded;
      case TipoAtividade.mesaRedonda:
        return Icons.groups_rounded;
      case TipoAtividade.comunicacaoOral:
        return Icons.science_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: atividade.inscrito
              ? theme.colorScheme.primary.withValues(alpha: 0.45)
              : Colors.transparent,
          width: 1.3,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTapDetalhes,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.green.shade900.withValues(alpha: 0.45)
                            : Colors.green.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _iconePorTipo(atividade.tipo),
                            size: 15,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              atividade.tipo.label,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${atividade.cargaHorariaHoras}h',
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (onRemover != null)
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      tooltip: 'Remover atividade',
                      icon: const Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.redAccent,
                        size: 20,
                      ),
                      onPressed: onRemover,
                    ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                atividade.titulo,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  decoration: atividade.presencaConfirmada
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(
                    Icons.person_outline_rounded,
                    size: 16,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      atividade.palestrante,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 14,
                runSpacing: 6,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.event_outlined,
                        size: 15,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          '${atividade.data} • ${atividade.horario}',
                          style: const TextStyle(fontSize: 12.5),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.place_outlined,
                        size: 15,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          atividade.local,
                          style: const TextStyle(fontSize: 12.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (onAlternarPresenca != null)
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: atividade.presencaConfirmada,
                            activeColor: Colors.green.shade700,
                            onChanged: onAlternarPresenca,
                          ),
                          const Flexible(
                            child: Text(
                              'Check-in realizado',
                              style: TextStyle(fontSize: 12.5),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Flexible(
                      child: Text(
                        atividade.inscrito
                            ? 'Inscrito na Minha Agenda'
                            : 'Disponível para inscrição',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: atividade.inscrito
                              ? Colors.green.shade700
                              : Colors.grey,
                        ),
                      ),
                    ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: FilledButton.tonalIcon(
                      onPressed: onAlternarInscricao,
                      icon: Icon(
                        atividade.inscrito
                            ? Icons.check_circle_rounded
                            : Icons.add_circle_outline_rounded,
                        size: 18,
                      ),
                      label: Text(
                        atividade.inscrito ? 'Inscrito' : 'Inscrever-se',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12.5),
                      ),
                    ),
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
