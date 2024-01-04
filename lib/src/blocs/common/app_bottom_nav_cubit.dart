import 'package:bloc/bloc.dart';
import 'package:kima/src/utils/enums.dart';

/// To change the selected nav in bottom navigator
class AppBottomNavCubit extends Cubit<BottomNavEnum> {
  AppBottomNavCubit() : super(BottomNavEnum.home);

  void emitBottomNav(BottomNavEnum nav) {
    emit(nav);
  }
}
