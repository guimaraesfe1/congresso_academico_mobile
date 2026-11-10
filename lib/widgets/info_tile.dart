import 'package:flutter/material.dart';

/// Widget reutilizável para exibir linhas estruturadas de metadados
/// com ícone temático, rótulo e valor. Otimizado para baixo custo computacional.
class InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? iconColor;

  const InfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    const defaultColor = Color(0xFF1B4332);
    final effectiveColor = iconColor ?? defaultColor;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(7.0),
          decoration: const BoxDecoration(
            color: Color(0xFFE8F2EC),
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          child: Icon(
            icon,
            size: 18,
            color: effectiveColor,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: const TextStyle(
                  fontSize: 10.5,
                  color: Color(0xFF63736C),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 13.5,
                  color: Color(0xFF0F261C),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
