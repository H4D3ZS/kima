import 'package:flutter/material.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class RegistrationAccountType extends StatelessWidget {
  final UserTypeEnum? userTypeEnum;
  final Function(UserTypeEnum?)? onUserTypeChanged;

  const RegistrationAccountType({
    super.key,
    required this.userTypeEnum,
    required this.onUserTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          width: 2,
          color: const Color(0xFFEBEBEB),
        ),
        color: const Color(0xFFFFFFFF),
      ),
      child: DropdownButtonFormField<UserTypeEnum>(
        dropdownColor: AppColors.lightGrey30,
        value: userTypeEnum,
        elevation: 0,
        style: const TextStyle(
          color: Color(0xFF1E1E1E),
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),
        items: UserTypeEnum.values.map<DropdownMenuItem<UserTypeEnum>>(
          (UserTypeEnum value) {
            String type = value.type;

            if (value == UserTypeEnum.none) {
              type = 'Select Account Type';
            }

            return DropdownMenuItem<UserTypeEnum>(
              value: value,
              child: CustomText(
                type,
                fontColor: const Color(0xFF1E1E1E),
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            );
          },
        ).toList(),
        onChanged: onUserTypeChanged,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(16.0),
          hintText: 'Select Account Type',
          hintStyle: TextStyle(
            color: Color(0xFF757575),
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}
