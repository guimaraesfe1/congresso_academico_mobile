import '../models/palestrante.dart';

/// Dados simulados de palestrantes do congresso (Módulo 2).
const List<Palestrante> mockPalestrantes = [
  Palestrante(
    id: '1',
    nome: 'Dra. Ana Souza',
    fotoUrl: 'https://i.pravatar.cc/300?img=5',
    instituicao: 'Universidade Federal de Tecnologia',
    areaAtuacao: 'Inteligência Artificial',
    temaPalestra: 'O Futuro dos Modelos de Linguagem na Educação',
    informacoesAdicionais:
        'Pesquisadora sênior com mais de 15 anos de experiência em IA e aprendizado de máquina aplicados à educação.',
  ),
  Palestrante(
    id: '2',
    nome: 'Prof. Carlos Mendes',
    fotoUrl: 'https://i.pravatar.cc/300?img=12',
    instituicao: 'Instituto de Inovação Digital',
    areaAtuacao: 'Desenvolvimento Mobile & IoT',
    temaPalestra: 'Arquiteturas Escaláveis com Flutter',
    informacoesAdicionais:
        'Especialista em desenvolvimento de software e consultor de arquiteturas de sistemas móveis.',
  ),
  Palestrante(
    id: '3',
    nome: 'Dra. Beatriz Lima',
    fotoUrl: 'https://i.pravatar.cc/300?img=47',
    instituicao: 'Universidade Estadual de Feira de Santana',
    areaAtuacao: 'Ciência de Dados',
    temaPalestra: 'Dados Abertos e Políticas Públicas',
    informacoesAdicionais:
        'Coordena o laboratório de dados abertos da UEFS e atua em projetos de transparência governamental.',
  ),
];
