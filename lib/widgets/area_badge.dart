import 'package:flutter/material.dart';

/// Widget reutilizável que exibe um badge plano e leve representando
/// a Área de Conhecimento do trabalho acadêmico.
///
/// Otimizado para não realizar alocações de sombra ou blur em dispositivos de entrada.
class AreaBadge extends StatelessWidget {
  final String area;
  final bool isCompact;

  const AreaBadge({
    super.key,
    required this.area,
    this.isCompact = false,
  });

  // Cores predefinidas para economia de processamento
  static Color _getAreaColor(String areaName) {
    if (areaName.contains('Inteligência') || areaName.contains('IA')) {
      return const Color(0xFF2E7D32); // Verde Floresta Intenso
    } else if (areaName.contains('Engenharia') || areaName.contains('Software')) {
      return const Color(0xFF1B4332); // Verde Escuro Profundo
    } else if (areaName.contains('Saúde')) {
      return const Color(0xFF00695C); // Verde Teal Escuro
    } else if (areaName.contains('Educação')) {
      return const Color(0xFFE65100); // Âmbar Escuro
    } else if (areaName.contains('Segurança')) {
      return const Color(0xFF33691E); // Verde Oliva Escuro
    } else if (areaName.contains('Sustentabilidade') || areaName.contains('Ambiente')) {
      return const Color(0xFF1B5E20); // Verde Esmeralda Escuro
    } else if (areaName.contains('Dados')) {
      return const Color(0xFF004D40); // Verde Petróleo
    }
    return const Color(0xFF264653); // Neutro Escuro
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = _getAreaColor(area);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? 8.0 : 10.0,
        vertical: isCompact ? 3.0 : 5.0,
      ),
      decoration: BoxDecoration(
        color: baseColor.withValues(alpha: 0.1),
        borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        border: Border.all(
          color: baseColor.withValues(alpha: 0.35),
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: baseColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            area,
            style: TextStyle(
              fontSize: isCompact ? 11.0 : 12.5,
              fontWeight: FontWeight.w600,
              color: baseColor,
            ),
          ),
        ],
      ),
    );
  }
}
