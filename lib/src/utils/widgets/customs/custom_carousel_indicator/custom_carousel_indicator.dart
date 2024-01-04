import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/widgets/customs/custom_carousel_indicator/carousel_indicator.dart';

class CustomCarouselIndicator extends StatefulWidget {
  final List<Widget> children;
  final double height;

  const CustomCarouselIndicator({
    Key? key,
    required this.children,
    required this.height,
  }) : super(key: key);

  @override
  State<CustomCarouselIndicator> createState() => _CustomCarouselIndicatorState();
}

class _CustomCarouselIndicatorState extends State<CustomCarouselIndicator> {
  int currentIndex = 0;
  late CarouselController controller;

  @override
  void initState() {
    super.initState();
    controller = CarouselController();
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CarouselSlider(
                carouselController: controller,
                options: CarouselOptions(
                  viewportFraction: 1.0,
                  height: widget.height,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  onPageChanged: (int index, _) => setState(() => currentIndex = index),
                ),
                items: widget.children,
              ),
            ],
          ),
          Positioned(
            bottom: 20.0,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.children
                  .asMap()
                  .keys
                  .map((key) => CarouselDotIndicator(
                        color: currentIndex == key ? AppColors.green : AppColors.white5,
                        onTap: () => controller.animateToPage(key),
                      ))
                  .toList(),
            ),
          ),
        ],
      );
}
