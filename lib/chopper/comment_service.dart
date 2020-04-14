import 'package:chopper/chopper.dart';

part 'comment_service.chopper.dart';

@ChopperApi(baseUrl: '/benaity/public/api/comment')
abstract class CommentService extends ChopperService {
  @Post(path: '/add')
  Future<Response> addComment(@Body() Map<String, dynamic> body);

  static CommentService create() {
    var client = ChopperClient(
      baseUrl: 'https://pomac.info',
      converter: JsonConverter(),
      services: [
        _$CommentService(),
      ],
    );

    return _$CommentService(client);
  }
}
