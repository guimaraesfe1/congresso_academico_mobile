import 'package:flutter/foundation.dart';

import '../models/inscricao.dart';

/// ViewModel do Módulo 3: Inscrições.
///
/// Guarda as inscrições realizadas e concentra as regras de validação
/// do formulário.
class InscricaoViewModel extends ChangeNotifier {
  static const List<String> tiposParticipante = [
    'Estudante',
    'Professor',
    'Pesquisador',
    'Ouvinte',
  ];

  final List<Inscricao> _inscricoes = [];

  List<Inscricao> get inscricoes => List.unmodifiable(_inscricoes);

  int get total => _inscricoes.length;

  String? validarObrigatorio(String? valor, String campo) {
    if (valor == null || valor.trim().isEmpty) return 'Informe $campo';
    return null;
  }

  String? validarEmail(String? valor) {
    final obrigatorio = validarObrigatorio(valor, 'o e-mail');
    if (obrigatorio != null) return obrigatorio;
    final emailValido = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailValido.hasMatch(valor!.trim())) return 'E-mail inválido';
    if (_inscricoes.any((i) => i.email == valor.trim().toLowerCase())) {
      return 'Este e-mail já está inscrito';
    }
    return null;
  }

  Inscricao enviarInscricao({
    required String nome,
    required String email,
    required String curso,
    required String instituicao,
    required String tipoParticipante,
  }) {
    final novaInscricao = Inscricao(
      nome: nome.trim(),
      email: email.trim().toLowerCase(),
      curso: curso.trim(),
      instituicao: instituicao.trim(),
      tipoParticipante: tipoParticipante,
    );
    _inscricoes.add(novaInscricao);
    notifyListeners();
    return novaInscricao;
  }
}
