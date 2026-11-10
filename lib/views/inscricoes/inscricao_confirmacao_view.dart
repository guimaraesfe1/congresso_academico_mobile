import 'package:flutter/material.dart';

import '../../models/inscricao.dart';
import '../../widgets/info_tile.dart';

/// Tela 3 do Módulo 3: confirmação da inscrição realizada.
class InscricaoConfirmacaoView extends StatelessWidget {
  final Inscricao inscricao;

  const InscricaoConfirmacaoView({super.key, required this.inscricao});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inscrição Confirmada')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 72),
            const SizedBox(height: 12),
            const Text(
              'Inscrição realizada com sucesso!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            InfoTile(icon: Icons.person_outline, label: 'Nome', value: inscricao.nome),
            const SizedBox(height: 12),
            InfoTile(icon: Icons.email_outlined, label: 'E-mail', value: inscricao.email),
            const SizedBox(height: 12),
            InfoTile(icon: Icons.menu_book_outlined, label: 'Curso', value: inscricao.curso),
            const SizedBox(height: 12),
            InfoTile(
              icon: Icons.school_outlined,
              label: 'Instituição',
              value: inscricao.instituicao,
            ),
            const SizedBox(height: 12),
            InfoTile(
              icon: Icons.badge_outlined,
              label: 'Tipo de participante',
              value: inscricao.tipoParticipante,
            ),
            const SizedBox(height: 32),
            FilledButton(
              style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(50)),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Voltar para Inscrições'),
            ),
          ],
        ),
      ),
    );
  }
}
