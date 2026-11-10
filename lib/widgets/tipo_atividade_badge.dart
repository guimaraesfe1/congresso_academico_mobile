import 'package:flutter/material.dart';

import '../models/atividade.dart';

/// Etiqueta colorida que identifica o tipo da atividade.
class TipoAtividadeBadge extends StatelessWidget {
  final TipoAtividade tipo;

  const TipoAtividadeBadge({super.key, required this.tipo});

  static Color corDo(TipoAtividade tipo) {
    switch (tipo) {
      case TipoAtividade.palestra:
        return const Color(0xFF1B4332);
      case TipoAtividade.workshop:
        return const Color(0xFFB45309);
      case TipoAtividade.minicurso:
        return const Color(0xFF1D4ED8);
    }
  }

  static IconData iconeDo(TipoAtividade tipo) {
    switch (tipo) {
      case TipoAtividade.palestra:
        return Icons.record_voice_over_rounded;
      case TipoAtividade.workshop:
        return Icons.handyman_rounded;
      case TipoAtividade.minicurso:
        return Icons.menu_book_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cor = corDo(tipo);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: cor.withValues(alpha: 0.1),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        border: Border.all(color: cor.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconeDo(tipo), size: 13, color: cor),
          const SizedBox(width: 4),
          Text(
            tipo.rotulo,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: cor),
          ),
        ],
      ),
    );
  }
}
