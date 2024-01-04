import 'package:flutter/material.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/screens/message/chat_screen.dart';
import 'package:kima/src/screens/message/new_message_screen.dart';
import 'package:kima/src/screens/message/working%20chat/conversation_screen.dart';
import 'package:kima/src/screens/message/working%20chat/message_screen.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class ClassifiedsMessageBox extends StatelessWidget {
  const ClassifiedsMessageBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: const Size.fromWidth(370.0).width,
        height: 110.0,
        padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 20.0),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.white5),
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ListTile(
                leading: Assets.icons.messageCircle.svg(),
                title: const CustomText('Send seller a message', fontWeight: FontWeight.w300),
                horizontalTitleGap: 0.0,
                contentPadding: EdgeInsets.zero,
                dense: true,
                visualDensity: VisualDensity.compact,
              ),
            ),
            const VerticalSpace(15.0),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, ChatScreen.route);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                      decoration: const BoxDecoration(
                        color: AppColors.lightGrey20,
                        borderRadius: BorderRadius.all(Radius.circular(100.0)),
                      ),
                      child: const CustomText('Hello, I’m interested!', fontWeight: FontWeight.w300),
                    ),
                  ),
                  const HorizontalSpace(15.0),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                    decoration: const BoxDecoration(
                      color: AppColors.green,
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    ),
                    child: const CustomText(
                      'Send',
                      fontWeight: FontWeight.w300,
                      fontColor: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
