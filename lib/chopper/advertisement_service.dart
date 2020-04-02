import 'package:chopper/chopper.dart';

part 'advertisement_service.chopper.dart';

@ChopperApi(baseUrl: '/benaity/public/api/advertisement')
abstract class AdvertisementService extends ChopperService{

  @Get()
  Future<Response> filterAdvertisements(
      @Query('main_id') int mainId,
      @Query('secondary_id') int secondaryId,
      @Query('area_id') int areaId,
      @Query('city_id') int cityId,);

  @Get(path: '/show')
  Future<Response> showAdvertisement(@Query('advertisement_id') int advertisementId);

  static AdvertisementService create(){
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