/// Modelo que representa a Inscrição de um participante (Módulo 3).
class Inscricao {
  final String nome;
  final String email;
  final String curso;
  final String instituicao;
  final String tipoParticipante;

  const Inscricao({
    required this.nome,
    required this.email,
    required this.curso,
    required this.instituicao,
    required this.tipoParticipante,
  });
}
