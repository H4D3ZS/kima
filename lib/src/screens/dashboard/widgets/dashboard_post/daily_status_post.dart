import 'package:flutter/cupertino.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class DailyStatusPost extends StatelessWidget {
  final String? text;

  const DailyStatusPost(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 10.0),
        child: CustomText(text ?? '', fontWeight: FontWeight.w400),
      );
}
