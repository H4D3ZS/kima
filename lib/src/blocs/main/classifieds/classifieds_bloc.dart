import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:kima/src/data/models/classifieds/classifieds.dart';
import 'package:kima/src/data/services/classifieds_service.dart';
import 'package:kima/src/utils/configs.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/exceptions/api_result_exception.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/failures/failure.dart';
import 'package:kima/src/utils/helpers/shared_pref_helpers.dart';

part 'classifieds_event.dart';
part 'classifieds_state.dart';

class ClassifiedsBloc extends Bloc<ClassifiedsEvent, ClassifiedsState> {
  ClassifiedsBloc() : super(const ClassifiedsState(status: Status.initial)) {
    on<GetClassifiedsEvent>(_getClassifieds);
    on<CreateClassifiedsEvent>(_createClassifieds);
  }

  final _chopper = ChopperClient(
    baseUrl: Uri.parse(baseUrlDev),
    converter: const JsonConverter(),
    services: [ClassifiedsService.create()],
  );

  @override
  Future close() {
    _chopper.dispose();
    return super.close();
  }

  Future<void> _getClassifieds(GetClassifiedsEvent event, emit) async {}

  Future<void> _createClassifieds(CreateClassifiedsEvent event, emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      final token = await readStringSharedPref(spProfileJwt);
      final classifiedAd = event.classifiedAd;

      final response = await _chopper.getService<ClassifiedsService>().createClassifieds(
            token: token!,
            category: classifiedAd.category!,
            body: classifiedAd.toJson()..removeWhere((key, value) => key == 'category'),
          );

      if (!response.isSuccessful) throw ApiResultException(message: json.decode(response.bodyString)['message']);

      final newClassifiedAd = Classifieds.fromJson(response.body['data']);

      if (event.gallery.isNotNullNorEmpty) await _uploadGallery(newClassifiedAd.id!, fileList: event.gallery!);

      emit(state.copyWith(status: Status.success));
    } on ApiResultException catch (e) {
      final error = e.message;
      emit(
        state.copyWith(
          status: Status.failed,
          error: error != null ? Failure(message: error) : const Failure(),
        ),
      );
    }
  }

  Future<void> _uploadGallery(int classifiedsId, {required List<File> fileList}) async {
    final token = await readStringSharedPref(spProfileJwt);

    List<MultipartFile> files = [];

    for (var file in fileList) {
      final multiPartFile = await MultipartFile.fromPath(
        'images',
        file.path,
        contentType: MediaType.parse('images/${file.path.fileType}'),
      );
      files.add(multiPartFile);
    }

    final response = await _chopper.getService<ClassifiedsService>().uploadGallery(
          token: token!,
          images: files,
          id: classifiedsId,
        );

    if (!response.isSuccessful) {
      if (response.statusCode == 413) throw const ApiResultException(message: 'File size too large');
      throw ApiResultException(message: json.decode(response.bodyString)['message']);
    }
  }
}
