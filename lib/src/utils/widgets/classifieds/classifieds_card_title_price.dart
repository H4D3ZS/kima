import 'package:flutter/material.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class ClassifiedsCardTitlePrice extends StatelessWidget {
  const ClassifiedsCardTitlePrice(
    this.title,
    this.price, {
    Key? key,
    this.isMonthlyPayment = false,
  }) : super(key: key);

  final String title;
  final String? price;
  final bool isMonthlyPayment;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(title, fontWeight: FontWeight.w400),
          isMonthlyPayment
              ? RichText(
                  text: const TextSpan(
                    text: '\$3500',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                    children: [
                      TextSpan(
                        text: '/month',
                        style: TextStyle(
                          color: AppColors.lightGrey10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                )
              : Text(
                  price ?? '',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
        ],
      );
}
