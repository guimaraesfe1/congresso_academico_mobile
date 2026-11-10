import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../viewmodels/inscricao_viewmodel.dart';
import '../../widgets/empty_state.dart';
import 'inscricao_form_view.dart';

/// Tela 1 do Módulo 3: resumo das inscrições realizadas.
class InscricaoHomeView extends StatelessWidget {
  final InscricaoViewModel viewModel;

  const InscricaoHomeView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inscrições')),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          final inscricoes = viewModel.inscricoes;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.superficieSuave,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.borda),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.how_to_reg_rounded,
                        size: 36, color: AppColors.primaria),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Total de inscrições realizadas: ${viewModel.total}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textoForte,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: inscricoes.isEmpty
                    ? const EmptyState(
                        icon: Icons.assignment_outlined,
                        title: 'Nenhuma inscrição ainda',
                        message: 'Faça sua inscrição para participar do congresso.',
                      )
                    : ListView.builder(
                        itemCount: inscricoes.length,
                        itemBuilder: (context, index) {
                          final inscricao = inscricoes[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: AppColors.containerClaro,
                              child: Text(inscricao.nome[0].toUpperCase()),
                            ),
                            title: Text(inscricao.nome),
                            subtitle: Text(
                              '${inscricao.tipoParticipante} • ${inscricao.instituicao}',
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.edit_note_rounded),
        label: const Text('Fazer Inscrição'),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => InscricaoFormView(viewModel: viewModel),
          ),
        ),
      ),
    );
  }
}
