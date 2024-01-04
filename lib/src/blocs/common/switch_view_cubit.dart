import 'package:bloc/bloc.dart';

/// For FavoritesScreen only
class SwitchViewCubit extends Cubit<String> {
  SwitchViewCubit() : super('');

  void selectedRoute(String route) {
    emit(route);
  }
}
