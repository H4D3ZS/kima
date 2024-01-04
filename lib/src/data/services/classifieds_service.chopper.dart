// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classifieds_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_string_interpolations, unnecessary_brace_in_string_interps
final class _$ClassifiedsService extends ClassifiedsService {
  _$ClassifiedsService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ClassifiedsService;

  @override
  Future<Response<dynamic>> getClassifieds({
    required String token,
    required int page,
    required int perPage,
  }) {
    final Uri $url = Uri.parse('/classifieds');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'perPage': perPage,
    };
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> createClassifieds({
    required String token,
    required String category,
    required Map<String, dynamic> body,
  }) {
    final Uri $url = Uri.parse('/classifieds/${category}');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> uploadGallery({
    required String token,
    required int id,
    required List<MultipartFile> images,
  }) {
    final Uri $url = Uri.parse('/classifieds/${id}/upload/gallery');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<List<MultipartFile>>(
        'images',
        images,
      )
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
