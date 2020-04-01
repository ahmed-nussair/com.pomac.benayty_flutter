import 'package:chopper/chopper.dart';

part 'credentials_service.chopper.dart';

@ChopperApi(baseUrl: '/benaity/public/api')
abstract class CredentialsService extends ChopperService{

  @Post(path: '/login')
  Future<Response> login(@Body() Map<String, dynamic> data);

  @Post(path: '/register')
  Future<Response> register(@Body() Map<String, dynamic> data);

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