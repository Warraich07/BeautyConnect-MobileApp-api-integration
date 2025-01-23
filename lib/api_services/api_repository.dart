import 'package:beauty_connect/api_services/base_url.dart';
import 'package:dio/dio.dart';
import '../models/user_model.dart';

class ApiRepository {
  Dio dio = Dio();
  Future<List<UserModel>> getUsersData() async {
    try {
      Response response = await dio.post(ApiUrl.baseUrl + '/register-user');

      if (response.statusCode == 200) {
        final List result = response.data['data'];
        return result.map((e) => UserModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to register user ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('error $e');
    }
  }

  Future<String> getOtp(String phoneNumber) async {
    var data = FormData.fromMap({'phone': phoneNumber});
    Response response = await dio.request(
      ApiUrl.baseUrl + "/send-otp",
      options: Options(method: 'POST',),
      data: data,
    );
    if (response.statusCode == 200) {
      print(response.data['data']['otp'].toString());
      return response.data['data']['otp'].toString();
    }
    else {
      print(response.statusMessage);
    }
    return response.data['data']['otp'].toString();
  }
}
