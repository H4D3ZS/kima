import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kima/src/constants/classifieds_constants.dart';
import 'package:kima/src/data/models/classifieds_model.dart';
import 'package:kima/src/screens/classifieds/forms/events/events_form.dart';
import 'package:kima/src/screens/classifieds/forms/for_sale_form.dart';
import 'package:kima/src/screens/classifieds/forms/job_posting_form.dart';
import 'package:kima/src/screens/classifieds/forms/misc_form.dart';
import 'package:kima/src/screens/classifieds/forms/real_estate_form.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/helpers/color_helpers.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/common/header_wrapper.dart';

class BigCircle {
  String key;
  String label;
  bool? isActive;
  bool? isDone;

  BigCircle({
    this.isActive = false,
    this.isDone = false,
    required this.key,
    required this.label
  });
}

class ClassifiedsScreen extends StatefulWidget {
  const ClassifiedsScreen({super.key});

  static const route = '/classifieds';

  @override
  State<ClassifiedsScreen> createState() => _ClassifiedsScreenState();
}

class _ClassifiedsScreenState extends State<ClassifiedsScreen> {

  String titleHeader = 'Create Classifieds';
  String selectedValue = '';
  int step = 0;

  @override
  void initState() {
    super.initState();
  }

  String titleHandler() {
    if (step == 1) {
      List<FieldEntity> selectors = ClassifiedsConstants.selectorFields;
      for (var i = 0; i < selectors.length; i++) {
        if (selectedValue == selectors[i].key) {
          setState(() {
            titleHeader = '${selectors[i].title} Details';
          });
        }
      }
      return titleHeader;
    } else {
      setState(() {
        titleHeader = 'Create Classifieds';
      });
    }
    return titleHeader;
  }

  @override
  Widget build(BuildContext context) {
    return HeaderWrapper(
      titleHeader: titleHandler(),
      onBack: () => {
        if (step == 1) {
          setState(() {
            step = 0;
          })
        } else {
          Navigator.pop(context)
        }
      },
      elevation: 2,
      toolbarHeight: 95.0,
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.only(top: 80.0),
              children: [
                step == 0
                  ? categoryList(ClassifiedsConstants.selectorFields)
                  : fieldContainer()
              ],
            ),
            Positioned(
              child: stepper(step)
            ),
            step == 0 ? Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: saveAndProceedBtn(
                selectedValue: selectedValue,
                onTap: () {
                  setState(() {
                    step = 1;
                  });
                }
              )
            ) : const SizedBox()
          ],
        )
      )
    );
  }

  Widget _selectorCards(FieldEntity cardInfo) {
    bool isSelected = selectedValue == cardInfo.key;
    return GestureDetector(
      onTap: () => {
        setState(() {
          selectedValue = cardInfo.key;
        })
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: HexColor(isSelected ? '#38CC96' : '#EBEBEB'),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(5.0))
        ),
        child: Row(
          children: [
            isSelected ? cardInfo.iconDataActive! : cardInfo.iconData!,
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Text(
                cardInfo.title,
                style: TextStyle(
                  color: HexColor(isSelected ? '#38CC96' : '#000000'),
                  fontSize: 16.0
                )
              )
            )
          ],
        ),
      )
    );
  }

  Widget categoryList(List<FieldEntity> categoryList) {
    List<Widget> cards = [];
    for (var i = 0; i < categoryList.length; i++) {
      cards.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: _selectorCards(categoryList[i]),
        )
      );
    }
    return Column(
      children: cards
    );
  }

  Widget fieldContainer() {
    switch (selectedValue) {
      case 'events':
        return const EventsForm();
      case 'for_sale':
        return const ForSaleForm();
      case 'misc':
        return const MiscForm();
      case 'job_posting':
        return const JobPostingForm();
      case 'real_estate':
        return const RealEstateForm();
      default:
        return const SizedBox();
    }
  }

  Widget saveAndProceedBtn({ String? selectedValue, void Function()? onTap }) {
    bool hasSelected = selectedValue != '';
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.lightGrey40,
            blurRadius: 10.0,
            offset: Offset(0.0, -3)
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () => {
          setState(() {
            step = 1;
          })
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
          child: Container(
            decoration: BoxDecoration(
              color: HexColor(hasSelected ? '#38CC96' : '#F4F4F4'),
              borderRadius: const BorderRadius.all(Radius.circular(5.0))
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Save and Proceed',
                style: TextStyle(
                  color: HexColor(hasSelected ? '#FFFFFF' : '#757575'),
                  fontWeight: hasSelected ? FontWeight.w700 : FontWeight.w400
                ),
                textAlign: TextAlign.center
              ),
            )
          )
        ),
      )
    );
  }

  Widget stepper(int step) => Container(
    color: HexColor('#FFFFFF'),
    width: double.infinity,
    height: MediaQuery.of(context).size.height * 0.090,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          bigCircle(
            key: '1',
            label: 'Category',
            isActive: step == 0,
            isDone: step == 1,
            index: 0,
            context: context
          ),
          Expanded(
            child: MySeparatorWidget(
              margin: const EdgeInsets.only(bottom: 15),
              color: Colors.grey.withOpacity(0.3),
            ),
          ),
          bigCircle(
            key: '2',
            label: 'Details',
            isActive: step == 1,
            index: 1,
            isDone: false,
            context: context
          ),
        ],
      )
    )
  );

}

Widget bigCircle({
  required String key,
  required String label,
  bool? isActive,
  bool? isDone,
  int? index,
  dynamic context
}) {
  return Column(
    crossAxisAlignment: index == 0 ? CrossAxisAlignment.start : CrossAxisAlignment.end,
    children: [
      Container(
        // width: 30.0,
        // height: 30.0,
        width: MediaQuery.of(context).size.height * 0.030,
        height: MediaQuery.of(context).size.height * 0.030,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isDone! ? AppColors.orange : isActive! ? AppColors.primaryColor : AppColors.lightGrey30,
          shape: BoxShape.circle,
        ),
        child: Text(
          key,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: (isActive! || isDone) ? Colors.white : AppColors.lightGrey10,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Text(label,
        style: GoogleFonts.poppins(
          color: isActive ? AppColors.primaryColor : AppColors.lightGrey10
        )
      )
    ],
  );
}