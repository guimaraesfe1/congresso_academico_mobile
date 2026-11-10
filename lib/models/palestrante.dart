/// Modelo que representa um Palestrante do Congresso (Módulo 2).
class Palestrante {
  final String id;
  final String nome;
  final String fotoUrl;
  final String instituicao;
  final String areaAtuacao;
  final String temaPalestra;
  final String informacoesAdicionais;

  const Palestrante({
    required this.id,
    required this.nome,
    required this.fotoUrl,
    required this.instituicao,
    required this.areaAtuacao,
    required this.temaPalestra,
    required this.informacoesAdicionais,
  });
}
