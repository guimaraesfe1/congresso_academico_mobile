/// Categorias dos avisos do 22º Congresso UNIMAM 2026.
enum CategoriaAviso {
  palestra('Palestras'),
  atividade('Atividades & Salas'),
  submissao('Pesquisa & Pós'),
  credenciamento('Credenciamento & Certificados');

  final String label;
  const CategoriaAviso(this.label);
}

/// Model que representa um aviso/comunicado oficial do Congresso.
class AvisoModel {
  final String id;
  final String titulo;
  final String mensagem;
  final String horarioPublicacao;
  final String localOuReferencia;
  final CategoriaAviso categoria;
  final bool urgente;
  bool lido;

  AvisoModel({
    required this.id,
    required this.titulo,
    required this.mensagem,
    required this.horarioPublicacao,
    required this.localOuReferencia,
    required this.categoria,
    this.urgente = false,
    this.lido = false,
  });
}
