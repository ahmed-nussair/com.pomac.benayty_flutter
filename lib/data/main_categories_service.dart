import 'package:chopper/chopper.dart';

part 'main_categories_service.chopper.dart';

@ChopperApi(baseUrl: '/benaity/public/api/main')
abstract class MainCategoriesService extends ChopperService {

  @Get()
  Future<Response> getMainCategories();

  static MainCategoriesService create(){
    var client = ChopperClient(
      baseUrl: 'https://pomac.info',
      converter: JsonConverter(),
      services: [
        _$MainCategoriesService(),
      ]
    );
    return _$MainCategoriesService(client);
  }
}