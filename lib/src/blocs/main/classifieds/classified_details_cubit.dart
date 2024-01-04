import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/src/data/models/classifieds_model.dart';

class ClassifiedDetailsCubit extends Cubit<Classified?> {
  ClassifiedDetailsCubit() : super(null);

  void select(BuildContext context, Classified classifiedAd) {
    emit(classifiedAd);
  }
}
