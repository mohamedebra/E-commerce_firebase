import 'package:api/constants/string.dart';
import 'package:dio/dio.dart';


class CharactersWebServices {
 static late Dio dio;

  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
    );

    dio = Dio(options);
  }


 static Future<Response> getData(
     {required String url, data }) async {
   return await dio.get(url, onReceiveProgress: data);
 }

 Future<List<dynamic>> getAllCharacters() async {
   try {
     Response response = await dio.get('characters');
     print(response.data.toString());
     return response.data;
   } catch (e) {
     print(e.toString());
     return [];
   }

 }

}