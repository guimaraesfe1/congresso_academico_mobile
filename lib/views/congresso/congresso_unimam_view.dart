import 'package:flutter/material.dart';

import '../../data/congresso_repository.dart';
import '../../theme/congresso_theme.dart';
import '../../viewmodels/atividades_viewmodel.dart';
import '../../viewmodels/avisos_viewmodel.dart';
import '../../viewmodels/congresso_viewmodel.dart';
import '../../viewmodels/theme_viewmodel.dart';
import 'main_shell_view.dart';

/// Módulo do 22º Congresso Estudantil UNIMAM 2026.
///
/// Cria os ViewModels do módulo e aplica o tema verde da UNIMAM
/// (claro/escuro) apenas a esta parte do aplicativo.
class CongressoUnimamView extends StatefulWidget {
  const CongressoUnimamView({super.key});

  @override
  State<CongressoUnimamView> createState() => _CongressoUnimamViewState();
}

class _CongressoUnimamViewState extends State<CongressoUnimamView> {
  final _repository = CongressoRepository();
  final _themeViewModel = ThemeViewModel();
  late final _congressoViewModel = CongressoViewModel(repository: _repository);
  late final _atividadesViewModel = AtividadesViewModel(repository: _repository);
  late final _avisosViewModel = AvisosViewModel(repository: _repository);

  @override
  void dispose() {
    _themeViewModel.dispose();
    _congressoViewModel.dispose();
    _atividadesViewModel.dispose();
    _avisosViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _themeViewModel,
      builder: (context, _) => Theme(
        data: _themeViewModel.isDarkMode
            ? CongressoTheme.darkTheme
            : CongressoTheme.lightTheme,
        child: MainShellView(
          congressoViewModel: _congressoViewModel,
          atividadesViewModel: _atividadesViewModel,
          avisosViewModel: _avisosViewModel,
          themeViewModel: _themeViewModel,
        ),
      ),
    );
  }
}
