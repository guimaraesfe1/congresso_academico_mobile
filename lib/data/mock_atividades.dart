import '../models/atividade.dart';

/// Dados simulados da programação do congresso (Módulo 1).
final List<Atividade> mockAtividades = [
  Atividade(
    id: 'atv-01',
    titulo: 'Abertura: O Futuro dos Modelos de Linguagem na Educação',
    tipo: TipoAtividade.palestra,
    descricao:
        'Palestra de abertura do congresso sobre como modelos de linguagem estão transformando o ensino, a avaliação e a produção científica nas universidades.',
    inicio: DateTime(2026, 10, 24, 8, 30),
    fim: DateTime(2026, 10, 24, 10, 0),
    local: 'Auditório Nobre - Bloco A',
    responsavel: 'Dra. Ana Souza',
    palestranteId: '1',
    vagas: 300,
  ),
  Atividade(
    id: 'atv-02',
    titulo: 'Workshop: Prototipação Rápida com Flutter',
    tipo: TipoAtividade.workshop,
    descricao:
        'Atividade prática de construção de um aplicativo do zero usando Flutter, Dart e o padrão MVVM. Traga seu notebook com o Flutter instalado.',
    inicio: DateTime(2026, 10, 24, 10, 30),
    fim: DateTime(2026, 10, 24, 12, 30),
    local: 'Laboratório de Informática 3 - Bloco C',
    responsavel: 'Prof. Carlos Mendes',
    palestranteId: '2',
    vagas: 30,
  ),
  Atividade(
    id: 'atv-03',
    titulo: 'Minicurso: Introdução à Análise de Dados com Python',
    tipo: TipoAtividade.minicurso,
    descricao:
        'Minicurso introdutório sobre manipulação e visualização de dados com pandas e matplotlib, com exemplos de dados públicos.',
    inicio: DateTime(2026, 10, 24, 14, 0),
    fim: DateTime(2026, 10, 24, 17, 0),
    local: 'Sala Temática 201 - Bloco B',
    responsavel: 'Dra. Beatriz Lima',
    palestranteId: '3',
    vagas: 40,
  ),
  Atividade(
    id: 'atv-04',
    titulo: 'Arquiteturas Escaláveis com Flutter',
    tipo: TipoAtividade.palestra,
    descricao:
        'Discussão sobre organização de projetos móveis de grande porte, separação de responsabilidades e gerenciamento de estado.',
    inicio: DateTime(2026, 10, 25, 9, 0),
    fim: DateTime(2026, 10, 25, 10, 30),
    local: 'Auditório Nobre - Bloco A',
    responsavel: 'Prof. Carlos Mendes',
    palestranteId: '2',
    vagas: 300,
  ),
  Atividade(
    id: 'atv-05',
    titulo: 'Workshop: Escrita Científica e Submissão de Artigos',
    tipo: TipoAtividade.workshop,
    descricao:
        'Orientações práticas sobre estrutura de artigos, escolha de periódicos, normas da ABNT e boas práticas de revisão por pares.',
    inicio: DateTime(2026, 10, 25, 14, 0),
    fim: DateTime(2026, 10, 25, 16, 0),
    local: 'Sala Temática 105 - Bloco C',
    responsavel: 'Profa. Dra. Helena Matos',
    vagas: 50,
  ),
  Atividade(
    id: 'atv-06',
    titulo: 'Dados Abertos e Políticas Públicas',
    tipo: TipoAtividade.palestra,
    descricao:
        'Como dados governamentais abertos podem apoiar a pesquisa acadêmica e a formulação de políticas públicas baseadas em evidências.',
    inicio: DateTime(2026, 10, 26, 9, 0),
    fim: DateTime(2026, 10, 26, 10, 0),
    local: 'Auditório Nobre - Bloco A',
    responsavel: 'Dra. Beatriz Lima',
    palestranteId: '3',
    vagas: 300,
  ),
  Atividade(
    id: 'atv-07',
    titulo: 'Minicurso: Git e GitHub para Pesquisadores',
    tipo: TipoAtividade.minicurso,
    descricao:
        'Versionamento de código e documentos acadêmicos, colaboração em equipe e publicação de repositórios de pesquisa.',
    inicio: DateTime(2026, 10, 26, 10, 30),
    fim: DateTime(2026, 10, 26, 12, 30),
    local: 'Laboratório de Informática 3 - Bloco C',
    responsavel: 'Kauã Santos',
    vagas: 30,
  ),
  Atividade(
    id: 'atv-08',
    titulo: 'Encerramento e Premiação dos Melhores Trabalhos',
    tipo: TipoAtividade.palestra,
    descricao:
        'Cerimônia de encerramento com a entrega das menções honrosas e dos prêmios de destaque acadêmico.',
    inicio: DateTime(2026, 10, 26, 17, 0),
    fim: DateTime(2026, 10, 26, 18, 30),
    local: 'Auditório Nobre - Bloco A',
    responsavel: 'Comissão Organizadora',
    vagas: 300,
  ),
];
