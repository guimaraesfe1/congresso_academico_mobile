import 'package:flutter/material.dart';

import '../models/aviso_model.dart';

/// Card reutilizável para exibir um Aviso ou Comunicado do Congresso.
class AvisoCard extends StatelessWidget {
  final AvisoModel aviso;
  final VoidCallback onAlternarLido;
  final VoidCallback? onRemover;

  const AvisoCard({
    super.key,
    required this.aviso,
    required this.onAlternarLido,
    this.onRemover,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final Color corBorda = aviso.urgente
        ? Colors.amber.shade700
        : (aviso.lido
              ? Colors.transparent
              : theme.colorScheme.primary.withValues(alpha: 0.45));

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: corBorda, width: 1.3),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (aviso.urgente)
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade700,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.priority_high_rounded,
                          size: 14,
                          color: Colors.white,
                        ),
                        SizedBox(width: 3),
                        Text(
                          'URGENTE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.green.shade900.withValues(alpha: 0.4)
                          : Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      aviso.categoria.label,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    aviso.horarioPublicacao,
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11.5, color: Colors.grey),
                  ),
                ),
                if (onRemover != null)
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    tooltip: 'Excluir aviso',
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      size: 19,
                      color: Colors.redAccent,
                    ),
                    onPressed: onRemover,
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  aviso.urgente
                      ? Icons.campaign_rounded
                      : Icons.notifications_active_outlined,
                  color: aviso.urgente
                      ? Colors.amber.shade800
                      : theme.colorScheme.primary,
                  size: 22,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    aviso.titulo,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: aviso.lido
                          ? FontWeight.w600
                          : FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              aviso.mensagem,
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.4,
                color: aviso.lido
                    ? theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.72)
                    : theme.textTheme.bodyMedium?.color,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.place_outlined, size: 15, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    aviso.localOuReferencia,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Flexible(
                  child: TextButton.icon(
                    onPressed: onAlternarLido,
                    icon: Icon(
                      aviso.lido
                          ? Icons.mark_email_read_rounded
                          : Icons.mark_email_unread_outlined,
                      size: 17,
                    ),
                    label: Text(
                      aviso.lido ? 'Lido' : 'Marcar como lido',
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
    );
  }
}
