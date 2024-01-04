import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/src/data/models/Members.dart';

class FavoriteCubit extends Cubit<Members?> {
  FavoriteCubit() : super(null);

  void select(BuildContext context, Members member) {
    emit(member);
  }
}
