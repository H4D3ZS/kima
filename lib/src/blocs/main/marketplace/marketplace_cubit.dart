import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/src/blocs/common/switch_view_cubit.dart';
import 'package:kima/src/data/models/marketplace.dart';
import 'package:kima/src/screens/marketplace/classifieds_description_screen.dart';

class ClassifiedsDescriptionScreen {
  static const String route = '/classifieds_description';
}

class MarketplaceCubit extends Cubit<Marketplace?> {
  MarketplaceCubit() : super(null);


  void select(BuildContext context, Marketplace classifiedAd) {
    emit(classifiedAd);
    BlocProvider.of<SwitchViewCubit>(context).selectedRoute(
        ClassifiedsDescriptionScreen.route);
  }
}
