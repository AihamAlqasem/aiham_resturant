class ItemModel {
  int? id;
  String name;
  double price;
  String category;
  String imagePath;

  ItemModel({
    this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category': category,
      'imagePath': imagePath,
    };
  }
  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      category: map['category'],
      imagePath: map['imagePath'],
    );
  }
}