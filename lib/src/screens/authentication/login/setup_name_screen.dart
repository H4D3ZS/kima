import 'package:flutter/material.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_button.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';
import 'package:kima/src/utils/widgets/customs/labeled_text_field.dart';

class SetupNameScreen extends StatefulWidget {
  static const route = '/login/setup-name';

  const SetupNameScreen({Key? key}) : super(key: key);

  @override
  State<SetupNameScreen> createState() => _SetupNameScreenState();
}

class _SetupNameScreenState extends State<SetupNameScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _middleNameController;
  late TextEditingController _lastNameController;

  @override
  void initState() {
    _firstNameController = TextEditingController()..addListener(() => setState(() => {}));
    _middleNameController = TextEditingController()..addListener(() => setState(() => {}));
    _lastNameController = TextEditingController()..addListener(() => setState(() => {}));
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 2.0,
        shadowColor: const Color(0xFFC3C3D1).withOpacity(0.25),
        toolbarHeight: 95.0,
        leadingWidth: 110.0,
        leading: CircularIconButton(
          icon: Assets.icons.iconArrowLeft.svg(),
          bgColor: AppColors.lightGrey20,
          margin: const EdgeInsets.symmetric(horizontal: 30.0),
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              'Name',
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
            const VerticalSpace(40.0),
            LabeledTextField(
              label: 'First name',
              controller: _firstNameController,
            ),
            const VerticalSpace(30.0),
            LabeledTextField(
              label: 'Middle name',
              controller: _middleNameController,
            ),
            const VerticalSpace(30.0),
            LabeledTextField(
              label: 'Last name',
              controller: _lastNameController,
            ),
            const VerticalSpace(30.0),
            CustomButton.green(
              backgroundColor: AppColors.green.withOpacity(0.24),
              borderColor: Colors.transparent,
              labelColor: AppColors.green,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              enable: _enableSave,
              label: 'Save',
              onPressed: () {
                // TODO: Apple sign in require providing first and last name
              },
            ),
          ],
        ),
      ),
    );
  }

  bool get _enableSave {
    final hasFirstName = _firstNameController.text.isNotEmpty;
    final hasLastName = _lastNameController.text.isNotEmpty;

    if (hasFirstName && hasLastName) return true;
    return false;
  }
}
