import 'package:doctorcall/features/news_feature/models/news_response.dart';
import 'package:http/http.dart' as http;
import 'package:doctorcall/coreapp/service/session_management.dart';

class HomeRepository{
  static Future<NewsResponse?> getNewsData() async {
    try {
      var token = await SessionManagement.getToken();
      var client = http.Client();
      var url = Uri.https('presline-api.navel.id', '/api/getnews');
      var res = await client.get(url,
          headers: {"Content-Type": "Application/JSON",
            "Authorization": token});

      var userResponse = newsResponseFromJson(res.body);
      return userResponse;
    } catch (e) {
      print(e.toString());
    }
  }
}