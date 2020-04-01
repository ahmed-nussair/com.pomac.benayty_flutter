// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credentials_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$CredentialsService extends CredentialsService {
  _$CredentialsService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = CredentialsService;

  @override
  Future<Response<dynamic>> login(Map<String, dynamic> data) {
    final $url = '/benaity/public/api/login';
    final $body = data;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> register(Map<String, dynamic> data) {
    final $url = '/benaity/public/api/register';
    final $body = data;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
