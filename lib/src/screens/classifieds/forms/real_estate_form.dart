import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kima/src/data/providers/classified_provider.dart';
import 'package:kima/src/screens/marketplace/marketplace_screen.dart';
import 'package:kima/src/utils/widgets/common/gallery_widget.dart';

import 'generic_widgets.dart';

class RealEstateForm extends StatefulWidget {
  const RealEstateForm({super.key});

  @override
  State<RealEstateForm> createState() => _RealEstateFormState();
}

class _RealEstateFormState extends State<RealEstateForm> {
  bool isLoading = false;

  ClassifiedProvider classifiedProvider = ClassifiedProvider();

  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _locationController = TextEditingController();
  final _priceController = TextEditingController();

  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];

  void selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList.addAll(selectedImages);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  void handleSubmit({ void Function()? onCallback }) async {
    setState(() {
      isLoading = true;
    });
    final title = _titleController.text;
    final description = _descController.text;
    final location = _locationController.text;
    final price = _priceController.text;

    await classifiedProvider.postClassified('real_estate', requestBody: {
      'title': title,
      'description': description,
      'location': location,
      'price': price
    });
    onCallback!();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          inputField(
            label: 'Title',
            textHints: 'Post Title',
            controller: _titleController
          ),
          inputField(
            label: 'Description',
            textHints: 'Post Description',
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            controller: _descController
          ),
          GalleryWidget(
            label: 'Gallery',
            onChanged: (files) {},
          ),
          inputField(
            label: 'Location',
            textHints: 'Enter location here',
            controller: _locationController
          ),
          inputField(
            label: 'Price',
            textHints: 'Enter price here',
            controller: _priceController,
            keyboardType: TextInputType.number
          ),
          publishButton(isLoading: isLoading, onTap: () => handleSubmit(
            onCallback: () => Navigator.pushNamed(context, MarketPlaceScreen.route)
          ))
        ],
      ),
    );
  }
}