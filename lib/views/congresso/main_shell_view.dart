import 'package:flutter/material.dart';
import '../../viewmodels/atividades_viewmodel.dart';
import '../../viewmodels/avisos_viewmodel.dart';
import '../../viewmodels/congresso_viewmodel.dart';
import '../../viewmodels/theme_viewmodel.dart';
import 'atividades_view.dart';
import 'avisos_view.dart';
import 'congresso_home_view.dart';
import 'minha_agenda_view.dart';

/// View estrutural principal (Shell) que conecta os ViewModels às abas.
class MainShellView extends StatelessWidget {
  final CongressoViewModel congressoViewModel;
  final AtividadesViewModel atividadesViewModel;
  final AvisosViewModel avisosViewModel;
  final ThemeViewModel themeViewModel;

  const MainShellView({
    super.key,
    required this.congressoViewModel,
    required this.atividadesViewModel,
    required this.avisosViewModel,
    required this.themeViewModel,
  });

  static const List<String> _titulosAbas = [
    '22º Congresso UNIMAM 2026',
    'Palestras e Atividades',
    'Avisos do Congresso',
    'Minha Agenda & Credencial',
  ];

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        congressoViewModel,
        avisosViewModel,
        themeViewModel,
      ]),
      builder: (context, _) {
        final currentIndex = congressoViewModel.abaAtualIndex;
        final naoLidos = avisosViewModel.quantidadeNaoLidos;

        final telas = [
          CongressoHomeView(
            congressoViewModel: congressoViewModel,
            atividadesViewModel: atividadesViewModel,
            avisosViewModel: avisosViewModel,
          ),
          AtividadesView(viewModel: atividadesViewModel),
          AvisosView(viewModel: avisosViewModel),
          MinhaAgendaView(
            eventoInfo: congressoViewModel.eventoInfo,
            atividadesViewModel: atividadesViewModel,
          ),
        ];

        return Scaffold(
          appBar: AppBar(
            title: Text(
              _titulosAbas[currentIndex],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            actions: [
              IconButton(
                tooltip: 'Avisos do Congresso',
                onPressed: () => congressoViewModel.selecionarAba(2),
                icon: Badge(
                  isLabelVisible: naoLidos > 0,
                  label: Text('$naoLidos'),
                  child: const Icon(Icons.notifications_outlined),
                ),
              ),
              IconButton(
                tooltip: themeViewModel.isDarkMode
                    ? 'Ativar Tema Claro'
                    : 'Ativar Tema Escuro',
                icon: Icon(
                  themeViewModel.isDarkMode
                      ? Icons.light_mode_rounded
                      : Icons.dark_mode_rounded,
                ),
                onPressed: themeViewModel.alternarTema,
              ),
            ],
          ),
          body: IndexedStack(
            index: currentIndex,
            children: telas,
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: currentIndex,
            onDestinationSelected: congressoViewModel.selecionarAba,
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home_rounded),
                label: 'Início',
              ),
              const NavigationDestination(
                icon: Icon(Icons.mic_external_on_outlined),
                selectedIcon: Icon(Icons.mic_external_on_rounded),
                label: 'Palestras',
              ),
              NavigationDestination(
                icon: Badge(
                  isLabelVisible: naoLidos > 0,
                  label: Text('$naoLidos'),
                  child: const Icon(Icons.campaign_outlined),
                ),
                selectedIcon: Badge(
                  isLabelVisible: naoLidos > 0,
                  label: Text('$naoLidos'),
                  child: const Icon(Icons.campaign_rounded),
                ),
                label: 'Avisos',
              ),
              const NavigationDestination(
                icon: Icon(Icons.badge_outlined),
                selectedIcon: Icon(Icons.badge_rounded),
                label: 'Agenda',
              ),
            ],
          ),
        );
      },
    );
  }
}
