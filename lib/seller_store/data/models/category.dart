class Category {
  String id;
  String categoryName;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Category({
    required this.id,
    required this.categoryName,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] ?? "",
      categoryName: json['categoryName'] ?? "",
      createdAt: DateTime.parse(json['createdAt'] ?? ""),
      updatedAt: DateTime.parse(json['updatedAt'] ?? ""),
      v: json['__v'] ?? "",
    );
  }
}
