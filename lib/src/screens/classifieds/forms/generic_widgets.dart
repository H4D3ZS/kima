
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kima/src/data/models/dynamic_model.dart';
import 'package:kima/src/screens/classifieds/widgets/dropdown_fields.dart';
import 'package:kima/src/screens/classifieds/widgets/text_fields.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/datetime.dart';
import 'package:kima/src/utils/helpers/color_helpers.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';

Widget publishButton({ bool? isLoading = false, void Function()? onTap }) {
  return GestureDetector(
    onTap: onTap,
    child: isLoading! ? Container(
      margin: const EdgeInsets.only(top: 20),
      height: 40,
      width: 40,
      child: const CircularProgressIndicator(),
    ) : Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: HexColor('#38CC96'),
        borderRadius: const BorderRadius.all(Radius.circular(5.0))
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          'Publish',
          style: TextStyle(
            color: HexColor('#FFFFFF'),
            fontWeight: FontWeight.w700
          ),
          textAlign: TextAlign.center
        ),
      )
    )
  );
}

Widget inputTimeField({
  required void Function(dynamic) onChanged,
  required String label,
  String? value,
  dynamic context
  }) {

  void handlePicker() async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      }
    );
    var hour = selectedTime!.hour;
    var minute = selectedTime.minute;
    onChanged('$hour:$minute');
  }
  
  return Padding(
    padding: const EdgeInsets.only(bottom: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: HexColor('#9F9F9F')),),
        const VerticalSpace(10.0),
        InkWell(
          onTap: handlePicker,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                width: 1,
                color: AppColors.lightGrey30
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              color: Colors.white,
              height: 40,
              width: double.infinity,
              child: Text(value != '' ? getFormattedTime(value!) : '00:00',
                style: GoogleFonts.poppins(
                  color: AppColors.lightGrey10,
                  fontSize: 16
                )
              ),
            ),
          )
        ),
      ],
    )
  );
}

Widget inputDateField({
  required void Function(dynamic) onChanged,
  required String label,
  String? value,
  DateTime? defaultDate,
  dynamic context
  }) {

  void handlePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: defaultDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025)
    );
    onChanged(picked.toString());
  }
  
  return Padding(
    padding: const EdgeInsets.only(bottom: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: HexColor('#9F9F9F')),),
        const VerticalSpace(10.0),
        InkWell(
          onTap: handlePicker,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                width: 1,
                color: AppColors.lightGrey30
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              color: Colors.white,
              height: 40,
              width: double.infinity,
              child: Text(value != '' ? getFormattedDate(date: value!, format: 'MM/dd/yyyy') : 'MM/DD/YYYY',
                style: GoogleFonts.poppins(
                  color: AppColors.lightGrey10,
                  fontSize: 16
                )
              ),
            ),
          )
        ),
      ],
    )
  );
}

Widget inputField({
  required String label,
  String? textHints,
  TextInputType? keyboardType,
  int? maxLines,
  TextEditingController? controller,
  void Function(String)? onChanged
  }) => Padding(
  padding: const EdgeInsets.only(bottom: 20.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(color: HexColor('#9F9F9F')),),
      const VerticalSpace(10.0),
      SingleTextField(
        controller: controller,
        field: TextFieldProps(
          textHints: textHints,
          onChanged: onChanged,
          keyboardType: keyboardType,
          maxLines: maxLines
        )
      )
    ],
  )
);

Widget inputDropdownSelection({
  required String label,
  dynamic selected,
  String? textHints,
  required List<dynamic> items,
  required void Function(dynamic) onChanged
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: HexColor('#9F9F9F')),),
        const VerticalSpace(10.0),
        SingleDropdownField(
          field: DropdownFieldProps(
            textHints: textHints,
            selected: selected,
            items: items,
            onChanged: onChanged
          )
        ),
      ],
    )
  );
}

Widget inputGallery({
  required String label,
  List<dynamic>? imagesList,
  void Function()? onTap,
  dynamic context
}) => Padding(
  padding: const EdgeInsets.only(bottom: 20.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(color: HexColor('#9F9F9F')),),
      const VerticalSpace(10.0),
      _customGridWidgetGallery(items: imagesList!, onTap: onTap!),
      const VerticalSpace(10.0),
      imagesList.length <= 2 ? InkWell(
        onTap: onTap!,
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
      ) : const SizedBox()
    ],
  )
);

Widget _customGridWidgetGallery({
  required List<dynamic> items,
  required void Function() onTap
}) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      // mainAxisExtent: MediaQuery.of(context).size.height * 0.05,
    ),
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: items.length,
    itemBuilder: (context, index) {
      if (index == 0) {
        return Container(
          padding: const EdgeInsets.all(5),
          child: InkWell(
            onTap: onTap,
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
        );
      } else {
        return Container(
          padding: const EdgeInsets.all(5),
          child: Image.file(File(items[index].path), fit: BoxFit.cover)
        );
      }
    },
  );
}

Widget inputPrice({
  required String label,
  required dynamic selectedItem,
  required List<dynamic> items,
  void Function(String)? onCallback,
  dynamic context
}) {
  List<Widget> radioBtns = [];
  for (var i = 0; i < items.length; i++) {
      radioBtns.add(
        SizedBox(
          width: (MediaQuery.of(context).size.width / 2) - 100,
          height: 40.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 20.0,
                child: Radio<String>(
                  value: items[i].key,
                  groupValue: selectedItem,
                  onChanged: (val) {
                    onCallback!(val!);
                  }
                ),
              ),
              const SizedBox(width: 10,),
              Text(items[i].title)
            ],
          )
        )
      );
    }
  return Padding(
    padding: const EdgeInsets.only(bottom: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: HexColor('#9F9F9F')),),
        Row(children: radioBtns)
      ],
    ),
  );
}

Widget inputSalary({
  dynamic context,
  required String label,
  String? textHints,
  TextEditingController? controller,
  required List<dynamic> items,
  required String selectedSalary,
  required void Function(dynamic)? onChanged
}) {
  List<Widget> radioBtns = [];
    for (var i = 0; i < items.length; i++) {
      radioBtns.add(
        SizedBox(
          width: (MediaQuery.of(context).size.width / 2) - 50,
          height: 40.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 20.0,
                child: Radio<String>(
                  value: items[i].key,
                  groupValue: selectedSalary,
                  onChanged: onChanged
                ),
              ),
              const SizedBox(width: 10,),
              Text(items[i].title)
            ],
          )
        )
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: HexColor('#9F9F9F')),),
          Row(children: radioBtns),
          const VerticalSpace(10.0),
          selectedSalary == 'postSalary' ? SingleTextField(
            controller: controller,
            field: TextFieldProps(
              textHints: textHints
            )
          ) : const SizedBox(height: 0, width: 0,)
        ],
      )
    );
}

Widget _buildSectionBtns({
  String? deleteBtnTitle,
  String? addBtnTitle,
  void Function()? onDelete,
  void Function()? onAdd
}) => Row(
  children: [
    Expanded(
      child: GestureDetector(
        onTap: onDelete,
        child: Container(
          margin: EdgeInsets.zero,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: HexColor('#F4F4F4'),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.delete_outline,
                size: 23,
                color: HexColor('#757575'),
              ),
              const SizedBox(width: 10, height: 40,),
              Text(deleteBtnTitle!,
                style: TextStyle(
                  color: HexColor('#757575'),
                  fontSize: 16.0
                ),
                textAlign: TextAlign.center
              )
            ]
          )
        ),
      )
    ),
    const SizedBox(width: 10,),
    Expanded(
      child: GestureDetector(
        onTap: onAdd,
        child: Container(
          margin: EdgeInsets.zero,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: HexColor('#5A92E7'),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add,
                size: 23,
                color: Colors.white,
              ),
              const SizedBox(width: 10, height: 40,),
              Text(addBtnTitle!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0
                ),
                textAlign: TextAlign.center
              )
            ]
          )
        ),
      )
    ),
  ],
);

Widget inputMultipleTickets({
  void Function()? onAddFnc,
  void Function()? onDeleteFnc,
  required int count,
  required List<DynamicField> dynamicFields,
  dynamic context
}) {

  List<Widget> textFields = [];

  for (var i = 0; i < count; i++) {
    TextEditingController titleController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    dynamicFields.add(DynamicField(
      titleController: titleController,
      priceController: priceController
    ));

    textFields.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Expanded(child: SingleTextField(
              controller: dynamicFields[i].titleController,
              field: TextFieldProps(
                textHints: 'title'
              )
            )),
            const SizedBox(width: 10,),
            SizedBox(
              width: 100.0,
              child: SingleTextField(
                controller: dynamicFields[i].priceController,
                field: TextFieldProps(
                  textHints: 'price',
                  keyboardType: TextInputType.number
                )
              )
            ),
            const SizedBox(width: 10,),
            i != 0 ? InkWell(
              onTap: () {
                onDeleteFnc!();
                dynamicFields.removeAt(i);
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width * 0.12,
                height: MediaQuery.of(context).size.width * 0.12,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: const Icon(
                  Icons.delete_outline,
                  size: 23,
                  color: Colors.white,
                )
              ),
            ) : InkWell(
              onTap: onAddFnc,
              child: Container(
                padding: const EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width * 0.12,
                height: MediaQuery.of(context).size.width * 0.12,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: const Icon(
                  Icons.add,
                  size: 23,
                  color: Colors.white,
                )
              ),
            )
          ]
        ),
      )
    );
  }

  return Padding(
    padding: const EdgeInsets.only(bottom: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Ticket Price', style: TextStyle(color: AppColors.lightGrey8),),
        ...textFields
      ],
    )
  );
}

Widget inputSection({
  required String label,
  int? rowCount = 1,
  int? sectionCount = 1,
  void Function()? onAdd,
  void Function()? onDelete,
  void Function()? onAddSection,
  void Function()? onDeleteSection,
  required List<DynamicField> dynamicFields
}) {

  List<Widget> rowDetails = [];

  for (var i = 0; i < rowCount!; i++) {
    TextEditingController titleController = TextEditingController();
    TextEditingController detailController = TextEditingController();

    dynamicFields.add(DynamicField(
      titleController: titleController,
      priceController: detailController
    ));
    
    rowDetails.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Section Title', style: TextStyle(color: HexColor('#9F9F9F')),),
          const VerticalSpace(10.0),
          SingleTextField(
            controller: dynamicFields[i].titleController,
            field: TextFieldProps(
              textHints: 'Enter Section Title',
              onChanged: (String text) => {}
            )
          ),
          const VerticalSpace(10.0),
          Text('Section Details', style: TextStyle(color: HexColor('#9F9F9F')),),
          const VerticalSpace(10.0),
          SingleTextField(
            controller: dynamicFields[i].priceController,
            field: TextFieldProps(
              textHints: 'Enter Section Details',
              onChanged: (String text) => {},
              keyboardType: TextInputType.multiline,
              maxLines: 3
            )
          ),
          const VerticalSpace(10.0),
        ],
      )
    );
  }
  
  return Padding(
    padding: const EdgeInsets.only(bottom: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: HexColor('#9F9F9F')),),
        const VerticalSpace(10.0),
        DottedBorder(
          padding: const EdgeInsets.all(16),
          color: Colors.grey.withOpacity(0.2),
          strokeWidth: 2,
          dashPattern: const [10, 5,],
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...rowDetails,
                _buildSectionBtns(
                  addBtnTitle: 'Add row',
                  deleteBtnTitle: 'Delete row',
                  onDelete: () {
                    onDelete!();
                    dynamicFields.removeAt(dynamicFields.indexOf(dynamicFields[dynamicFields.length - 1]));
                  },
                  onAdd: onAdd
                ),
              ]
            ),
          ),
        ),
        const VerticalSpace(10.0),
        _buildSectionBtns(
          addBtnTitle: 'Add section',
          deleteBtnTitle: 'Delete section',
          onDelete: onDeleteSection,
          onAdd: onAddSection
        ),
      ],
    )
  );
}