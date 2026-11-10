import 'package:flutter/material.dart';

import '../../models/atividade.dart';
import '../../theme/app_theme.dart';
import '../../viewmodels/agenda_viewmodel.dart';
import '../../viewmodels/palestrante_viewmodel.dart';
import '../../viewmodels/programacao_viewmodel.dart';
import '../../widgets/botao_agenda.dart';
import '../../widgets/info_tile.dart';
import '../../widgets/palestrante_avatar.dart';
import '../../widgets/tipo_atividade_badge.dart';
import '../palestrantes/palestrante_detail_view.dart';

/// Tela 2 do Módulo 1: detalhes completos de uma atividade.
class AtividadeDetailView extends StatelessWidget {
  final String atividadeId;
  final ProgramacaoViewModel viewModel;
  final AgendaViewModel agendaViewModel;
  final PalestranteViewModel palestranteViewModel;

  const AtividadeDetailView({
    super.key,
    required this.atividadeId,
    required this.viewModel,
    required this.agendaViewModel,
    required this.palestranteViewModel,
  });

  @override
  Widget build(BuildContext context) {
    final atividade = viewModel.buscarPorId(atividadeId);

    if (atividade == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Atividade')),
        body: const Center(child: Text('Atividade não encontrada.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes da Atividade')),
      body: ListenableBuilder(
        listenable: agendaViewModel,
        builder: (context, _) {
          final conflito = agendaViewModel.conflitoCom(atividade);

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TipoAtividadeBadge(tipo: atividade.tipo),
              ),
              const SizedBox(height: 10),
              Text(
                atividade.titulo,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textoForte,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 16),
              _Secao(
                child: Column(
                  children: [
                    InfoTile(
                      icon: Icons.calendar_today_rounded,
                      label: 'Data',
                      value: atividade.dataFormatada,
                    ),
                    const Divider(height: 20),
                    InfoTile(
                      icon: Icons.schedule_rounded,
                      label: 'Horário',
                      value:
                          '${atividade.horarioFormatado} (${atividade.duracaoMinutos} min)',
                    ),
                    const Divider(height: 20),
                    InfoTile(
                      icon: Icons.location_on_outlined,
                      label: 'Local',
                      value: atividade.local,
                    ),
                    const Divider(height: 20),
                    InfoTile(
                      icon: Icons.groups_outlined,
                      label: 'Vagas',
                      value: '${atividade.vagas}',
                    ),
                  ],
                ),
              ),
              if (conflito != null) ...[
                const SizedBox(height: 12),
                _AvisoConflito(conflito: conflito),
              ],
              const SizedBox(height: 16),
              const _Titulo('Sobre a atividade'),
              _Secao(
                child: Text(
                  atividade.descricao,
                  style: const TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              const SizedBox(height: 16),
              const _Titulo('Responsável'),
              _Responsavel(
                atividade: atividade,
                palestranteViewModel: palestranteViewModel,
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: ListenableBuilder(
            listenable: agendaViewModel,
            builder: (context, _) {
              final naAgenda = agendaViewModel.contem(atividade.id);
              return FilledButton.icon(
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor:
                      naAgenda ? AppColors.secundaria : AppColors.primaria,
                ),
                icon: Icon(
                  naAgenda ? Icons.event_available_rounded : Icons.event_outlined,
                ),
                label: Text(
                  naAgenda ? 'Remover da Minha Agenda' : 'Adicionar à Minha Agenda',
                ),
                onPressed: () =>
                    BotaoAgenda.alternar(context, atividade, agendaViewModel),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Responsavel extends StatelessWidget {
  final Atividade atividade;
  final PalestranteViewModel palestranteViewModel;

  const _Responsavel({
    required this.atividade,
    required this.palestranteViewModel,
  });

  @override
  Widget build(BuildContext context) {
    final id = atividade.palestranteId;
    final palestrante = id == null ? null : palestranteViewModel.buscarPorId(id);

    if (palestrante == null) {
      return _Secao(
        child: InfoTile(
          icon: Icons.person_outline,
          label: 'Ministrado por',
          value: atividade.responsavel,
        ),
      );
    }

    // Quando o responsável é um palestrante cadastrado, abre o perfil dele.
    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        leading: PalestranteAvatar(url: palestrante.fotoUrl),
        title: Text(
          palestrante.nome,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(palestrante.instituicao),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PalestranteDetailView(palestrante: palestrante),
          ),
        ),
      ),
    );
  }
}

class _AvisoConflito extends StatelessWidget {
  final Atividade conflito;

  const _AvisoConflito({required this.conflito});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4E5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFF5C27A)),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Color(0xFFB45309)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Conflito de horário com "${conflito.titulo}", que já está na sua agenda.',
              style: const TextStyle(fontSize: 13, color: Color(0xFF7C3A00)),
            ),
          ),
        ],
      ),
    );
  }
}

class _Titulo extends StatelessWidget {
  final String texto;

  const _Titulo(this.texto);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        texto,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.textoForte,
        ),
      ),
    );
  }
}

class _Secao extends StatelessWidget {
  final Widget child;

  const _Secao({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borda),
      ),
      child: child,
    );
  }
}
