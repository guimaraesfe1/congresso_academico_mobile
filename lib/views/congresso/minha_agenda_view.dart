import 'package:flutter/material.dart';
import '../../models/evento_info_model.dart';
import '../../theme/congresso_theme.dart';
import '../../viewmodels/atividades_viewmodel.dart';
import '../../widgets/atividade_model_card.dart';

/// View responsável por exibir a Credencial do Congressista da UNIMAM
/// e a Minha Agenda de Palestras e Atividades inscritas.
class MinhaAgendaView extends StatelessWidget {
  final EventoInfoModel eventoInfo;
  final AtividadesViewModel atividadesViewModel;

  const MinhaAgendaView({
    super.key,
    required this.eventoInfo,
    required this.atividadesViewModel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListenableBuilder(
      listenable: atividadesViewModel,
      builder: (context, _) {
        final inscritas = atividadesViewModel.atividadesInscritas;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Credencial Oficial do Congressista UNIMAM 2026
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      CongressoTheme.primaryGreen,
                      CongressoTheme.secondaryGreen,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.white.withValues(alpha: 0.2),
                          child: const Icon(
                            Icons.badge_rounded,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'CREDENCIAL DO CONGRESSISTA',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.1,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                eventoInfo.nomeParticipante,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                eventoInfo.modalidadeInscricao,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.qr_code_2_rounded,
                          color: Colors.white,
                          size: 48,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Divider(color: Colors.white24),
                    const SizedBox(height: 8),
                    Text(
                      'Curso: ${eventoInfo.cursoParticipante}',
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Inscrição: ${eventoInfo.matriculaParticipante} • ${eventoInfo.edicao}',
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 12.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Resumo de Carga Horária e Presenças
              Row(
                children: [
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          children: [
                            Icon(Icons.schedule_rounded,
                                color: theme.colorScheme.primary),
                            const SizedBox(height: 6),
                            Text(
                              '${atividadesViewModel.totalHorasInscritas}h / 40h',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Carga Horária Inscrita',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          children: [
                            Icon(Icons.verified_rounded,
                                color: theme.colorScheme.primary),
                            const SizedBox(height: 6),
                            Text(
                              '${atividadesViewModel.totalPresencasConfirmadas} confirmadas',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Check-ins no Evento',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Text(
                'Minhas Palestras e Atividades Inscritas (${inscritas.length})',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              if (inscritas.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(
                      child: Text(
                        'Você ainda não se inscreveu em nenhuma palestra ou atividade. Acesse a aba "Palestras" para montar sua agenda no 22º Congresso UNIMAM!',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              else
                ...inscritas.map(
                  (atividade) => AtividadeModelCard(
                    atividade: atividade,
                    onAlternarInscricao: () =>
                        atividadesViewModel.alternarInscricao(atividade.id),
                    onAlternarPresenca: (val) => atividadesViewModel
                        .alternarPresencaConfirmada(atividade.id, val),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
