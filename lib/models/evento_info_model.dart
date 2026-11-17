/// Model que representa os dados institucionais do Congresso e do estudante.
class EventoInfoModel {
  final String titulo;
  final String subtitulo;
  final String instituicao;
  final String edicao;
  final String temaCentral;
  final String periodo;
  final String local;
  final String cargaHorariaCertificado;
  final String nomeParticipante;
  final String cursoParticipante;
  final String matriculaParticipante;
  final String modalidadeInscricao;

  const EventoInfoModel({
    required this.titulo,
    required this.subtitulo,
    required this.instituicao,
    required this.edicao,
    required this.temaCentral,
    required this.periodo,
    required this.local,
    required this.cargaHorariaCertificado,
    required this.nomeParticipante,
    required this.cursoParticipante,
    required this.matriculaParticipante,
    required this.modalidadeInscricao,
  });
}
