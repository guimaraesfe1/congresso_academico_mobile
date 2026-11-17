import '../models/atividade_model.dart';
import '../models/aviso_model.dart';
import '../models/evento_info_model.dart';

/// Repositório responsável por fornecer os dados do
/// 22º Congresso Estudantil de Pesquisa e Pós-Graduação da UNIMAM 2026.
class CongressoRepository {
  EventoInfoModel obterInfoEvento() {
    return const EventoInfoModel(
      titulo: '22º Congresso Estudantil de Pesquisa e Pós-Graduação',
      subtitulo: 'UNIMAM 2026 • Centro Universitário Maria Milza',
      instituicao: 'UNIMAM - Governador Mangabeira / Recôncavo da Bahia',
      edicao: '22ª Edição • 2026',
      temaCentral:
          'Ciência, Inovação Sustentável e Inteligência Artificial na Pós-Graduação e Pesquisa Regional',
      periodo: '18 a 21 de Novembro de 2026',
      local: 'Campus UNIMAM - Auditório Principal e Blocos A, B e C',
      cargaHorariaCertificado: '40 horas complementares (Certificado Digital)',
      nomeParticipante: 'João Nascimento',
      cursoParticipante: 'Desenvolvimento Mobile / Sistemas e Tecnologia - UNIMAM',
      matriculaParticipante: '2026.UNIMAM.0224',
      modalidadeInscricao: 'Congressista & Pesquisador Júnior',
    );
  }

  List<AtividadeModel> obterAtividadesIniciais() {
    return [
      AtividadeModel(
        id: 'ativ_1',
        titulo:
            'Conferência de Abertura: Inteligência Artificial, Ética e o Futuro da Pesquisa na Pós-Graduação',
        palestrante: 'Prof. Dr. Marcos Vinícius Almeida',
        titulacaoPalestrante: 'Coordenador do Núcleo de Pós-Graduação e Pesquisa - UNIMAM',
        tipo: TipoAtividade.palestra,
        data: '18/11/2026',
        horario: '19:00 às 21:30',
        local: 'Auditório Central UNIMAM',
        descricao:
            'Solenidade oficial de abertura do 22º Congresso Estudantil de Pesquisa e Pós-Graduação da UNIMAM 2026, abordando os impactos da IA generativa e da ciência aberta na produção científica do Recôncavo Baiano.',
        cargaHorariaHoras: 4,
        inscrito: true,
        presencaConfirmada: true,
      ),
      AtividadeModel(
        id: 'ativ_2',
        titulo:
            'Desenvolvimento Mobile Multiplataforma com Flutter e Arquitetura MVVM na Prática',
        palestrante: 'Prof. Me. Rafael Santana',
        titulacaoPalestrante: 'Especialista em Engenharia de Software e Mobile - UNIMAM',
        tipo: TipoAtividade.minicurso,
        data: '19/11/2026',
        horario: '08:30 às 12:00',
        local: 'Laboratório de Informática III - Bloco B',
        descricao:
            'Minicurso prático voltado para estudantes de tecnologia sobre organização de código com padrão Model-View-ViewModel (MVVM), gerência de estado e Material Design 3.',
        cargaHorariaHoras: 6,
        inscrito: true,
      ),
      AtividadeModel(
        id: 'ativ_3',
        titulo:
            'Simpósio de Pós-Graduação Stricto e Lato Sensu: Caminhos do Mestrado à Inovação',
        palestrante: 'Profa. Dra. Helena Costa & Prof. Dr. Carlos Eduardo',
        titulacaoPalestrante: 'Docentes permanentes dos Programas de Pós-Graduação UNIMAM',
        tipo: TipoAtividade.posGraduacao,
        data: '19/11/2026',
        horario: '14:00 às 17:00',
        local: 'Auditório Pós-Graduação - Bloco C',
        descricao:
            'Apresentação das linhas de pesquisa da Pós-Graduação UNIMAM 2026, bolsas de fomento (FAPESB/CNPq/CAPES) e integração entre iniciação científica e pós-graduação.',
        cargaHorariaHoras: 4,
        inscrito: true,
      ),
      AtividadeModel(
        id: 'ativ_4',
        titulo:
            'Mesa-Redonda: Sustentabilidade, Biotecnologia Verde e Desenvolvimento no Recôncavo',
        palestrante: 'Profa. Dra. Patrícia Lima, Dr. Lucas Rocha e Convidados',
        titulacaoPalestrante: 'Grupo de Pesquisa em Ciências Ambientais e Saúde - UNIMAM',
        tipo: TipoAtividade.mesaRedonda,
        data: '20/11/2026',
        horario: '09:00 às 11:30',
        local: 'Auditório Central UNIMAM',
        descricao:
            'Debate interdisciplinar sobre projetos de pesquisa sustentável, bioeconomia e responsabilidade socioambiental desenvolvidos pelos discentes e pós-graduandos da UNIMAM.',
        cargaHorariaHoras: 4,
        inscrito: false,
      ),
      AtividadeModel(
        id: 'ativ_5',
        titulo:
            'Sessão de Comunicação Oral e Pôsteres: Iniciação Científica e Pós-Graduação',
        palestrante: 'Banca Avaliadora do Comitê Científico UNIMAM',
        titulacaoPalestrante: 'Comissão Científica do 22º Congresso UNIMAM 2026',
        tipo: TipoAtividade.comunicacaoOral,
        data: '20/11/2026',
        horario: '14:00 às 18:00',
        local: 'Hall de Convivência e Salas 101 a 108 - Bloco A',
        descricao:
            'Exposição e arguição dos artigos, resumos expandidos e projetos de pesquisa submetidos pelos estudantes de graduação e pós-graduação da UNIMAM.',
        cargaHorariaHoras: 6,
        inscrito: true,
      ),
      AtividadeModel(
        id: 'ativ_6',
        titulo:
            'Palestra de Encerramento: Empreendedorismo Científico, Patentes e Premiação dos Melhores Trabalhos',
        palestrante: 'Profa. Dra. Fernanda Queiroz',
        titulacaoPalestrante: 'Pró-Reitoria de Pesquisa, Extensão e Pós-Graduação - UNIMAM',
        tipo: TipoAtividade.palestra,
        data: '21/11/2026',
        horario: '18:30 às 21:30',
        local: 'Auditório Central UNIMAM',
        descricao:
            'Palestra magna de encerramento seguida da cerimônia de menção honrosa aos melhores trabalhos científicos da 22ª edição e liberação dos certificados.',
        cargaHorariaHoras: 4,
        inscrito: false,
      ),
    ];
  }

  List<AvisoModel> obterAvisosIniciais() {
    return [
      AvisoModel(
        id: 'aviso_1',
        titulo: 'Credenciamento Aberto para a Palestra de Abertura!',
        mensagem:
            'O credenciamento presencial com leitura de QR Code para a Conferência de Abertura do 22º Congresso da UNIMAM já está liberado no foyer do Auditório Central. Chegue com 30 minutos de antecedência.',
        horarioPublicacao: 'Hoje • 17:30',
        localOuReferencia: 'Auditório Central UNIMAM',
        categoria: CategoriaAviso.credenciamento,
        urgente: true,
        lido: false,
      ),
      AvisoModel(
        id: 'aviso_2',
        titulo: 'Alteração de Sala: Minicurso de Flutter e Arquitetura MVVM',
        mensagem:
            'Devido à alta procura dos estudantes, o Minicurso "Desenvolvimento Mobile com Flutter e Arquitetura MVVM" foi transferido para o Laboratório de Informática III (Bloco B, 2º andar), com 15 vagas extras.',
        horarioPublicacao: 'Hoje • 15:10',
        localOuReferencia: 'Lab. de Informática III - Bloco B',
        categoria: CategoriaAviso.atividade,
        urgente: true,
        lido: false,
      ),
      AvisoModel(
        id: 'aviso_3',
        titulo: 'Ordem de Apresentação de Pôsteres e Comunicação Oral Publicada',
        mensagem:
            'Os autores de trabalhos aprovados na modalidade Pesquisa & Pós-Graduação devem fixar seus banners até as 13h30 do dia 20/11 no Hall do Bloco A. A lista de avaliadores já está disponível.',
        horarioPublicacao: 'Ontem • 18:45',
        localOuReferencia: 'Hall do Bloco A • Salas 101-108',
        categoria: CategoriaAviso.submissao,
        urgente: false,
        lido: false,
      ),
      AvisoModel(
        id: 'aviso_4',
        titulo: 'Transmissão Simultânea da Palestra Magna de Pós-Graduação',
        mensagem:
            'Para maior conforto dos congressistas, o Simpósio de Pós-Graduação contará com transmissão simultânea no Mini-Auditório do Bloco C, garantindo validação integral da presença via check-in.',
        horarioPublicacao: 'Ontem • 11:20',
        localOuReferencia: 'Auditório Pós-Graduação - Bloco C',
        categoria: CategoriaAviso.palestra,
        urgente: false,
        lido: true,
      ),
      AvisoModel(
        id: 'aviso_5',
        titulo: 'Emissão do Certificado de 40h do 22º Congresso UNIMAM',
        mensagem:
            'Lembramos que para emissão automática do certificado geral de 40 horas, o estudante deverá registrar presença em pelo menos 75% das palestras e atividades inscritas na sua agenda.',
        horarioPublicacao: '15/11/2026 • 09:00',
        localOuReferencia: 'Secretaria Acadêmica / Portal do Congressista',
        categoria: CategoriaAviso.credenciamento,
        urgente: false,
        lido: true,
      ),
    ];
  }
}
