import 'package:chopper/chopper.dart';

part 'profile_service.chopper.dart';

@ChopperApi(baseUrl: '/benaity/public/api')
abstract class ProfileService extends ChopperService {
  @Get(path: '/myaccount')
  Future<Response> getProfile(@Query('token') String token);

  @Post(path: '/advertisements/delete')
  Future<Response> removeAd(@Body() Map<String, dynamic> data);

  @Get(path: '/myadvertisements')
  Future<Response> getUserAds(@Query('token') String token);

  @Get(path: '/alladvertisement')
  Future<Response> getAllAds(@Query('token') String token);

  @Get(path: '/advertisements/display')
  Future<Response> displayUserAd(
      @Query('advertisement_id') int adId, @Query('token') String token);

  @Post(path: '/account/update-password')
  Future<Response> updatePassword(@Body() Map<String, dynamic> data);

  @Post(path: '/account/update-profile')
  Future<Response> updateProfile(@Body() Map<String, dynamic> data);

  static ProfileService create() {
    var client = ChopperClient(
        baseUrl: 'https://pomac.info',
        converter: JsonConverter(),
        services: [
          _$ProfileService(),
        ]);
    return _$ProfileService(client);
  }
}
