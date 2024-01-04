import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/src/blocs/common/switch_view_cubit.dart';
import 'package:kima/src/screens/dashboard/profile/widgets/edit_profile/edit_section_title.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class EditData extends StatelessWidget {
  final String title;
  final String data;
  final VoidCallback onTapEdit;

  const EditData({
    Key? key,
    required this.title,
    required this.data,
    required this.onTapEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EditSectionTitle(
            title,
            onTapEdit: onTapEdit
          ),
          const VerticalSpace(15.0),
          CustomText(
            data,
            fontWeight: FontWeight.w400,
            fontColor: AppColors.lightGrey,
            overflow: TextOverflow.clip,
          ),
        ],
      );
}
