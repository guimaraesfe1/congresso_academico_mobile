/// Modelo que representa um Trabalho Acadêmico submetido ao Congresso.
///
/// Contém as informações exigidas pelo Módulo 4:
/// - Título
/// - Autores
/// - Área de Conhecimento
/// - Resumo
/// - Detalhes do trabalho (sessão, data, horário, sala, modalidade, status, palavras-chave)
class AcademicPaper {
  final String id;
  final String title;
  final List<String> authors;
  final String institution;
  final String knowledgeArea;
  final String abstractText;
  final String modality; // Ex: "Apresentação Oral", "Sessão de Pôsteres"
  final String presentationDate;
  final String presentationTime;
  final String room;
  final List<String> keywords;
  final String status; // Ex: "Aprovado", "Destaque Acadêmico", "Menção Honrosa"
  final double score;
  final bool isFavorite;
  final List<String> questions;

  const AcademicPaper({
    required this.id,
    required this.title,
    required this.authors,
    required this.institution,
    required this.knowledgeArea,
    required this.abstractText,
    required this.modality,
    required this.presentationDate,
    required this.presentationTime,
    required this.room,
    required this.keywords,
    this.status = 'Aprovado',
    this.score = 9.0,
    this.isFavorite = false,
    this.questions = const [],
  });

  /// String formatada com os nomes dos autores separados por vírgula.
  String get authorsFormatted => authors.join(', ');

  /// Cria uma cópia da instância permitindo alterar campos específicos (imutabilidade).
  AcademicPaper copyWith({
    String? id,
    String? title,
    List<String>? authors,
    String? institution,
    String? knowledgeArea,
    String? abstractText,
    String? modality,
    String? presentationDate,
    String? presentationTime,
    String? room,
    List<String>? keywords,
    String? status,
    double? score,
    bool? isFavorite,
    List<String>? questions,
  }) {
    return AcademicPaper(
      id: id ?? this.id,
      title: title ?? this.title,
      authors: authors ?? this.authors,
      institution: institution ?? this.institution,
      knowledgeArea: knowledgeArea ?? this.knowledgeArea,
      abstractText: abstractText ?? this.abstractText,
      modality: modality ?? this.modality,
      presentationDate: presentationDate ?? this.presentationDate,
      presentationTime: presentationTime ?? this.presentationTime,
      room: room ?? this.room,
      keywords: keywords ?? this.keywords,
      status: status ?? this.status,
      score: score ?? this.score,
      isFavorite: isFavorite ?? this.isFavorite,
      questions: questions ?? this.questions,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AcademicPaper &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
