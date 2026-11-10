import 'package:flutter/material.dart';

import '../models/atividade.dart';
import '../theme/app_theme.dart';
import 'tipo_atividade_badge.dart';

/// Card reutilizável de atividade, usado na Programação, na lista de
/// locais e na Minha Agenda. O [trailing] permite que cada tela coloque
/// suas próprias ações (adicionar à agenda, favoritar, remover...).
class AtividadeCard extends StatelessWidget {
  final Atividade atividade;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool mostrarData;

  const AtividadeCard({
    super.key,
    required this.atividade,
    this.onTap,
    this.trailing,
    this.mostrarData = false,
  });

  @override
  Widget build(BuildContext context) {
    final horario = mostrarData
        ? '${atividade.dataFormatada} • ${atividade.horarioFormatado}'
        : atividade.horarioFormatado;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 6, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TipoAtividadeBadge(tipo: atividade.tipo),
                    const SizedBox(height: 8),
                    Text(
                      atividade.titulo,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textoForte,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 6),
                    _linha(Icons.schedule_rounded, horario),
                    _linha(Icons.location_on_outlined, atividade.local),
                    _linha(Icons.person_outline, atividade.responsavel),
                  ],
                ),
              ),
              ?trailing,
            ],
          ),
        ),
      ),
    );
  }

  Widget _linha(IconData icone, String texto) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Row(
        children: [
          Icon(icone, size: 15, color: AppColors.secundaria),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              texto,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12.5, color: AppColors.textoSuave),
            ),
          ),
        ],
      ),
    );
  }
}
