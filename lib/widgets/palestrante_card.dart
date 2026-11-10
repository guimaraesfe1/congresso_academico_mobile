import 'package:flutter/material.dart';

import '../models/palestrante.dart';
import 'palestrante_avatar.dart';

/// Card reutilizável com o resumo de um palestrante.
class PalestranteCard extends StatelessWidget {
  final Palestrante palestrante;
  final VoidCallback? onTap;

  const PalestranteCard({super.key, required this.palestrante, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: PalestranteAvatar(url: palestrante.fotoUrl),
        title: Text(
          palestrante.nome,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${palestrante.instituicao}\nTema: ${palestrante.temaPalestra}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        isThreeLine: true,
        trailing: onTap != null
            ? const Icon(Icons.arrow_forward_ios, size: 16)
            : null,
      ),
    );
  }
}
