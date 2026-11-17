import 'package:flutter/material.dart';

import '../../viewmodels/atividades_viewmodel.dart';
import '../../viewmodels/avisos_viewmodel.dart';
import '../../viewmodels/congresso_viewmodel.dart';
import '../../widgets/atividade_model_card.dart';
import '../../widgets/aviso_card.dart';
import '../../widgets/congresso_header_card.dart';

/// View inicial (Dashboard) do 22º Congresso Estudantil de Pesquisa
/// e Pós-Graduação da UNIMAM 2026.
class CongressoHomeView extends StatelessWidget {
  final CongressoViewModel congressoViewModel;
  final AtividadesViewModel atividadesViewModel;
  final AvisosViewModel avisosViewModel;

  const CongressoHomeView({
    super.key,
    required this.congressoViewModel,
    required this.atividadesViewModel,
    required this.avisosViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        congressoViewModel,
        atividadesViewModel,
        avisosViewModel,
      ]),
      builder: (context, _) {
        final avisosDestaque = avisosViewModel.todosAvisos.take(2).toList();
        final proximasAtividades = atividadesViewModel.todasAtividades
            .take(3)
            .toList();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CongressoHeaderCard(
                info: congressoViewModel.eventoInfo,
                totalAtividades: atividadesViewModel.todasAtividades.length,
                totalInscritas: atividadesViewModel.atividadesInscritas.length,
                avisosNaoLidos: avisosViewModel.quantidadeNaoLidos,
              ),
              const SizedBox(height: 20),

              // Atalhos rápidos
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () => congressoViewModel.selecionarAba(1),
                      icon: const Icon(Icons.event_note_rounded),
                      label: const Text('Ver Palestras'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () => congressoViewModel.selecionarAba(2),
                      icon: const Icon(Icons.campaign_rounded),
                      label: const Text('Mural de Avisos'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Seção de Avisos importantes do Congresso
              _TituloSecao(
                icone: Icons.campaign_rounded,
                titulo: 'Últimos Avisos do Congresso',
                rotuloAcao: 'Ver todos',
                onAcao: () => congressoViewModel.selecionarAba(2),
              ),
              ...avisosDestaque.map(
                (aviso) => AvisoCard(
                  aviso: aviso,
                  onAlternarLido: () => avisosViewModel.alternarLido(aviso.id),
                ),
              ),
              const SizedBox(height: 20),

              // Seção de Palestras e Atividades em Destaque
              _TituloSecao(
                icone: Icons.mic_external_on_rounded,
                titulo: 'Palestras e Atividades em Destaque',
                rotuloAcao: 'Programação',
                onAcao: () => congressoViewModel.selecionarAba(1),
              ),
              ...proximasAtividades.map(
                (atividade) => AtividadeModelCard(
                  atividade: atividade,
                  onAlternarInscricao: () =>
                      atividadesViewModel.alternarInscricao(atividade.id),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Título de seção com ícone e botão de ação à direita.
///
/// O título ocupa o espaço restante e quebra em até duas linhas, evitando
/// overflow horizontal em telas estreitas.
class _TituloSecao extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String rotuloAcao;
  final VoidCallback onAcao;

  const _TituloSecao({
    required this.icone,
    required this.titulo,
    required this.rotuloAcao,
    required this.onAcao,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(icone, color: theme.colorScheme.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            titulo,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(onPressed: onAcao, child: Text(rotuloAcao)),
      ],
    );
  }
}
