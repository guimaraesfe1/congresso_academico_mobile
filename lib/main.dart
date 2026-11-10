import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'viewmodels/agenda_viewmodel.dart';
import 'viewmodels/inscricao_viewmodel.dart';
import 'viewmodels/palestrante_viewmodel.dart';
import 'viewmodels/papers_viewmodel.dart';
import 'viewmodels/programacao_viewmodel.dart';
import 'views/home_view.dart';

void main() {
  runApp(const CongressoApp());
}

/// Aplicativo do Congresso Acadêmico.
///
/// Os ViewModels são criados uma única vez aqui e repassados às telas,
/// para que o estado (agenda, inscrições, palestrantes...) seja
/// compartilhado entre os módulos durante toda a execução.
class CongressoApp extends StatefulWidget {
  const CongressoApp({super.key});

  @override
  State<CongressoApp> createState() => _CongressoAppState();
}

class _CongressoAppState extends State<CongressoApp> {
  final _programacaoViewModel = ProgramacaoViewModel();
  final _palestranteViewModel = PalestranteViewModel();
  final _inscricaoViewModel = InscricaoViewModel();
  final _papersViewModel = PapersViewModel();
  final _agendaViewModel = AgendaViewModel();

  @override
  void dispose() {
    _programacaoViewModel.dispose();
    _palestranteViewModel.dispose();
    _inscricaoViewModel.dispose();
    _papersViewModel.dispose();
    _agendaViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Congresso Acadêmico',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.tema,
      home: HomeView(
        programacaoViewModel: _programacaoViewModel,
        palestranteViewModel: _palestranteViewModel,
        inscricaoViewModel: _inscricaoViewModel,
        papersViewModel: _papersViewModel,
        agendaViewModel: _agendaViewModel,
      ),
    );
  }
}
