import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

class Globals {

  static String token = '1583861467mUAX0TtHPz1583861467';
  static int chattingTimestamp = 4294967296;

  static final String serverToken = 'AAAAzjukw_w:APA91bHFsGpdzB9qNKXUaxrKgEzFxf'
      'P93dsP59fSs4NneSwmcfmpiySd8M6N-2Lr0ZpJWjClt8hU-aoWXh7dL7wiWSqdePmPTrcEz'
      'EDQaG9QIgH8RHgVvoAx5PkDiHor3BSHONBqpZNQ';
  static final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  Future<Map<String, dynamic>> sendAndRetrieveMessage() async {
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'this is a body',
            'title': 'this is a title'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
//          'to': await firebaseMessaging.getToken(),
          'to': '/topics/benayty',
        },
      ),
    );

    final Completer<Map<String, dynamic>> completer =
    Completer<Map<String, dynamic>>();

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        completer.complete(message);
      },
    );

    return completer.future;
  }

  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

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
