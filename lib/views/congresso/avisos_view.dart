import 'package:flutter/material.dart';
import '../../models/aviso_model.dart';
import '../../viewmodels/avisos_viewmodel.dart';
import '../../widgets/aviso_card.dart';

/// View responsável por exibir o Mural de Avisos sobre Palestras,
/// Mudanças de Sala, Pós-Graduação e Certificados do 22º Congresso UNIMAM 2026.
class AvisosView extends StatelessWidget {
  final AvisosViewModel viewModel;

  const AvisosView({
    super.key,
    required this.viewModel,
  });

  void _abrirDialogNovoAviso(BuildContext context) {
    final tituloCtrl = TextEditingController();
    final mensagemCtrl = TextEditingController();
    final localCtrl = TextEditingController(text: 'Auditório Central UNIMAM');
    CategoriaAviso categoriaSelecionada = CategoriaAviso.palestra;
    bool urgente = false;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => AlertDialog(
          title: const Text('Publicar Aviso do Congresso'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: tituloCtrl,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Título do Aviso',
                    hintText: 'Ex: Início da Palestra Magna no Auditório A',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: mensagemCtrl,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Comunicado detalhado',
                    hintText:
                        'Informe detalhes sobre horário, palestrante ou sala...',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<CategoriaAviso>(
                  initialValue: categoriaSelecionada,
                  decoration: const InputDecoration(
                    labelText: 'Categoria do Aviso',
                    border: OutlineInputBorder(),
                  ),
                  items: CategoriaAviso.values
                      .map(
                        (c) => DropdownMenuItem(
                          value: c,
                          child: Text(c.label),
                        ),
                      )
                      .toList(),
                  onChanged: (valor) {
                    if (valor != null) {
                      setModalState(() => categoriaSelecionada = valor);
                    }
                  },
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: localCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Auditório / Bloco de Referência',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Marcar como Aviso Urgente'),
                  value: urgente,
                  onChanged: (val) => setModalState(() => urgente = val),
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
                viewModel.publicarAviso(
                  titulo: tituloCtrl.text,
                  mensagem: mensagemCtrl.text,
                  localOuReferencia: localCtrl.text,
                  categoria: categoriaSelecionada,
                  urgente: urgente,
                );
                Navigator.of(ctx).pop();
              },
              child: const Text('Publicar'),
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
        final avisos = viewModel.avisosFiltrados;

        return Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
                child: Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: 8,
                        children: FiltroAviso.values.map((filtro) {
                          return ChoiceChip(
                            label: Text(filtro.label),
                            selected: viewModel.filtroAtual == filtro,
                            onSelected: (_) => viewModel.definirFiltro(filtro),
                          );
                        }).toList(),
                      ),
                    ),
                    if (viewModel.quantidadeNaoLidos > 0)
                      TextButton.icon(
                        onPressed: viewModel.marcarTodosComoLidos,
                        icon: const Icon(Icons.done_all_rounded, size: 18),
                        label: const Text('Ler todos'),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: avisos.isEmpty
                    ? const Center(
                        child: Text(
                          'Nenhum aviso encontrado para este filtro.',
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 6, 16, 84),
                        itemCount: avisos.length,
                        itemBuilder: (context, index) {
                          final aviso = avisos[index];
                          return AvisoCard(
                            aviso: aviso,
                            onAlternarLido: () =>
                                viewModel.alternarLido(aviso.id),
                            onRemover: () => viewModel.removerAviso(aviso.id),
                          );
                        },
                      ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _abrirDialogNovoAviso(context),
            icon: const Icon(Icons.add_alert_rounded),
            label: const Text('Novo Aviso'),
          ),
        );
      },
    );
  }
}
