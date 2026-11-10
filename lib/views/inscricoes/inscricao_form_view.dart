import 'package:flutter/material.dart';

import '../../viewmodels/inscricao_viewmodel.dart';
import '../../widgets/campo_texto.dart';
import 'inscricao_confirmacao_view.dart';

/// Tela 2 do Módulo 3: formulário de inscrição.
class InscricaoFormView extends StatefulWidget {
  final InscricaoViewModel viewModel;

  const InscricaoFormView({super.key, required this.viewModel});

  @override
  State<InscricaoFormView> createState() => _InscricaoFormViewState();
}

class _InscricaoFormViewState extends State<InscricaoFormView> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cursoController = TextEditingController();
  final _instituicaoController = TextEditingController();
  String _tipoParticipante = InscricaoViewModel.tiposParticipante.first;

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _cursoController.dispose();
    _instituicaoController.dispose();
    super.dispose();
  }

  void _enviar() {
    if (!_formKey.currentState!.validate()) return;

    final inscricao = widget.viewModel.enviarInscricao(
      nome: _nomeController.text,
      email: _emailController.text,
      curso: _cursoController.text,
      instituicao: _instituicaoController.text,
      tipoParticipante: _tipoParticipante,
    );

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => InscricaoConfirmacaoView(inscricao: inscricao),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = widget.viewModel;

    return Scaffold(
      appBar: AppBar(title: const Text('Formulário de Inscrição')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CampoTexto(
                controller: _nomeController,
                label: 'Nome',
                icone: Icons.person_outline,
                validator: (v) => vm.validarObrigatorio(v, 'o nome'),
              ),
              CampoTexto(
                controller: _emailController,
                label: 'E-mail',
                icone: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: vm.validarEmail,
              ),
              CampoTexto(
                controller: _cursoController,
                label: 'Curso',
                icone: Icons.menu_book_outlined,
                validator: (v) => vm.validarObrigatorio(v, 'o curso'),
              ),
              CampoTexto(
                controller: _instituicaoController,
                label: 'Instituição',
                icone: Icons.school_outlined,
                validator: (v) => vm.validarObrigatorio(v, 'a instituição'),
              ),
              DropdownButtonFormField<String>(
                initialValue: _tipoParticipante,
                decoration: const InputDecoration(
                  labelText: 'Tipo de participante',
                  prefixIcon: Icon(Icons.badge_outlined),
                ),
                items: [
                  for (final tipo in InscricaoViewModel.tiposParticipante)
                    DropdownMenuItem(value: tipo, child: Text(tipo)),
                ],
                onChanged: (valor) => setState(() => _tipoParticipante = valor!),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _enviar,
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                icon: const Icon(Icons.send_rounded),
                label: const Text('Enviar Inscrição'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
