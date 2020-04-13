import 'package:chopper/chopper.dart';

part 'wislist_service.chopper.dart';

@ChopperApi(baseUrl: '/benaity/public/api/wishlist')
abstract class WishListService extends ChopperService {
  @Get()
  Future<Response> getWishList(@Query('token') String token);

  @Post(path: '/add')
  Future<Response> addToWishList(@Body() Map<String, dynamic> data);

  @Post(path: '/delete')
  Future<Response> deleteFromWishList(@Body() Map<String, dynamic> data);

  static WishListService create() {
    var client = ChopperClient(
        baseUrl: 'https://pomac.info',
        converter: JsonConverter(),
        services: [
          _$WishListService(),
        ]);
    return _$WishListService(client);
  }
}
