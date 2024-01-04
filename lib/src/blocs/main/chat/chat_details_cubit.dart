import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/src/data/models/members.dart';

class ChatDetailsCubit extends Cubit<Members?> {
  ChatDetailsCubit() : super(null);

  void select(BuildContext context, Members members) {
    emit(members);
  }
}
