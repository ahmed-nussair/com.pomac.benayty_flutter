part of 'credentials_service.dart';

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
    final $url = '/benaity/public/api/users/register';
    final $body = data;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> forgotPassword(Map<String, dynamic> data) {
    final $url = '/benaity/public/api/users/forget_password';
    final $body = data;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> checkResetCode(Map<String, dynamic> data) {
    final $url = '/benaity/public/api/users/check_reset_code';
    final $body = data;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> resetPassword(Map<String, dynamic> data) {
    final $url = '/benaity/public/api/users/reset_password';
    final $body = data;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
