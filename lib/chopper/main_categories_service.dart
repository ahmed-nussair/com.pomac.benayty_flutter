import 'package:chopper/chopper.dart';

part 'main_categories_service.chopper.dart';

@ChopperApi(baseUrl: '/benaity/public/api')
abstract class MainCategoriesService extends ChopperService {

  @Get(path: '/main')
  Future<Response> getMainCategories();

  @Get(path: '/secondary')
  Future<Response> getSecondaryCategories(@Query('main_id') int mainCategoryId);

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