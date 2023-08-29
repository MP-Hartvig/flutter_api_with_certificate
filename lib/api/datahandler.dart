import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_api_with_certificate/login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DataHandler {
  final baseTokenUrl = 'https://10.0.2.2:27016/api/Jwt';
  final baseHelloWorldUrl = 'https://10.0.2.2:27016/api/HelloWorld';
  HttpClient httpClient = HttpClient();

  Future<String> getHelloWorld(String token) async {
    var headers = {"Authorization": "Bearer $token"};
    httpClient = await setHttpClient();
    HttpClientRequest request =
        await httpClient.getUrl(Uri.parse(baseHelloWorldUrl))
          ..headers.contentType =
              ContentType('application', 'json', charset: 'utf-8')
          ..headers.add(headers.keys.first, headers.values.first);

    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();

    return responseBody;
  }

  Future<String> postLogin(Login login) async {
    httpClient = await setHttpClient();
    var request = await httpClient.postUrl(Uri.parse(baseTokenUrl))
      ..headers.add('Content-Type', 'application/json')
      ..add(utf8.encode(json.encode(login.toMap())));
    var response = await request.close();

    if (response.statusCode != 200) {
      throw Exception(
          '[ERROR] Failed to post - response code: ${response.statusCode}');
    }

    var responseBody = await response.transform(utf8.decoder).join();

    String token = jsonDecode(responseBody)["token"];

    var storage = const FlutterSecureStorage();
    storage.write(key: "token", value: token);

    return token;
  }

  Future<HttpClient> setHttpClient() async {
    ByteData data = await rootBundle.load('assets/localhost+3.p12');
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    SecurityContext context = SecurityContext();
    context.setTrustedCertificatesBytes(bytes, password: 'Mikkel123');
    return HttpClient(context: context);
      // ..badCertificateCallback =
      //     (X509Certificate cert, String host, int port) => true;
  }
}
