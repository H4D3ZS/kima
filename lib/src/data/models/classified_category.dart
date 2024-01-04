
import 'package:flutter/cupertino.dart';

class ClassifiedCategory {
  final IconData? iconData;
  final String? title;

  ClassifiedCategory({this.iconData, this.title});

  @override
  String toString() {
    return 'ClassifiedCategory{iconData: $iconData, title: $title}';
  }

}