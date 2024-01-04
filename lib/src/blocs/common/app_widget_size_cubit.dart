import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';

class AppWidgetSizeCubit extends Cubit<Size?>{

  AppWidgetSizeCubit():super(null);

  void emitSize(Size size){
    emit(size);
  }
}