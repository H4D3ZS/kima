import 'package:flutter/material.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/constants.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';

class MarketplaceCategory extends StatelessWidget {
  const MarketplaceCategory({
    Key? key,
    required this.onTap,
    required this.type,
    required this.title,
    required this.index,
  }) : super(key: key);

  final VoidCallback onTap;
  final ClassifiedsCategory type;
  final String title;
  final int index;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Wrap(
          children: [
            Chip(
              label: Row(
                children: [
                  IconMap.marketplaceCategory[type]!.svg(
                    colorFilter: (index == 0 ? AppColors.primaryColor : AppColors.lightGrey10).toColorFilter,
                  ),
                  const HorizontalSpace(10.0),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: index == 0 ? AppColors.primaryColor : AppColors.lightGrey10,
                    ),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
              backgroundColor: index == 0 ? AppColors.green.withOpacity(0.08) : const Color(0xFFF4F4F4),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ],
        ),
      );
}
