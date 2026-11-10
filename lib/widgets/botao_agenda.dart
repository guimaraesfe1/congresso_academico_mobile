import 'package:flutter/material.dart';

import '../models/atividade.dart';
import '../theme/app_theme.dart';
import '../viewmodels/agenda_viewmodel.dart';

/// Botão reutilizável que adiciona ou remove uma atividade da Minha Agenda,
/// avisando o usuário quando há conflito de horário.
class BotaoAgenda extends StatelessWidget {
  final Atividade atividade;
  final AgendaViewModel agendaViewModel;

  const BotaoAgenda({
    super.key,
    required this.atividade,
    required this.agendaViewModel,
  });

  static void alternar(
    BuildContext context,
    Atividade atividade,
    AgendaViewModel agendaViewModel,
  ) {
    final conflito = agendaViewModel.conflitoCom(atividade);
    final adicionada = agendaViewModel.alternar(atividade);

    var mensagem = adicionada
        ? 'Atividade adicionada à sua agenda!'
        : 'Atividade removida da sua agenda.';
    if (adicionada && conflito != null) {
      mensagem = 'Adicionada, mas conflita com "${conflito.titulo}".';
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(mensagem)));
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: agendaViewModel,
      builder: (context, _) {
        final naAgenda = agendaViewModel.contem(atividade.id);
        return IconButton(
          tooltip: naAgenda ? 'Remover da agenda' : 'Adicionar à agenda',
          icon: Icon(
            naAgenda ? Icons.event_available_rounded : Icons.event_outlined,
            color: naAgenda ? AppColors.secundaria : Colors.grey.shade600,
          ),
          onPressed: () => alternar(context, atividade, agendaViewModel),
        );
      },
    );
  }
}
