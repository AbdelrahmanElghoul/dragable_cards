class CardModel {
  final String name;
  final String id;

  CardModel({
    required this.name,
    required this.id,
  });

  @override
  String toString() {
    return "id $id / name :$name";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
