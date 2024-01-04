class RealEstateModel {
  String title;
  String description;

  RealEstateModel({
    required this.title,
    required this.description
  });

  set setTitle(String val) {
    title = val;
  }

  set setDescription(String val) {
    description = val;
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description
    };
  }
}