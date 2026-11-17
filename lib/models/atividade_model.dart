/// Categorias das atividades do 22º Congresso UNIMAM 2026.
enum TipoAtividade {
  palestra('Palestra Magna'),
  posGraduacao('Pós-Graduação'),
  minicurso('Minicurso'),
  mesaRedonda('Mesa-Redonda'),
  comunicacaoOral('Pesquisa & Pôster');

  final String label;
  const TipoAtividade(this.label);
}

/// Model que representa uma palestra ou atividade acadêmica do Congresso.
class AtividadeModel {
  final String id;
  final String titulo;
  final String palestrante;
  final String titulacaoPalestrante;
  final TipoAtividade tipo;
  final String data;
  final String horario;
  final String local;
  final String descricao;
  final int cargaHorariaHoras;
  bool inscrito;
  bool presencaConfirmada;

  AtividadeModel({
    required this.id,
    required this.titulo,
    required this.palestrante,
    required this.titulacaoPalestrante,
    required this.tipo,
    required this.data,
    required this.horario,
    required this.local,
    required this.descricao,
    this.cargaHorariaHoras = 4,
    this.inscrito = false,
    this.presencaConfirmada = false,
  });
}
