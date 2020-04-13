part of 'wishlist_service.dart';

class _$WishListService extends WishListService {
  _$WishListService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = WishListService;

  @override
  Future<Response<dynamic>> getWishList(String token) {
    final $url = '/benaity/public/api/wishlist';
    final $params = <String, dynamic>{'token': token};
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

}
