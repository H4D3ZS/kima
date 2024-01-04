
class ClassifiedModelsdata {
  List<ClassifiedData>? data;
  PageInfo? pageInfo;

  ClassifiedModelsdata({this.data, this.pageInfo});

  factory ClassifiedModelsdata.fromJson(Map<String, dynamic> json) {
    return ClassifiedModelsdata(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ClassifiedData.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageInfo: json['pageInfo'] != null
          ? PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>)
          : null,
    );
  }
}

class ClassifiedData {
  String? createdAt;
  String? updatedAt;
  int? id;
  String? userId;
  List<Gallery>? gallery;
  String? category;
  String? title;
  String? location;
  String? description;
  EventDetails? eventDetails;
  JobPostingDetails? jobPostingDetails;
  ForSaleDetails? forSaleDetails;

  ClassifiedData({
    this.createdAt,
    this.updatedAt,
    this.id,
    this.userId,
    this.gallery,
    this.category,
    this.title,
    this.location,
    this.description,
    this.eventDetails,
    this.jobPostingDetails,
    this.forSaleDetails,
  });

  factory ClassifiedData.fromJson(Map<String, dynamic> json) {
    return ClassifiedData(
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      id: json['id'] as int?,
      userId: json['userId'] as String?,
      gallery: (json['gallery'] as List<dynamic>?)
          ?.map((e) => Gallery.fromJson(e as Map<String, dynamic>))
          .toList(),
      category: json['category'] as String?,
      title: json['title'] as String?,
      location: json['location'] as String?,
      description: json['description'] as String?,
      eventDetails: json['eventDetails'] != null
          ? EventDetails.fromJson(json['eventDetails'] as Map<String, dynamic>)
          : null,
      jobPostingDetails: json['jobPostingDetails'] != null
          ? JobPostingDetails.fromJson(
          json['jobPostingDetails'] as Map<String, dynamic>)
          : null,
      forSaleDetails: json['forSaleDetails'] != null
          ? ForSaleDetails.fromJson(
          json['forSaleDetails'] as Map<String, dynamic>)
          : null,
    );
  }
}

class Gallery {
  int? id;
  String? imageUrl;
  String? createdAt;

  Gallery({this.id, this.imageUrl, this.createdAt});

  factory Gallery.fromJson(Map<String, dynamic> json) {
    return Gallery(
      id: json['id'] as int?,
      imageUrl: json['imageUrl'] as String?,
      createdAt: json['createdAt'] as String?,
    );
  }
}

class EventDetails {
  String? eventType;
  String? date;
  String? time;
  List<Ticket>? tickets;

  EventDetails({this.eventType, this.date, this.time, this.tickets});

  factory EventDetails.fromJson(Map<String, dynamic> json) {
    return EventDetails(
      eventType: json['eventType'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      tickets: (json['tickets'] as List<dynamic>?)
          ?.map((e) => Ticket.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Ticket {
  String? title;
  int? price;

  Ticket({this.title, this.price});

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      title: json['title'] as String?,
      price: json['price'] as int?,
    );
  }
}

class JobPostingDetails {
  List<Section>? sections;

  JobPostingDetails({this.sections});

  factory JobPostingDetails.fromJson(Map<String, dynamic> json) {
    return JobPostingDetails(
      sections: (json['sections'] as List<dynamic>?)
          ?.map((e) => Section.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Section {
  String? title;
  String? description;

  Section({this.title, this.description});

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      title: json['title'] as String?,
      description: json['description'] as String?,
    );
  }
}

class ForSaleDetails {
  int? price;
  String? itemCondition;

  ForSaleDetails({this.price, this.itemCondition});

  factory ForSaleDetails.fromJson(Map<String, dynamic> json) {
    return ForSaleDetails(
      price: json['price'] as int?,
      itemCondition: json['itemCondition'] as String?,
    );
  }
}

class PageInfo {
  int? currentPage;
  int? totalPages;
  int? itemsPerPage;
  int? totalItems;

  PageInfo({
    this.currentPage,
    this.totalPages,
    this.itemsPerPage,
    this.totalItems,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) {
    return PageInfo(
      currentPage: json['currentPage'] as int?,
      totalPages: json['totalPages'] as int?,
      itemsPerPage: json['itemsPerPage'] as int?,
      totalItems: json['totalItems'] as int?,
    );
  }
}
