import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Botão em formato de card usado na tela inicial para abrir cada módulo.
class ModuloCard extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String descricao;
  final VoidCallback onTap;
  final int? contador;

  const ModuloCard({
    super.key,
    required this.icone,
    required this.titulo,
    required this.descricao,
    required this.onTap,
    this.contador,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Badge(
                isLabelVisible: (contador ?? 0) > 0,
                label: Text('${contador ?? 0}'),
                backgroundColor: AppColors.destaque,
                textColor: AppColors.textoForte,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: AppColors.superficieSuave,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Icon(icone, color: AppColors.primaria, size: 26),
                ),
              ),
              const Spacer(),
              Text(
                titulo,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textoForte,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                descricao,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12, color: AppColors.textoSuave),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
