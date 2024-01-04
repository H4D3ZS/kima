import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/screens/dashboard/profile/widgets/edit_profile/edit_section_title.dart';
import 'package:kima/src/screens/dashboard/profile/widgets/profile_avatar.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/mixins.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';

class EditProfileImage extends StatelessWidget with DialogMixins {
  const EditProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Column(
            children: [
              EditSectionTitle('Profile Image',
                  onTapEdit: () => showImagePickerBottomSheet(
                        context,
                        onSelectCamera: () => onUploadAvatar(context, source: ImageSource.camera),
                        onSelectGallery: () => onUploadAvatar(context, source: ImageSource.gallery),
                      )),
              const VerticalSpace(5.0),
              if (state.photoStatus == PhotoStatus.avatarLoading)
                const CircleAvatar(
                  radius: 60.0,
                  backgroundColor: Colors.transparent,
                  child: CircularProgressIndicator(),
                )
              else
                const ProfileAvatar(),
            ],
          );
        },
      );

  void onUploadAvatar(BuildContext context, {required ImageSource source}) {
    context.read<UserBloc>().add(UploadUserPhotoEvent(
          type: 'avatar',
          source: source,
        ));
    Navigator.pop(context);
  }
}
