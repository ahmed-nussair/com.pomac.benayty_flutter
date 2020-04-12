import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

class Globals {

  static String token = '1583861467mUAX0TtHPz1583861467';

  static Future<bool> isImageUrlWell(String imageUrl) async {
    var response = await http.get(imageUrl,);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<Map> addAdvertisement({
    String token,
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
      var uri =
      Uri.parse('https://pomac.info/benaity/public/api/advertisements/add');

      // create multipart request
      var request = http.MultipartRequest("POST", uri);

      // open a bytestream
      var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
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
      print(response.statusCode);

      String reply = await response.stream.transform(utf8.decoder).join();

      return json.decode(reply);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
