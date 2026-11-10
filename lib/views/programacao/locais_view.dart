import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../viewmodels/agenda_viewmodel.dart';
import '../../viewmodels/palestrante_viewmodel.dart';
import '../../viewmodels/programacao_viewmodel.dart';
import '../../widgets/atividade_card.dart';
import '../../widgets/botao_agenda.dart';
import 'atividade_detail_view.dart';

/// Tela 3 do Módulo 1: atividades agrupadas pelo local onde acontecem.
class LocaisView extends StatelessWidget {
  final ProgramacaoViewModel viewModel;
  final AgendaViewModel agendaViewModel;
  final PalestranteViewModel palestranteViewModel;

  const LocaisView({
    super.key,
    required this.viewModel,
    required this.agendaViewModel,
    required this.palestranteViewModel,
  });

  @override
  Widget build(BuildContext context) {
    final locais = viewModel.atividadesPorLocal.entries.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Locais das Atividades')),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: locais.length,
        itemBuilder: (context, index) {
          final local = locais[index];
          return ExpansionTile(
            initiallyExpanded: index == 0,
            leading: const Icon(Icons.place_rounded, color: AppColors.primaria),
            title: Text(
              local.key,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${local.value.length} atividade(s)'),
            children: [
              for (final atividade in local.value)
                AtividadeCard(
                  atividade: atividade,
                  mostrarData: true,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AtividadeDetailView(
                        atividadeId: atividade.id,
                        viewModel: viewModel,
                        agendaViewModel: agendaViewModel,
                        palestranteViewModel: palestranteViewModel,
                      ),
                    ),
                  ),
                  trailing: BotaoAgenda(
                    atividade: atividade,
                    agendaViewModel: agendaViewModel,
                  ),
                ),
              const SizedBox(height: 8),
            ],
          );
        },
      ),
    );
  }
}
