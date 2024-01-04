enum AppFlavorsEnum {
  none,
  dev,
  qa,
  stg,
  prod,
}

enum UserTypeEnum {
  none(''),
  member('Member'),
  professional('Professional'),
  business('Business');

  const UserTypeEnum(this.type);

  final String type;
}

enum ApiRequestEnum {
  delete,
  get,
  patch,
  post,
  put,
}

enum ValidationEnum {
  none,
  valid,
  invalid,
}

enum BottomNavEnum {
  home,
  search,
  market,
  favorite,
  message,
}

enum SsoEnum {
  none,
  google,
  apple,
  facebook,
}

enum ClassifiedsCategory {
  all('All Categories'),
  events('Events'),
  real_estate('Real States'),
  for_sale('For Sale'),
  job_posting('Job Posting'),
  misc('Miscellaneous');

  const ClassifiedsCategory(this.label);

  final String label;
}

enum ReportEnum {
  hateSpeech('Hate Speech'),
  sexual('Nudity or Sexual Content'),
  violence('Violence'),
  harassment('Harassment'),
  unauthorizedSale('Unauthorized Sales'),
  pretend('Pretending to be something'),
  fraud('Fraud or scam'),
  fakeAccount('Fake account'),
  fakeName('Fake name'),
  intellectualProperty('Intellectual property'),
  accountAccess('I can\'t access my account'),
  others('Something else');

  const ReportEnum(this.name);

  final String name;
}

enum ReportType {
  user,
  classifieds,
}

enum NotificationEnum {
  unread,
  read,
}

enum Status {
  initial,
  loading,
  success,
  failed,
}

enum PhotoStatus {
  avatarLoading,
  coverLoading,
  success,
  failed,
}

enum QrAction {
  share,
  save,
}

enum Gender {
  female('Female'),
  male('Male');

  const Gender(this.label);

  final String label;
}

enum Layout {
  grid,
  list,
}

enum Post {
  classifieds,
  status,
}

enum Feed {
  dashboard,
  profile,
}
