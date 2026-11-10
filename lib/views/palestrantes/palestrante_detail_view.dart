import 'package:flutter/material.dart';

import '../../models/palestrante.dart';
import '../../widgets/info_tile.dart';
import '../../widgets/palestrante_avatar.dart';

/// Tela 2 do Módulo 2: perfil completo do palestrante.
class PalestranteDetailView extends StatelessWidget {
  final Palestrante palestrante;

  const PalestranteDetailView({super.key, required this.palestrante});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(palestrante.nome)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            PalestranteAvatar(url: palestrante.fotoUrl, tamanho: 130),
            const SizedBox(height: 16),
            Text(
              palestrante.nome,
              textAlign: TextAlign.center,
              style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              palestrante.instituicao,
              textAlign: TextAlign.center,
              style: textTheme.titleMedium?.copyWith(color: Colors.grey[700]),
            ),
            const Divider(height: 32),
            InfoTile(
              icon: Icons.category,
              label: 'Área de Atuação',
              value: palestrante.areaAtuacao,
            ),
            const SizedBox(height: 16),
            InfoTile(
              icon: Icons.record_voice_over,
              label: 'Tema da Palestra',
              value: palestrante.temaPalestra,
            ),
            const SizedBox(height: 16),
            InfoTile(
              icon: Icons.info_outline,
              label: 'Informações Adicionais',
              value: palestrante.informacoesAdicionais,
            ),
          ],
        ),
      ),
    );
  }
}
