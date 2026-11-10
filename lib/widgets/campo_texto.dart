import 'package:flutter/material.dart';

/// Campo de texto reutilizável usado nos formulários de inscrição
/// e de cadastro de palestrante.
class CampoTexto extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData? icone;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int maxLines;

  const CampoTexto({
    super.key,
    required this.controller,
    required this.label,
    this.icone,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        maxLines: maxLines,
        textInputAction:
            maxLines > 1 ? TextInputAction.newline : TextInputAction.next,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icone != null ? Icon(icone) : null,
          alignLabelWithHint: maxLines > 1,
        ),
      ),
    );
  }
}
