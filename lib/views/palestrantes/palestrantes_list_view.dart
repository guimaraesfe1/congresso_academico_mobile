import 'package:flutter/material.dart';

import '../../viewmodels/palestrante_viewmodel.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/palestrante_card.dart';
import 'cadastro_palestrante_view.dart';
import 'palestrante_detail_view.dart';

/// Tela 1 do Módulo 2: lista de palestrantes.
class PalestrantesListView extends StatelessWidget {
  final PalestranteViewModel viewModel;

  const PalestrantesListView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Palestrantes')),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          final palestrantes = viewModel.palestrantes;

          if (palestrantes.isEmpty) {
            return const EmptyState(
              icon: Icons.person_off_outlined,
              title: 'Nenhum palestrante cadastrado',
              message: 'Toque em "Novo" para cadastrar o primeiro palestrante.',
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 80),
            itemCount: palestrantes.length,
            itemBuilder: (context, index) {
              final palestrante = palestrantes[index];
              return PalestranteCard(
                palestrante: palestrante,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        PalestranteDetailView(palestrante: palestrante),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.person_add),
        label: const Text('Novo'),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => CadastroPalestranteView(viewModel: viewModel),
          ),
        ),
      ),
    );
  }
}
