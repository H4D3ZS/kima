import 'package:flutter/material.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/data/models/marketplace.dart';
import 'package:kima/src/data/models/report.dart';
import 'package:kima/src/data/models/ticket_model.dart';
import 'package:kima/src/data/models/user_profile.dart';
import 'package:kima/src/utils/enums.dart';

class DateTimeFormat {
  DateTimeFormat._();

  static const monthYear = 'MMMM yyyy';
  static const monthDayYear = 'MMMM dd, yyyy';
}

class IconMap {
  IconMap._();

  static final Map<ClassifiedsCategory, SvgGenImage> marketplaceCategory = {
    ClassifiedsCategory.all: Assets.icons.iconList,
    ClassifiedsCategory.events: Assets.icons.iconStar,
    ClassifiedsCategory.real_estate: Assets.icons.iconHome,
    ClassifiedsCategory.for_sale: Assets.icons.iconStar,
    ClassifiedsCategory.job_posting: Assets.icons.iconStar,
    ClassifiedsCategory.misc: Assets.icons.iconStar,
  };

  static final Map<String, Widget> classifiedCardDetails = {
    Keys.date: Assets.icons.clock.svg(),
    Keys.language: Assets.icons.globe.svg(),
    Keys.bathrooms: Assets.icons.iconBathroom.svg(),
    Keys.bedrooms: Assets.icons.iconBedroom.svg(),
  };

  // TODO: Can create enum if the icons initially shown are constant
  static final dashboardProfileDetails = [
    Assets.icons.mapPin,
    Assets.icons.clockBold,
    Assets.icons.dribbbleIcon,
    Assets.icons.instagramIcon,
    Assets.icons.moreHorizontal,
  ];
}

class Listing {
  Listing._();

  static final List<Report> reports = [
    Report(details: 'Hate Speech', reason: ReportEnum.hateSpeech.name),
    Report(details: 'Adult nudity', reason: ReportEnum.sexual.name),
    Report(details: 'Sexually suggestive', reason: ReportEnum.sexual.name),
    Report(details: 'Sexual activity', reason: ReportEnum.sexual.name),
    Report(details: 'Sexual exploitation', reason: ReportEnum.sexual.name),
    Report(details: 'Sexual services', reason: ReportEnum.sexual.name),
    Report(details: 'Child nudity', reason: ReportEnum.sexual.name),
    Report(details: 'Credible threat of violence', reason: ReportEnum.violence.name),
    Report(details: 'Theft or vandalism', reason: ReportEnum.violence.name),
    Report(details: 'Suicide or self harm', reason: ReportEnum.violence.name),
    Report(details: 'Graphic violence', reason: ReportEnum.violence.name),
    Report(details: 'It\'s me', reason: ReportEnum.harassment.name),
    Report(details: 'It\'s someone else', reason: ReportEnum.harassment.name),
    Report(details: 'Promotes Drug Use', reason: ReportEnum.unauthorizedSale.name),
    Report(details: 'Selling or purchasing guns, weapons, drugs', reason: ReportEnum.unauthorizedSale.name),
    Report(details: 'Selling Prescription Pharmaceuticals', reason: ReportEnum.unauthorizedSale.name),
    Report(details: 'Promotes Online Gambling', reason: ReportEnum.unauthorizedSale.name),
    Report(details: 'Something else', reason: ReportEnum.unauthorizedSale.name),
    Report(details: 'Me', reason: ReportEnum.pretend.name),
    Report(details: 'Celebrity', reason: ReportEnum.pretend.name),
    Report(details: 'A friend', reason: ReportEnum.pretend.name),
    Report(details: 'A business', reason: ReportEnum.pretend.name),
    Report(details: 'Asking me for financial information', reason: ReportEnum.fraud.name),
    Report(details: 'Other', reason: ReportEnum.fraud.name),
    Report(details: 'Fake account', reason: ReportEnum.fakeAccount.name),
    Report(details: 'Fake name', reason: ReportEnum.fakeName.name),
    Report(details: 'Intellectual property', reason: ReportEnum.intellectualProperty.name),
    Report(details: 'I can\'t access my account', reason: ReportEnum.accountAccess.name),
    Report(details: 'Something else', reason: ReportEnum.others.name),
  ];

  static final List<String> reportsWithAdditionalData = [
    ReportEnum.sexual.name,
    ReportEnum.harassment.name,
    ReportEnum.violence.name,
    ReportEnum.unauthorizedSale.name,
    ReportEnum.pretend.name,
    ReportEnum.fraud.name,
  ];
}

class Keys {
  Keys._();

  // Marketplace
  static const String location = 'location';
  static const String date = 'date';
  static const String time = 'time';
  static const String employmentType = 'employmentType';
  static const String salary = 'salary';
  static const String language = 'language';
  static const String minimumQualifications = 'minimumQualifications';
  static const String jobDescription = 'jobDescription';
  static const String status = 'status';
  static const String price = 'price';
  static const String bathrooms = 'bathrooms';
  static const String bedrooms = 'bedrooms';
}

// Mock Data
final List<Marketplace> classifiedsMockList = [
  Marketplace(
    title: 'Nepali Devastation Fundraiser',
    user: const UserProfile(firstName: 'Kim', lastName: 'Chau', avatar: 'assets/temporary/img_temp_3.png'),
    category: ClassifiedsCategory.events,
    thumbnail: 'assets/temporary/img_temp_3.png',
    images: [
      'assets/temporary/img_temp_1.png',
      'assets/temporary/img_temp_2.jpeg',
      'assets/temporary/img_temp_3.png',
    ],
    listingDate: '24.02.2023',
    description: 'The plane crash bordering Nepal and India have caused heart aches for many families. '
        'Please come and join April 1, 2023 to come pray together and share our love for our community.',
    location: 'Porkhara, Nepal',
    date: 'April 1, 2023',
    time: '8:30PM - 9:30PM',
    price: 'Free', imageUrl: '', author: 'Test',
  ),
  Marketplace(
    title: 'Environmental Fun Run',
    user: const UserProfile(firstName: 'Kim', lastName: 'Chau', avatar: 'assets/temporary/img_temp_3.png'),
    category: ClassifiedsCategory.events,
    thumbnail: 'assets/temporary/img_temp_1.png',
    images: [
      'assets/temporary/img_temp_1.png',
      'assets/temporary/img_temp_2.jpeg',
      'assets/temporary/img_temp_3.png',
    ],
    listingDate: '24.02.2023',
    description: 'The plane crash bordering Nepal and India have caused heart aches for many families. '
        'Please come and join April 1, 2023 to come pray together and share our love for our community.',
    location: 'Porkhara, Nepal',
    date: 'April 1, 2023',
    time: '8:30PM - 9:30PM',
    price: '\$150 - \$300',
    tickets: [
      TicketModel(title: 'Platinum', price: '\$300'),
      TicketModel(title: 'Bronze', price: '\$150'),
      TicketModel(title: 'Gold', price: '\$250'),
      TicketModel(title: 'Silver', price: '\$200'),
    ], imageUrl: '', author: '',
  ),
  Marketplace(
    title: 'Film Camera',
    user: const UserProfile(firstName: 'Kim', lastName: 'Chau', avatar: 'assets/temporary/img_temp_3.png'),
    category: ClassifiedsCategory.for_sale,
    thumbnail: 'assets/temporary/img_temp_2.jpeg',
    images: [
      'assets/temporary/img_temp_1.png',
      'assets/temporary/img_temp_2.jpeg',
      'assets/temporary/img_temp_3.png',
    ],
    listingDate: '24.02.2023',
    description: 'The plane crash bordering Nepal and India have caused heart aches for many families. '
        'Please come and join April 1, 2023 to come pray together and share our love for our community.',
    location: 'Porkhara, Nepal',
    status: 'Used',
    price: '\$300.00', imageUrl: '', author: '',
  ),
  Marketplace(
    title: 'Apartment for rent',
    user: const UserProfile(firstName: 'Kim', lastName: 'Chau', avatar: 'assets/temporary/img_temp_3.png'),
    category: ClassifiedsCategory.real_estate,
    thumbnail: 'assets/temporary/img_temp_1.png',
    images: [
      'assets/temporary/img_temp_1.png',
      'assets/temporary/img_temp_2.jpeg',
      'assets/temporary/img_temp_3.png',
    ],
    listingDate: '24.02.2023',
    description: 'The plane crash bordering Nepal and India have caused heart aches for many families. '
        'Please come and join April 1, 2023 to come pray together and share our love for our community.',
    location: 'Porkhara, Nepal',
    price: '\$3500/month',
    bathrooms: 2,
    bedrooms: 2, imageUrl: '', author: '',
  ),
  Marketplace(
    title: 'Construction',
    user: const UserProfile(firstName: 'Kim', lastName: 'Chau', avatar: 'assets/temporary/img_temp_3.png'),
    category: ClassifiedsCategory.job_posting,
    thumbnail: 'assets/temporary/img_temp_1.png',
    images: [
      'assets/temporary/img_temp_1.png',
      'assets/temporary/img_temp_2.jpeg',
      'assets/temporary/img_temp_3.png',
    ],
    listingDate: '24.02.2023',
    description: 'The plane crash bordering Nepal and India have caused heart aches for many families. '
        'Please come and join April 1, 2023 to come pray together and share our love for our community.',
    location: 'Porkhara, Nepal',
    price: '\$4000',
    minimumQualifications: ['3-5 years of experience', 'Knowledgeable in CI/CD'],
    jobDescription: ['Participate in sprint planning', 'Mentor junior developers'], imageUrl: '', author: '',
  ),
  Marketplace(
    title: 'Lorem Ipsum Dolor',
    user: const UserProfile(firstName: 'Kim', lastName: 'Chau', avatar: 'assets/temporary/img_temp_3.png'),
    category: ClassifiedsCategory.misc,
    thumbnail: 'assets/temporary/img_temp_2.jpeg',
    images: [
      'assets/temporary/img_temp_1.png',
      'assets/temporary/img_temp_2.jpeg',
      'assets/temporary/img_temp_3.png',
    ],
    location: 'Porkhara, Nepal',
    listingDate: '24.02.2023',
    description: 'The plane crash bordering Nepal and India have caused heart aches for many families. '
        'Please come and join April 1, 2023 to come pray together and share our love for our community.', imageUrl: '', author: '',
  ),
];

// Dashboard
final feedMockList = [
  // text
  [
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
  ],
  // classifieds
  [
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
  ],
  [
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
  ],
  [
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
  ],
  [
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
  ],
];
