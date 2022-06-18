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
}
