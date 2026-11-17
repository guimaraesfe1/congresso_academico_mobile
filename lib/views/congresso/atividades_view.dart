import 'package:flutter/material.dart';
import '../../models/atividade_model.dart';
import '../../viewmodels/atividades_viewmodel.dart';
import '../../widgets/atividade_model_card.dart';

/// View responsável por listar, filtrar e cadastrar Palestras e Atividades
/// do 22º Congresso Estudantil de Pesquisa e Pós-Graduação da UNIMAM 2026.
class AtividadesView extends StatelessWidget {
  final AtividadesViewModel viewModel;

  const AtividadesView({
    super.key,
    required this.viewModel,
  });

  void _mostrarDetalhesAtividade(
      BuildContext context, AtividadeModel atividade) {
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Chip(
              label: Text(atividade.tipo.label),
              avatar: const Icon(Icons.school_rounded, size: 16),
            ),
            const SizedBox(height: 8),
            Text(
              atividade.titulo,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.primaryContainer,
                child: Icon(Icons.person_rounded,
                    color: theme.colorScheme.onPrimaryContainer),
              ),
              title: Text(
                atividade.palestrante,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(atividade.titulacaoPalestrante),
            ),
            const Divider(),
            const SizedBox(height: 8),
            Text(
              'Resumo da Atividade',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              atividade.descricao,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.45),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                const Icon(Icons.calendar_month_outlined, size: 18),
                const SizedBox(width: 6),
                Text('${atividade.data} • ${atividade.horario}'),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 18),
                const SizedBox(width: 6),
                Expanded(child: Text(atividade.local)),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  viewModel.alternarInscricao(atividade.id);
                  Navigator.of(ctx).pop();
                },
                icon: Icon(
                  atividade.inscrito
                      ? Icons.remove_circle_outline_rounded
                      : Icons.check_circle_outline_rounded,
                ),
                label: Text(
                  atividade.inscrito
                      ? 'Cancelar inscrição nesta atividade'
                      : 'Confirmar inscrição na atividade',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _abrirModalNovaAtividade(BuildContext context) {
    final tituloCtrl = TextEditingController();
    final palestranteCtrl = TextEditingController();
    final horarioCtrl = TextEditingController(text: '20/11 • 14:00 às 17:00');
    final localCtrl = TextEditingController(text: 'Auditório Central UNIMAM');
    TipoAtividade tipoSelecionado = TipoAtividade.palestra;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => AlertDialog(
          title: const Text('Nova Palestra / Atividade'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: tituloCtrl,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Título da palestra ou atividade',
                    hintText: 'Ex: Simpósio de IA na Saúde',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: palestranteCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Palestrante / Mediador',
                    hintText: 'Ex: Prof. Dr. Carlos Silva (UNIMAM)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<TipoAtividade>(
                  initialValue: tipoSelecionado,
                  decoration: const InputDecoration(
                    labelText: 'Modalidade',
                    border: OutlineInputBorder(),
                  ),
                  items: TipoAtividade.values
                      .map(
                        (tipo) => DropdownMenuItem(
                          value: tipo,
                          child: Text(tipo.label),
                        ),
                      )
                      .toList(),
                  onChanged: (valor) {
                    if (valor != null) {
                      setModalState(() => tipoSelecionado = valor);
                    }
                  },
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: horarioCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Horário',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: localCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Local / Bloco UNIMAM',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                viewModel.adicionarAtividade(
                  titulo: tituloCtrl.text,
                  palestrante: palestranteCtrl.text,
                  horario: horarioCtrl.text,
                  local: localCtrl.text,
                  tipo: tipoSelecionado,
                );
                Navigator.of(ctx).pop();
              },
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final atividades = viewModel.atividadesFiltradas;

        return Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
                child: TextField(
                  onChanged: viewModel.atualizarBusca,
                  decoration: InputDecoration(
                    hintText: 'Buscar palestra, palestrante ou auditório...',
                    prefixIcon: const Icon(Icons.search_rounded),
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 46,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: const Text('Todas'),
                        selected: viewModel.filtroTipo == null,
                        onSelected: (_) => viewModel.definirFiltroTipo(null),
                      ),
                    ),
                    ...TipoAtividade.values.map(
                      (tipo) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(tipo.label),
                          selected: viewModel.filtroTipo == tipo,
                          onSelected: (_) => viewModel.definirFiltroTipo(
                            viewModel.filtroTipo == tipo ? null : tipo,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Expanded(
                child: atividades.isEmpty
                    ? const Center(
                        child: Text(
                          'Nenhuma palestra ou atividade encontrada para o filtro.',
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 6, 16, 84),
                        itemCount: atividades.length,
                        itemBuilder: (context, index) {
                          final item = atividades[index];
                          return AtividadeModelCard(
                            atividade: item,
                            onAlternarInscricao: () =>
                                viewModel.alternarInscricao(item.id),
                            onAlternarPresenca: (val) => viewModel
                                .alternarPresencaConfirmada(item.id, val),
                            onRemover: () => viewModel.removerAtividade(item.id),
                            onTapDetalhes: () =>
                                _mostrarDetalhesAtividade(context, item),
                          );
                        },
                      ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _abrirModalNovaAtividade(context),
            icon: const Icon(Icons.add_rounded),
            label: const Text('Nova Atividade'),
          ),
        );
      },
    );
  }
}
