// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_string_interpolations, unnecessary_brace_in_string_interps
final class _$UserService extends UserService {
  _$UserService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = UserService;

  @override
  Future<Response<dynamic>> getById({
    required String token,
    required String id,
  }) {
    final Uri $url = Uri.parse('/members/${id}');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> update({
    required String token,
    required Map<String, dynamic> body,
  }) {
    final Uri $url = Uri.parse('/members');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> uploadAvatar({
    required String token,
    required MultipartFile image,
  }) {
    final Uri $url = Uri.parse('/members/upload/avatar');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<MultipartFile>(
        'image',
        image,
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

  @override
  Future<Response<dynamic>> uploadCover({
    required String token,
    required MultipartFile image,
  }) {
    final Uri $url = Uri.parse('/members/upload/cover');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<MultipartFile>(
        'image',
        image,
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

  @override
  Future<Response<dynamic>> getMembers({
    required String token,
    required int page,
    required int perPage,
  }) {
    final Uri $url = Uri.parse('/members');
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
  Future<Response<dynamic>> createDailyStatus({
    required String token,
    required Map<String, dynamic> body,
  }) {
    final Uri $url = Uri.parse('/members/daily-status');
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
  Future<Response<dynamic>> getAllDailyStatusById({
    required String token,
    String? id,
  }) {
    final Uri $url = Uri.parse('/members/daily-status');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMyFavorites({required String token}) {
    final Uri $url = Uri.parse('/members/favorite');
    final Map<String, String> $headers = {
      'Authorization': token,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
