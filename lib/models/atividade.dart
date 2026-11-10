/// Tipos de atividade oferecidos na programação do congresso.
enum TipoAtividade {
  palestra('Palestra'),
  workshop('Workshop'),
  minicurso('Minicurso');

  final String rotulo;
  const TipoAtividade(this.rotulo);
}

/// Modelo que representa uma Atividade da programação (Módulo 1).
///
/// Contém as informações exigidas pelo módulo:
/// tipo (palestra, workshop ou minicurso), horários, local e detalhes.
class Atividade {
  final String id;
  final String titulo;
  final TipoAtividade tipo;
  final String descricao;
  final DateTime inicio;
  final DateTime fim;
  final String local;
  final String responsavel;

  /// Identificador do palestrante (Módulo 2), quando houver.
  final String? palestranteId;
  final int vagas;

  const Atividade({
    required this.id,
    required this.titulo,
    required this.tipo,
    required this.descricao,
    required this.inicio,
    required this.fim,
    required this.local,
    required this.responsavel,
    this.palestranteId,
    this.vagas = 0,
  });

  /// Data no formato dd/mm/aaaa.
  String get dataFormatada =>
      '${_doisDigitos(inicio.day)}/${_doisDigitos(inicio.month)}/${inicio.year}';

  /// Horário no formato hh:mm - hh:mm.
  String get horarioFormatado => '${_hora(inicio)} - ${_hora(fim)}';

  /// Duração total da atividade em minutos.
  int get duracaoMinutos => fim.difference(inicio).inMinutes;

  static String _hora(DateTime d) =>
      '${_doisDigitos(d.hour)}:${_doisDigitos(d.minute)}';

  static String _doisDigitos(int n) => n.toString().padLeft(2, '0');

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Atividade && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
