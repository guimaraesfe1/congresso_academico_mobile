import 'atividade.dart';

/// Modelo que representa uma atividade adicionada à agenda pessoal
/// do participante (Módulo 5).
class ItemAgenda {
  final Atividade atividade;
  final bool favorita;

  const ItemAgenda({required this.atividade, this.favorita = false});

  ItemAgenda copyWith({bool? favorita}) {
    return ItemAgenda(atividade: atividade, favorita: favorita ?? this.favorita);
  }
}
