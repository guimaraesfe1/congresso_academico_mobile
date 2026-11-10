import 'package:flutter/material.dart';

import '../../viewmodels/agenda_viewmodel.dart';
import '../../viewmodels/palestrante_viewmodel.dart';
import '../../viewmodels/programacao_viewmodel.dart';
import '../../widgets/atividade_card.dart';
import '../../widgets/botao_agenda.dart';
import '../programacao/atividade_detail_view.dart';

/// Tela 2 do Módulo 5: escolher atividades da programação para a agenda.
class AdicionarAtividadeView extends StatelessWidget {
  final AgendaViewModel agendaViewModel;
  final ProgramacaoViewModel programacaoViewModel;
  final PalestranteViewModel palestranteViewModel;

  const AdicionarAtividadeView({
    super.key,
    required this.agendaViewModel,
    required this.programacaoViewModel,
    required this.palestranteViewModel,
  });

  @override
  Widget build(BuildContext context) {
    final atividades = programacaoViewModel.atividades;

    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar à Agenda')),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: atividades.length,
        itemBuilder: (context, index) {
          final atividade = atividades[index];
          return AtividadeCard(
            atividade: atividade,
            mostrarData: true,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AtividadeDetailView(
                  atividadeId: atividade.id,
                  viewModel: programacaoViewModel,
                  agendaViewModel: agendaViewModel,
                  palestranteViewModel: palestranteViewModel,
                ),
              ),
            ),
            trailing: BotaoAgenda(
              atividade: atividade,
              agendaViewModel: agendaViewModel,
            ),
          );
        },
      ),
    );
  }
}
