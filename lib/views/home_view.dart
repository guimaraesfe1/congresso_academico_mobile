import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../viewmodels/agenda_viewmodel.dart';
import '../viewmodels/inscricao_viewmodel.dart';
import '../viewmodels/palestrante_viewmodel.dart';
import '../viewmodels/papers_viewmodel.dart';
import '../viewmodels/programacao_viewmodel.dart';
import '../widgets/modulo_card.dart';
import 'agenda/agenda_view.dart';
import 'inscricoes/inscricao_home_view.dart';
import 'palestrantes/palestrantes_list_view.dart';
import 'programacao/programacao_view.dart';
import 'trabalhos/papers_list_view.dart';

/// Tela inicial do aplicativo: dá acesso a todos os módulos do congresso.
class HomeView extends StatelessWidget {
  final ProgramacaoViewModel programacaoViewModel;
  final PalestranteViewModel palestranteViewModel;
  final InscricaoViewModel inscricaoViewModel;
  final PapersViewModel papersViewModel;
  final AgendaViewModel agendaViewModel;

  const HomeView({
    super.key,
    required this.programacaoViewModel,
    required this.palestranteViewModel,
    required this.inscricaoViewModel,
    required this.papersViewModel,
    required this.agendaViewModel,
  });

  void _abrir(BuildContext context, Widget tela) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => tela));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: _Cabecalho()),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 220,
                mainAxisExtent: 168,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              delegate: SliverChildListDelegate([
                ModuloCard(
                  icone: Icons.calendar_month_rounded,
                  titulo: 'Programação',
                  descricao: 'Palestras, workshops e minicursos',
                  onTap: () => _abrir(
                    context,
                    ProgramacaoView(
                      viewModel: programacaoViewModel,
                      agendaViewModel: agendaViewModel,
                      palestranteViewModel: palestranteViewModel,
                    ),
                  ),
                ),
                ModuloCard(
                  icone: Icons.people_alt_rounded,
                  titulo: 'Palestrantes',
                  descricao: 'Conheça quem vai apresentar',
                  onTap: () => _abrir(
                    context,
                    PalestrantesListView(viewModel: palestranteViewModel),
                  ),
                ),
                ModuloCard(
                  icone: Icons.how_to_reg_rounded,
                  titulo: 'Inscrições',
                  descricao: 'Garanta sua participação',
                  onTap: () => _abrir(
                    context,
                    InscricaoHomeView(viewModel: inscricaoViewModel),
                  ),
                ),
                ModuloCard(
                  icone: Icons.article_rounded,
                  titulo: 'Trabalhos',
                  descricao: 'Trabalhos acadêmicos submetidos',
                  onTap: () => _abrir(
                    context,
                    PapersListView(viewModel: papersViewModel),
                  ),
                ),
                ListenableBuilder(
                  listenable: agendaViewModel,
                  builder: (context, _) => ModuloCard(
                    icone: Icons.event_note_rounded,
                    titulo: 'Minha Agenda',
                    descricao: 'Suas atividades e favoritas',
                    contador: agendaViewModel.total,
                    onTap: () => _abrir(
                      context,
                      AgendaView(
                        viewModel: agendaViewModel,
                        programacaoViewModel: programacaoViewModel,
                        palestranteViewModel: palestranteViewModel,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _Cabecalho extends StatelessWidget {
  const _Cabecalho();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaria,
      padding: EdgeInsets.fromLTRB(
        20,
        MediaQuery.paddingOf(context).top + 24,
        20,
        28,
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.school_rounded, color: AppColors.containerClaro, size: 40),
          SizedBox(height: 12),
          Text(
            'Congresso Acadêmico 2026',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Text(
            '24 a 26 de outubro • Campus Universitário',
            style: TextStyle(color: AppColors.containerClaro, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
