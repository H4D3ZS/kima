import 'package:kima/src/data/models/ticket_model.dart';
import 'package:kima/src/data/models/user_profile.dart';
import 'package:kima/src/utils/enums.dart';


class Marketplace {
  // final int id;
  String author;
  final String imageUrl;
  String? thumbnail;
  String title;
  UserProfile user;
  ClassifiedsCategory category;
  List<String> images;
  String listingDate;
  String description;
  String location;
  String? date;
  String? time;
  String? price;
  String? status;
  String? employmentType;
  String? salary;
  List<String>? minimumQualifications;
  List<String>? jobDescription;
  String? language;
  List<TicketModel>? tickets;
  int? bathrooms;
  int? bedrooms;

  Marketplace({
    required this.author,
    // required this.id,
    required this.imageUrl,
    this.thumbnail,
    required this.title,
    required this.user,
    required this.category,
    required this.images,
    required this.listingDate,
    required this.description,
    required this.location,
    this.date,
    this.time,
    this.price,
    this.status,
    this.employmentType,
    this.salary,
    this.minimumQualifications,
    this.jobDescription,
    this.language,
    this.tickets,
    this.bathrooms,
    this.bedrooms,
  });
}
