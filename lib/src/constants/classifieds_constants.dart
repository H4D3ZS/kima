import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/data/models/classifieds_model.dart';

class ClassifiedsConstants {
  static List<FieldEntity> selectorFields = <FieldEntity>[
    FieldEntity(
      title: 'Events',
      key: 'events',
      iconData: Assets.svg.svgClassifiedsEvents.svg(),
      iconDataActive: Assets.svg.svgClassifiedsEventsActive.svg()
    ),
    FieldEntity(
      title: 'For Sale',
      key: 'for_sale',
      iconData: Assets.svg.svgClassifiedsForSale.svg(),
      iconDataActive: Assets.svg.svgClassifiedsForSaleActive.svg()
    ),
    FieldEntity(
      title: 'Miscellaneous',
      key: 'misc',
      iconData: Assets.svg.svgClassifiedsMiscellaneous.svg(),
      iconDataActive: Assets.svg.svgClassifiedsMiscActive.svg()
    ),
    FieldEntity(
      title: 'Job Posting',
      key: 'job_posting',
      iconData: Assets.svg.svgClassifiedsJobPosting.svg(),
      iconDataActive: Assets.svg.svgClassifiedsJobPostingActive.svg()
    ),
    FieldEntity(
      title: 'Real Estate',
      key: 'real_estate',
      iconData: Assets.svg.svgClassifiedsRealEstate.svg(),
      iconDataActive: Assets.svg.svgClassifiedsRealEstateActive.svg()
    ),
  ];
}