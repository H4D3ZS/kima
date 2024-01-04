import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/helpers/image_picker_helper.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/common/video_card.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class GalleryWidget extends StatefulWidget {
  final String label;
  final void Function(List<File>) onChanged;

  const GalleryWidget({
    super.key,
    required this.label,
    required this.onChanged,
  });

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  late List<File> gallery = [];
  late double totalFileSize = 0.0;

  void getGalleryItems() async {
    final items = await ImagePickerHelper.getMultipleMediaFromGallery();
    if (items?.isNotEmpty == true) gallery = [...gallery, ...items!];

    List<double> fileSizeList = [];

    for (var file in gallery) {
      final bytes = file.lengthSync();
      final mb = double.parse((bytes / 1000000).toStringAsFixed(2));
      fileSizeList.add(mb);
    }

    totalFileSize = fileSizeList.reduce((value, element) => value + element);

    if (totalFileSize > 10.0) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red.shade500,
            content: const CustomText(
              'Selected files could not be added, since total file size will exceed the maximum allowed size of 10MB.',
              alignment: TextAlign.center,
              fontColor: Colors.white,
            ),
          ),
        );
      }
      items?.forEach((item) => gallery.remove(item));
    } else {
      setState(() {});
      widget.onChanged(gallery);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(color: Color(0xFF9F9F9F)),
          ),
          const VerticalSpace(10.0),
          GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              if (gallery.isNotEmpty)
                ...gallery.map(
                  (file) => Container(
                    padding: const EdgeInsets.all(5),
                    child: ['.mp4', '.mov'].contains(file.path.fileType)
                        ? VideoCard(file)
                        : Image.file(File(file.path), fit: BoxFit.cover),
                  ),
                ),
              if (gallery.isEmpty || totalFileSize <= 10.0)
                InkWell(
                  onTap: getGalleryItems,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.27,
                        height: MediaQuery.of(context).size.width * 0.27,
                        color: Colors.grey.withOpacity(0.2),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
