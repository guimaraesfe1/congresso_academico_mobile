import 'package:flutter/material.dart';

import '../../models/palestrante.dart';
import '../../viewmodels/palestrante_viewmodel.dart';
import '../../widgets/campo_texto.dart';

/// Tela 3 do Módulo 2: cadastro de um novo palestrante.
class CadastroPalestranteView extends StatefulWidget {
  final PalestranteViewModel viewModel;

  const CadastroPalestranteView({super.key, required this.viewModel});

  @override
  State<CadastroPalestranteView> createState() => _CadastroPalestranteViewState();
}

class _CadastroPalestranteViewState extends State<CadastroPalestranteView> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _fotoUrlController = TextEditingController();
  final _instituicaoController = TextEditingController();
  final _areaAtuacaoController = TextEditingController();
  final _temaPalestraController = TextEditingController();
  final _infoAdicionaisController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _fotoUrlController.dispose();
    _instituicaoController.dispose();
    _areaAtuacaoController.dispose();
    _temaPalestraController.dispose();
    _infoAdicionaisController.dispose();
    super.dispose();
  }

  String? _obrigatorio(String? valor, String campo) =>
      valor == null || valor.trim().isEmpty ? 'Informe $campo' : null;

  void _salvarPalestrante() {
    if (!_formKey.currentState!.validate()) return;

    final novoPalestrante = Palestrante(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nome: _nomeController.text.trim(),
      fotoUrl: _fotoUrlController.text.trim().isNotEmpty
          ? _fotoUrlController.text.trim()
          : 'https://i.pravatar.cc/300?img=60',
      instituicao: _instituicaoController.text.trim(),
      areaAtuacao: _areaAtuacaoController.text.trim(),
      temaPalestra: _temaPalestraController.text.trim(),
      informacoesAdicionais: _infoAdicionaisController.text.trim(),
    );

    widget.viewModel.adicionarPalestrante(novoPalestrante);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${novoPalestrante.nome} cadastrado(a)!')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Palestrante')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CampoTexto(
                controller: _nomeController,
                label: 'Nome Completo',
                icone: Icons.person_outline,
                validator: (v) => _obrigatorio(v, 'o nome'),
              ),
              CampoTexto(
                controller: _instituicaoController,
                label: 'Instituição',
                icone: Icons.school_outlined,
                validator: (v) => _obrigatorio(v, 'a instituição'),
              ),
              CampoTexto(
                controller: _areaAtuacaoController,
                label: 'Área de Atuação',
                icone: Icons.category_outlined,
                validator: (v) => _obrigatorio(v, 'a área de atuação'),
              ),
              CampoTexto(
                controller: _temaPalestraController,
                label: 'Tema da Palestra',
                icone: Icons.record_voice_over_outlined,
                validator: (v) => _obrigatorio(v, 'o tema da palestra'),
              ),
              CampoTexto(
                controller: _fotoUrlController,
                label: 'URL da Foto (opcional)',
                icone: Icons.image_outlined,
                keyboardType: TextInputType.url,
              ),
              CampoTexto(
                controller: _infoAdicionaisController,
                label: 'Informações Adicionais',
                maxLines: 3,
                validator: (v) => _obrigatorio(v, 'informações adicionais'),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: _salvarPalestrante,
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                icon: const Icon(Icons.save_outlined),
                label: const Text('Salvar Palestrante'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
