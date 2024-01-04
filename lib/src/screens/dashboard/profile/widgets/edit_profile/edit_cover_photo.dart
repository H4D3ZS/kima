import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/screens/dashboard/profile/widgets/edit_profile/edit_section_title.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/helpers/image_picker_helper.dart';
import 'package:kima/src/utils/mixins.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';

class EditCoverPhoto extends StatelessWidget with DialogMixins {
  const EditCoverPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Column(
            children: [
              EditSectionTitle('Cover Photo',
                  onTapEdit: () => showImagePickerBottomSheet(
                        context,
                        onSelectCamera: () => onUploadCoverPhoto(context, source: ImageSource.camera),
                        onSelectGallery: () => onUploadCoverPhoto(context, source: ImageSource.gallery),
                      )),
              const VerticalSpace(25.0),
              if (state.photoStatus == PhotoStatus.coverLoading)
                Container(
                  height: 230.0,
                  color: Colors.transparent,
                  child: const Center(child: CircularProgressIndicator()),
                )
              else
                FutureBuilder(
                    future: CacheManagerHelper.getImageFromCache('${state.user!.id!}_cover'),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(
                            File(snapshot.data!),
                            width: double.infinity,
                            height: 230.0,
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                        );
                      }
                      return Container(
                        width: double.infinity,
                        height: 230.0,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          color: AppColors.lightGrey20,
                        ),
                      );
                    }),
            ],
          );
        },
      );

  void onUploadCoverPhoto(BuildContext context, {required ImageSource source}) {
    context.read<UserBloc>().add(UploadUserPhotoEvent(
          type: 'cover_photo',
          source: source,
        ));
    Navigator.pop(context);
  }
}
