import 'package:chopper/chopper.dart';

part 'contact_service.chopper.dart';

@ChopperApi(baseUrl: '/benaity/public/api/contact_ud')
abstract class ContactService extends ChopperService {
  @Post()
  Future<Response> contactUs(@Body() Map<String, dynamic> data);

  static ContactService create() {
    var client = ChopperClient(
      baseUrl: 'https://pomac.info',
      converter: JsonConverter(),
      services: [
        _$ContactService(),
      ],
    );
    return _$ContactService(client);
  }
}
