import 'package:get/get.dart';
import 'package:sabzee/app/modules/auth/controllers/auth_controller.dart';

class ApiProvider extends GetConnect {
  String url = 'http://localhost:8000';
  var headers = {
    'accept': "application/json",
  };
  @override
  void onInit() async {
    // using httpClient is resulting in the response becoming an html file :/
    // httpClient.baseUrl = 'http://localhost:8000';
    // httpClient.defaultContentType = "application/json";

    super.onInit();
  }

  // Get user details
  Future<Response> getUserDetails(String token) async {
    print("adding token to header");
    headers['authorizationToken'] = token;

    print("sending get req to fastapi");
    var response = await get(
      url + '/user/',
      headers: headers,
    );

    print("response : " + response.statusCode.toString());
    print(response.body);

    return response;
  }

  // Post request
  Future<Response> createUser(Map data) => post('/users/create', {data});
  // Post request with File

  // GetSocket userMessages() {
  //   return socket('https://yourapi/users/socket');
  // }
}
