import 'package:flutter/material.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';

class MarketplaceCardItemDetail extends StatelessWidget {
  const MarketplaceCardItemDetail({
    Key? key,
    required this.label,
    this.icon,
    this.labelColor = Colors.black,
  }) : super(key: key);

  final Widget? icon;
  final String? label;
  final Color labelColor;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Row(
          children: [
            if (icon != null) ...[
              icon!,
              const HorizontalSpace(5.0),
            ],
            Text(
              label ?? '',
              style: TextStyle(
                fontSize: 14.0,
                color: labelColor,
              ),
            ),
          ],
        ),
      );
}
