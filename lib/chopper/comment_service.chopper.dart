// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$CommentService extends CommentService {
  _$CommentService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = CommentService;

  @override
  Future<Response<dynamic>> addComment(Map<String, dynamic> body) {
    final $url = '/benaity/public/api/comment/add';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
