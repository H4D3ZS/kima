import 'package:flutter/material.dart' hide Key;
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:kima/src/data/models/report.dart';
import 'package:kima/src/data/models/ticket_model.dart';
import 'package:kima/src/data/models/user_profile.dart';
import 'package:kima/src/utils/configs.dart';
import "package:kima/src/utils/constants.dart";
import "package:kima/src/utils/enums.dart";
import 'package:kima/src/data/models/marketplace.dart';
import 'package:kima/src/utils/helpers/encryption.dart';

extension ColorFilterExt on Color {
  ColorFilter get toColorFilter => ColorFilter.mode(this, BlendMode.srcIn);
}

extension MarketplaceModelExt on Marketplace {
  Map<String, dynamic> get tabulatedDetails {
    Map<String, dynamic> value = {};
    switch (category) {
      case ClassifiedsCategory.events:
        value = {
          Keys.location: location,
          Keys.date: date,
          Keys.time: time,
          Keys.price: price,
        };
      case ClassifiedsCategory.job_posting:
        value = {
          Keys.location: location,
          Keys.employmentType: employmentType,
          Keys.salary: salary,
          Keys.language: language,
        };
      case ClassifiedsCategory.for_sale:
        value = {
          Keys.location: location,
          Keys.status: status,
          Keys.price: price,
        };
      case ClassifiedsCategory.real_estate:
        value = {
          Keys.bathrooms: bathrooms.toString(),
          Keys.bedrooms: bedrooms.toString(),
        };
      default:
        value;
    }
    return value..removeNull();
  }

  Map<String, dynamic> get bulletedJobDetails => {
        Keys.minimumQualifications: minimumQualifications,
        Keys.jobDescription: jobDescription,
      }..removeNull();

  Map<String, dynamic> get cardIconDetails {
    Map<String, dynamic> value = {};
    switch (category) {
      case ClassifiedsCategory.events:
        value = {Keys.date: '$date - $time'};
      case ClassifiedsCategory.job_posting:
        value = {
          Keys.language: language,
          Keys.salary: salary,
        };
      case ClassifiedsCategory.for_sale:
        value = {Keys.status: status};
      case ClassifiedsCategory.real_estate:
        value = {
          Keys.bathrooms: '$bathrooms $bathrooms',
          Keys.bedrooms: '$bedrooms $bedrooms',
        };
      default:
        value;
    }
    return value..removeNull();
  }
}

extension MapExt on Map<String, dynamic> {
  void removeNull() => removeWhere((_, value) => value == null);
}

extension ListExt on List<dynamic>? {
  bool get isNotNullNorEmpty => this?.isNotEmpty == true;
}

extension StringExt on String {
  String toTitleCase() =>
      toLowerCase().split(' ').map((word) => '${word[0].toUpperCase()}${word.substring(1, word.length)}').join();

  bool get isEmailInvalid {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return !regex.hasMatch(this);
  }

  String toDateFormat(String format) {
    if (this != '') {
      final parsed = DateTime.parse(this).toLocal();
      final DateFormat formatter = DateFormat(format);
      final String formatted = formatter.format(parsed);
      return formatted;
    } else {
      return '';
    }
  }

  String get fileType => p.extension(this);
}

extension UserProfileExt on UserProfile {
  String get displayName => [firstName, lastName].where((name) => name?.isNotEmpty == true).join(' ');

  bool get isBusinessUser => type == UserTypeEnum.business.name;

  bool get isProfessionalUser => type == UserTypeEnum.professional.name;

  bool get isBusinessOrProfessionalUser => isBusinessUser || isProfessionalUser;

  bool get isRegularUser => type == UserTypeEnum.member.name;

  String get avatarUrl => avatar!.contains('http') ? avatar! : baseUrlDev + avatar!;

  String get coverUrl => coverPhoto!.contains('http') ? coverPhoto! : baseUrlDev + coverPhoto!;

  Uri get userDeepLinkUri => Uri(
        scheme: 'deeplink',
        host: 'kima.pareainc.com',
        path: 'user',
        queryParameters: {'id': Uri.encodeComponent(Encrypt.encrypted(id!).base64)},
      );

  Gender? get genderValue {
    switch (gender) {
      case 'female':
        return Gender.female;
      case 'male':
        return Gender.male;
      default:
        return null;
    }
  }
}

extension EventTicketListExt on List<TicketModel> {
  List<TicketModel> get sortPriceLowToHigh => toList()..sort((a, b) => a.price.compareTo(b.price));
}

extension ReportListingExt on List<Report> {
  List<Report> groupByType(String type) => List.from(where((report) => report.reason == type));
}
