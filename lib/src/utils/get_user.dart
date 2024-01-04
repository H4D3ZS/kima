import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';

String getUserId(BuildContext context) {
  // Use try-catch to handle the case where the user or user ID is null
  try {
    final userId = BlocProvider.of<UserBloc>(context).state.user!.id;
    return userId!;
  } catch (e) {
    // Handle the case where the user or user ID is null
    print('Error getting user ID: $e');
    return '';
  }
}
