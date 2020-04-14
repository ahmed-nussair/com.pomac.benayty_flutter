part of 'profile_service.dart';

class _$ProfileService extends ProfileService {
  _$ProfileService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ProfileService;

  Future<Response<dynamic>> getProfile(String token) {
    final $url = '/benaity/public/api/myaccount';
    final $params = <String, dynamic>{'token': token};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response<dynamic>> getUserAds(String token) {
    final $url = '/benaity/public/api/myadvertisements';
    final $params = <String, dynamic>{'token': token};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response<dynamic>> getAllAds(String token) {
    final $url = '/benaity/public/api/alladvertisement';
    final $params = <String, dynamic>{'token': token};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response<dynamic>> displayUserAd(int adId, String token) {
    final $url = '/benaity/public/api/advertisements/display';
    final $params = <String, dynamic>{'advertisement_id': adId, 'token': token};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> removeAd(Map<String, dynamic> data) {
    final $url = '/benaity/public/api/advertisements/delete';
    final $body = data;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updatePassword(Map<String, dynamic> data) {
    final $url = '/benaity/public/api/account/update-password';
    final $body = data;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateProfile(Map<String, dynamic> data) {
    final $url = '/benaity/public/api/account/update-profile';
    final $body = data;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
