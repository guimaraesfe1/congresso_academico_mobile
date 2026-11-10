import 'package:flutter/material.dart';

import '../../models/atividade.dart';
import '../../theme/app_theme.dart';
import '../../viewmodels/agenda_viewmodel.dart';
import '../../viewmodels/palestrante_viewmodel.dart';
import '../../viewmodels/programacao_viewmodel.dart';
import '../../widgets/atividade_card.dart';
import '../../widgets/botao_agenda.dart';
import '../../widgets/empty_state.dart';
import 'atividade_detail_view.dart';
import 'locais_view.dart';

/// Tela 1 do Módulo 1: lista da programação com filtros por dia e por tipo.
class ProgramacaoView extends StatelessWidget {
  final ProgramacaoViewModel viewModel;
  final AgendaViewModel agendaViewModel;
  final PalestranteViewModel palestranteViewModel;

  const ProgramacaoView({
    super.key,
    required this.viewModel,
    required this.agendaViewModel,
    required this.palestranteViewModel,
  });

  void _abrirDetalhe(BuildContext context, Atividade atividade) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AtividadeDetailView(
          atividadeId: atividade.id,
          viewModel: viewModel,
          agendaViewModel: agendaViewModel,
          palestranteViewModel: palestranteViewModel,
        ),
      ),
    );
  }

  void _abrirLocais(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LocaisView(
          viewModel: viewModel,
          agendaViewModel: agendaViewModel,
          palestranteViewModel: palestranteViewModel,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Programação'),
        actions: [
          IconButton(
            tooltip: 'Ver atividades por local',
            icon: const Icon(Icons.map_outlined),
            onPressed: () => _abrirLocais(context),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          final atividades = viewModel.atividadesFiltradas;

          return Column(
            children: [
              _FiltroDias(viewModel: viewModel),
              _FiltroTipos(viewModel: viewModel),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 4, 14, 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${atividades.length} atividade(s)',
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textoSuave,
                      ),
                    ),
                    if (viewModel.temFiltroAtivo)
                      TextButton(
                        onPressed: viewModel.limparFiltros,
                        child: const Text('Limpar filtros'),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: atividades.isEmpty
                    ? EmptyState(
                        icon: Icons.event_busy_rounded,
                        title: 'Nenhuma atividade encontrada',
                        message: 'Não há atividades para os filtros escolhidos.',
                        actionLabel: 'Limpar filtros',
                        onAction: viewModel.limparFiltros,
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 20),
                        itemCount: atividades.length,
                        itemBuilder: (context, index) {
                          final atividade = atividades[index];
                          return AtividadeCard(
                            atividade: atividade,
                            mostrarData: viewModel.diaSelecionado == null,
                            onTap: () => _abrirDetalhe(context, atividade),
                            trailing: BotaoAgenda(
                              atividade: atividade,
                              agendaViewModel: agendaViewModel,
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FiltroDias extends StatelessWidget {
  final ProgramacaoViewModel viewModel;

  const _FiltroDias({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final dias = viewModel.dias;

    return SizedBox(
      height: 52,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
        children: [
          _chip('Todos os dias', viewModel.diaSelecionado == null,
              () => viewModel.selecionarDia(null)),
          for (final dia in dias)
            _chip(
              ProgramacaoViewModel.rotuloDia(dia),
              viewModel.diaSelecionado == dia,
              () => viewModel.selecionarDia(dia),
            ),
        ],
      ),
    );
  }

  Widget _chip(String rotulo, bool selecionado, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: ChoiceChip(
        label: Text(rotulo),
        selected: selecionado,
        showCheckmark: false,
        selectedColor: AppColors.primaria,
        labelStyle: TextStyle(
          color: selecionado ? Colors.white : AppColors.primaria,
          fontWeight: selecionado ? FontWeight.bold : FontWeight.normal,
        ),
        onSelected: (_) => onTap(),
      ),
    );
  }
}

class _FiltroTipos extends StatelessWidget {
  final ProgramacaoViewModel viewModel;

  const _FiltroTipos({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(14, 6, 14, 0),
        children: [
          for (final tipo in TipoAtividade.values)
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: FilterChip(
                label: Text(
                  '${tipo.rotulo} (${viewModel.quantidadePorTipo(tipo)})',
                ),
                selected: viewModel.tipoSelecionado == tipo,
                onSelected: (selecionado) =>
                    viewModel.selecionarTipo(selecionado ? tipo : null),
              ),
            ),
        ],
      ),
    );
  }
}
