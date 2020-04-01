// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_categories_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$MainCategoriesService extends MainCategoriesService {
  _$MainCategoriesService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = MainCategoriesService;

  @override
  Future<Response<dynamic>> getMainCategories() {
    final $url = '/benaity/public/api/main';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getSecondaryCategories(int mainCategoryId) {
    final $url = '/benaity/public/api/secondary';
    final $params = <String, dynamic>{'main_id': mainCategoryId};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }
}
