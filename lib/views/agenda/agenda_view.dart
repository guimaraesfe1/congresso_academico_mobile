import 'package:flutter/material.dart';

import '../../models/item_agenda.dart';
import '../../theme/app_theme.dart';
import '../../viewmodels/agenda_viewmodel.dart';
import '../../viewmodels/palestrante_viewmodel.dart';
import '../../viewmodels/programacao_viewmodel.dart';
import '../../widgets/atividade_card.dart';
import '../../widgets/empty_state.dart';
import '../programacao/atividade_detail_view.dart';
import 'adicionar_atividade_view.dart';

/// Tela 1 do Módulo 5: atividades que o participante adicionou à agenda.
class AgendaView extends StatelessWidget {
  final AgendaViewModel viewModel;
  final ProgramacaoViewModel programacaoViewModel;
  final PalestranteViewModel palestranteViewModel;

  const AgendaView({
    super.key,
    required this.viewModel,
    required this.programacaoViewModel,
    required this.palestranteViewModel,
  });

  void _abrirAdicionar(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AdicionarAtividadeView(
          agendaViewModel: viewModel,
          programacaoViewModel: programacaoViewModel,
          palestranteViewModel: palestranteViewModel,
        ),
      ),
    );
  }

  void _remover(BuildContext context, ItemAgenda item) {
    viewModel.remover(item.atividade.id);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('"${item.atividade.titulo}" removida da agenda.'),
          action: SnackBarAction(
            label: 'Desfazer',
            textColor: AppColors.containerClaro,
            onPressed: () {
              viewModel.adicionar(item.atividade);
              if (item.favorita) viewModel.alternarFavorita(item.atividade.id);
            },
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final itens = viewModel.itens;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Minha Agenda'),
            actions: [
              IconButton(
                tooltip: viewModel.somenteFavoritas
                    ? 'Mostrar todas'
                    : 'Mostrar somente favoritas',
                icon: Icon(
                  viewModel.somenteFavoritas
                      ? Icons.star_rounded
                      : Icons.star_border_rounded,
                ),
                onPressed: viewModel.alternarFiltroFavoritas,
              ),
            ],
          ),
          body: Column(
            children: [
              _Resumo(viewModel: viewModel),
              Expanded(
                child: itens.isEmpty
                    ? EmptyState(
                        icon: viewModel.somenteFavoritas
                            ? Icons.star_border_rounded
                            : Icons.event_note_outlined,
                        title: viewModel.somenteFavoritas
                            ? 'Nenhuma atividade favorita'
                            : 'Sua agenda está vazia',
                        message: viewModel.somenteFavoritas
                            ? 'Toque na estrela de uma atividade para favoritá-la.'
                            : 'Adicione atividades da programação para organizar sua participação.',
                        actionLabel: viewModel.somenteFavoritas
                            ? 'Mostrar todas'
                            : 'Adicionar atividades',
                        onAction: viewModel.somenteFavoritas
                            ? viewModel.alternarFiltroFavoritas
                            : () => _abrirAdicionar(context),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 90),
                        itemCount: itens.length,
                        itemBuilder: (context, index) {
                          final item = itens[index];
                          return Dismissible(
                            key: ValueKey(item.atividade.id),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 24),
                              color: Colors.red.shade400,
                              child: const Icon(Icons.delete_outline,
                                  color: Colors.white),
                            ),
                            onDismissed: (_) => _remover(context, item),
                            child: AtividadeCard(
                              atividade: item.atividade,
                              mostrarData: true,
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => AtividadeDetailView(
                                    atividadeId: item.atividade.id,
                                    viewModel: programacaoViewModel,
                                    agendaViewModel: viewModel,
                                    palestranteViewModel: palestranteViewModel,
                                  ),
                                ),
                              ),
                              trailing: Column(
                                children: [
                                  IconButton(
                                    tooltip: item.favorita
                                        ? 'Remover dos favoritos'
                                        : 'Marcar como favorita',
                                    icon: Icon(
                                      item.favorita
                                          ? Icons.star_rounded
                                          : Icons.star_border_rounded,
                                      color: item.favorita
                                          ? Colors.amber.shade700
                                          : Colors.grey.shade600,
                                    ),
                                    onPressed: () => viewModel
                                        .alternarFavorita(item.atividade.id),
                                  ),
                                  IconButton(
                                    tooltip: 'Remover da agenda',
                                    icon: const Icon(Icons.delete_outline,
                                        color: Colors.redAccent),
                                    onPressed: () => _remover(context, item),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _abrirAdicionar(context),
            icon: const Icon(Icons.add),
            label: const Text('Adicionar'),
          ),
        );
      },
    );
  }
}

class _Resumo extends StatelessWidget {
  final AgendaViewModel viewModel;

  const _Resumo({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 12, 14, 6),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.superficieSuave,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borda),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _numero(Icons.event_available_rounded, viewModel.total, 'Na agenda'),
          _numero(Icons.star_rounded, viewModel.totalFavoritas, 'Favoritas'),
        ],
      ),
    );
  }

  Widget _numero(IconData icone, int valor, String rotulo) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icone, size: 18, color: AppColors.primaria),
            const SizedBox(width: 4),
            Text(
              '$valor',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textoForte,
              ),
            ),
          ],
        ),
        Text(rotulo, style: const TextStyle(fontSize: 12, color: AppColors.textoSuave)),
      ],
    );
  }
}
