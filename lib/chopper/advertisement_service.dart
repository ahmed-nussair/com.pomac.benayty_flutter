import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;

part 'advertisement_service.chopper.dart';

@ChopperApi(baseUrl: '/benaity/public/api/advertisement')
abstract class AdvertisementService extends ChopperService {
  @Get()
  Future<Response> filterAdvertisements(@Query('main_id') int mainId,
      @Query('secondary_id') int secondaryId,
      @Query('area_id') int areaId,
      @Query('city_id') int cityId,);

  @Get(path: '/show')
  Future<Response> showAdvertisement(
      @Query('advertisement_id') int advertisementId);

//  @Post(path: '/add')
//  @multipart
//  Future<Response> addAdvertisement({
//    @Part('token') String token,
//    @Part('main_id') int mainItemId,
//    @Part('secondary_id') int secondaryItemId,
//    @Part('area_id') int areaId,
//    @Part('city_id') int cityId,
//    @Part('title') String title,
//    @Part('phone') String phone,
//    @Part('description') String description,
//    @PartFile('image') File image,
//  });

  /// Calls the ideas API to post new ideas item.
  Future<Response> addIdeas({String token,
    int mainItemId,
    int secondaryItemId,
    int areaId,
    int cityId,
    String title,
    String phone,
    String description,
    File image,
  }) async {
    try {
      // string to uri
      var uri = Uri.parse(
          'https://pomac.info/benaity/public/api/advertisement/add');

      // create multipart request
      var request = new http.MultipartRequest("POST", uri);

      // open a bytestream
      var stream = new http.ByteStream(
          DelegatingStream.typed(image.openRead()));
      // get file length
      var length = await image.length();

      // multipart that takes file
      var multipartFile = new http.MultipartFile('image', stream, length,
          filename: basename(image.path));
      // add file to multipart
      request.files.add(multipartFile);
      request.fields.addAll({
        'token': token,
        'area_id': '$areaId',
        'city_id': '$cityId',
        'main_id': '$mainItemId',
        'secondary_id': '$secondaryItemId',
        'title': title,
        'phone': '$phone',
        'description': description,
      });

      // send
      var response = await request.send();
//    print(response.statusCode);

      String reply = await response.stream.transform(utf8.decoder).join();

      return json.decode(reply);
    } catch (e) {
//    print(e.toString());
      return null;
    }
  }


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
