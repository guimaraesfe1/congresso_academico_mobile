import 'package:flutter/material.dart';

/// Foto circular do palestrante com ícone de fallback enquanto carrega
/// ou quando a imagem não está disponível.
class PalestranteAvatar extends StatelessWidget {
  final String url;
  final double tamanho;

  const PalestranteAvatar({super.key, required this.url, this.tamanho = 48});

  @override
  Widget build(BuildContext context) {
    final fallback = Center(
      child: Icon(Icons.person, size: tamanho * 0.6, color: Colors.grey),
    );

    return Container(
      width: tamanho,
      height: tamanho,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFE0E0E0),
      ),
      child: ClipOval(
        child: Image.network(
          url,
          fit: BoxFit.cover,
          semanticLabel: 'Foto do palestrante',
          loadingBuilder: (context, child, progresso) =>
              progresso == null ? child : fallback,
          errorBuilder: (context, error, stackTrace) => fallback,
        ),
      ),
    );
  }
}
