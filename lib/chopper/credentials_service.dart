import 'package:chopper/chopper.dart';

part 'credentials_service.chopper.dart';

@ChopperApi(baseUrl: '/benaity/public/api')
abstract class CredentialsService extends ChopperService{

  @Post(path: '/login')
  Future<Response> login(@Body() Map<String, dynamic> data);

  @Post(path: '/users/register')
  Future<Response> register(@Body() Map<String, dynamic> data);

  @Post(path: '/users/forget_password')
  Future<Response> forgotPassword(@Body() Map<String, dynamic> data);

  @Post(path: '/users/check_reset_code')
  Future<Response> checkResetCode(@Body() Map<String, dynamic> data);

  @Post(path: '/users/reset_password')
  Future<Response> resetPassword(@Body() Map<String, dynamic> data);

  static CredentialsService create(){
    var client = ChopperClient(
        baseUrl: 'https://pomac.info',
        converter: JsonConverter(),
        services: [
          _$CredentialsService(),
        ]
    );
    return _$CredentialsService(client);
  }
}