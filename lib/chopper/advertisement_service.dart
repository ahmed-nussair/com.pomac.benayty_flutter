import 'dart:async';

import 'package:chopper/chopper.dart';

part 'advertisement_service.chopper.dart';

@ChopperApi(baseUrl: '/benaity/public/api')
abstract class AdvertisementService extends ChopperService {
  @Get(path: '/advertisement')
  Future<Response> filterAdvertisements(@Query('main_id') int mainId,
      @Query('secondary_id') int secondaryId,
      @Query('area_id') int areaId,
      @Query('city_id') int cityId,);

  @Get(path: '/advertisement/show')
  Future<Response> showAdvertisement(
      @Query('advertisement_id') int advertisementId);

  @Post(path: '/wishlist/add')
  Future<Response> addToWishList(@Body() Map<String, dynamic> data);

  @Post(path: '/wishlist/delete')
  Future<Response> deleteFromWishList(@Body() Map<String, dynamic> data);

  @Post(path: '/comment/add')
  Future<Response> addComment(@Body() Map<String, dynamic> body);

  static AdvertisementService create() {
    var client = ChopperClient(
      baseUrl: 'https://pomac.info',
      converter: JsonConverter(),
      services: [
        _$AdvertisementService(),
      ],
    );

    return _$AdvertisementService(client);
  }
}
