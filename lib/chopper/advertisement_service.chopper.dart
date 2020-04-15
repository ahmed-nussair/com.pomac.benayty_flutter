// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advertisement_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$AdvertisementService extends AdvertisementService {
  _$AdvertisementService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = AdvertisementService;

  @override
  Future<Response<dynamic>> filterAdvertisements(
      int mainId, int secondaryId, int areaId, int cityId) {
    final $url = '/benaity/public/api/advertisement';
    final $params = <String, dynamic>{
      'main_id': mainId,
      'secondary_id': secondaryId,
      'area_id': areaId,
      'city_id': cityId
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> showAdvertisement(int advertisementId) {
    final $url = '/benaity/public/api/advertisement/show';
    final $params = <String, dynamic>{'advertisement_id': advertisementId};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addToWishList(Map<String, dynamic> data) {
    final $url = '/benaity/public/api/wishlist/add';
    final $body = data;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteFromWishList(Map<String, dynamic> data) {
    final $url = '/benaity/public/api/wishlist/delete';
    final $body = data;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addComment(Map<String, dynamic> body) {
    final $url = '/benaity/public/api/comment/add';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getUserData(int userId) {
    final $url = '/benaity/public/api/users/show';
    final $params = <String, dynamic>{'user_id': userId};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getUserAds(int userId) {
    final $url = '/benaity/public/api/users/advertisements';
    final $params = <String, dynamic>{'user_id': userId};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

}
