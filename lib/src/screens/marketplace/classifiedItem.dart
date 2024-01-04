class ClassifiedItemDataModels {
  final String title;
  final String description;
  final String imageUrl;
  final String category;

  ClassifiedItemDataModels({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
  });

  factory ClassifiedItemDataModels.fromJson(Map<String, dynamic> json) {
    return ClassifiedItemDataModels(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      category: json['category'] ?? '',
    );
  }
}