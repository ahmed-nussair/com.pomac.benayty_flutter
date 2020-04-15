part of 'contact_service.dart';

class _$ContactService extends ContactService {
  _$ContactService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ContactService;

  @override
  Future<Response<dynamic>> contactUs(Map<String, dynamic> body) {
    final $url = '/benaity/public/api/contact_ud';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
