import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/src/blocs/main/classifieds/classifieds_bloc.dart';
import 'package:kima/src/data/models/classifieds/classifieds.dart';
import 'package:kima/src/data/models/classifieds/for_sale.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/widgets/common/gallery_widget.dart';
import 'package:kima/src/utils/widgets/customs/custom_loader.dart';
import 'package:kima/src/utils/widgets/customs/custom_snackbar.dart';
import 'generic_widgets.dart';

class ForSaleForm extends StatefulWidget {
  const ForSaleForm({super.key});

  @override
  State<ForSaleForm> createState() => _ForSaleFormState();
}

class _ForSaleFormState extends State<ForSaleForm> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  final _locationController = TextEditingController();
  late ClassifiedsBloc _classifiedsBloc;

  List<File> selectedFiles = [];
  List<String> conditions = ['New', 'Used', 'Like new', 'Used - good', 'Used - fair'];
  String selectedCondition = '';

  @override
  void initState() {
    _classifiedsBloc = BlocProvider.of<ClassifiedsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClassifiedsBloc>.value(
      value: _classifiedsBloc,
      child: BlocListener<ClassifiedsBloc, ClassifiedsState>(
        listener: (context, state) {
          final status = state.status;

          if (status == Status.loading) {
            showLoader(context);
          }
          if (status == Status.failed) {
            closeLoader(context);
            CustomSnackBar.error(context, state.error!.message);
          }
          if (status == Status.success) {
            closeLoader(context);
            Navigator.pop(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              inputField(label: 'Title', textHints: 'Post Title', controller: _titleController),
              inputField(
                  label: 'Description',
                  textHints: 'Post Description',
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  controller: _descController),
              GalleryWidget(
                label: 'Gallery',
                onChanged: (files) => setState(() => selectedFiles = files),
              ),
              inputField(
                label: 'Price',
                textHints: 'Enter price here',
                controller: _priceController,
                keyboardType: TextInputType.number,
              ),
              inputField(label: 'Location', textHints: 'Enter location here', controller: _locationController),
              inputDropdownSelection(
                  label: 'Condition',
                  textHints: 'Select Condition',
                  items: conditions,
                  selected: selectedCondition,
                  onChanged: (dynamic val) {
                    setState(() {
                      selectedCondition = val;
                    });
                  }),
              publishButton(
                onTap: () {
                  final classifiedAd = Classifieds(
                    title: _titleController.text,
                    description: _descController.text,
                    location: _locationController.text,
                    category: ClassifiedsCategory.for_sale.name,
                    forSaleDetails: ForSale(
                      price: double.parse(_priceController.text),
                      itemCondition: selectedCondition.replaceAll('-', '').split(' ').join(' ').toLowerCase(),
                    ),
                  );

                  context.read<ClassifiedsBloc>().add(
                        CreateClassifiedsEvent(
                          classifiedAd: classifiedAd,
                          gallery: selectedFiles,
                        ),
                      );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
