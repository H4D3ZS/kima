import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class ClassifiedAdPhotoGrid extends StatelessWidget {
  final List<String> imageUrls;

  const ClassifiedAdPhotoGrid({
    Key? key,
    required this.imageUrls,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final count = imageUrls.length;

    // Show grid if images is more than 1, else show single image
    return SizedBox(
      width: double.infinity,
      height: 190.0,
      child: count == 2 || count >= 3
          ? GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: count >= 3 ? 3 : 2,
              gridDelegate: SliverQuiltedGridDelegate(
                crossAxisCount: 4,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                pattern: count >= 3
                    ? [
                        // itemCount >= 3
                        const QuiltedGridTile(2, 2),
                        const QuiltedGridTile(1, 2),
                        const QuiltedGridTile(1, 2),
                      ]
                    : [
                        // itemCount == 2
                        const QuiltedGridTile(2, 2),
                        const QuiltedGridTile(2, 2),
                      ],
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final imageUrl = imageUrls[index];
                return index == 2 && count > 3
                    ? InkWell(
                        onTap: () {},
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(imageUrl, fit: BoxFit.cover),
                            Positioned.fill(
                              child: Container(
                                alignment: Alignment.center,
                                color: Colors.black.withOpacity(0.68),
                                child: CustomText(
                                  '+${count - 3}',
                                  fontSize: 22.0,
                                  fontColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : InkWell(
                        onTap: () {},
                        child: Image.network(imageUrl, fit: BoxFit.cover),
                      );
              },
            )
          : InkWell(
              onTap: () {},
              child: Image.network(imageUrls.first, fit: BoxFit.cover),
            ),
    );
  }
}

// typedef void OnWidgetSizeChange(Size size);
//
// class MeasureSizeRenderObject extends RenderProxyBox {
//   Size? oldSize;
//   OnWidgetSizeChange onChange;
//
//   MeasureSizeRenderObject(this.onChange);
//
//   @override
//   void performLayout() {
//     super.performLayout();
//
//     Size newSize = child!.size;
//     if (oldSize == newSize) return;
//
//     oldSize = newSize;
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       onChange(newSize);
//     });
//   }
// }
//
// class MeasureSize extends SingleChildRenderObjectWidget {
//   final OnWidgetSizeChange onChange;
//
//   const MeasureSize({
//     Key? key,
//     required this.onChange,
//     required Widget child,
//   }) : super(key: key, child: child);
//
//   @override
//   RenderObject createRenderObject(BuildContext context) {
//     return MeasureSizeRenderObject(onChange);
//   }
//
//   @override
//   void updateRenderObject(BuildContext context, covariant MeasureSizeRenderObject renderObject) {
//     renderObject.onChange = onChange;
//   }
// }
