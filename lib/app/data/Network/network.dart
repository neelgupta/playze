import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';
import '../../routes/app_pages.dart';
import 'app_exception.dart';

class NetworkHandler {
  Future<dynamic> post(String url, http.Client client, token,
      {dynamic model, bool showError = true}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer $token"
    };

    dynamic responseJson;
    log(jsonEncode(model));
    log('url: $url');
    try {
      final http.Response response = await client.post(Uri.parse(url),
          headers: headers, body: model != null ? jsonEncode(model) : null);
      responseJson = returnResponse(
        response,
        url,
        "POST",
        model: model,
        showError: showError,
      );
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url, http.Client client, token,
      {dynamic model}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: token
    };
    dynamic responseJson;
    log(jsonEncode(model));
    log('token: $token');
    try {
      final http.Response response = await client.delete(Uri.parse(url),
          headers: headers, body: model != null ? jsonEncode(model) : null);
      responseJson = returnResponse(response, url, "DELETE", model: model);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postMutiPartData(String url, http.Client client, token,
      {Map<String, String>? model,
      required String fileName,
      required String fileType,
      required List<int> file,
      required httpType}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer $token"
    };

    dynamic responseJson;
    log(jsonEncode(model));
    log('token: $token');
    try {
      var mimeType = "";
      if (fileType == "png") {
        mimeType = "image/png";
      }
      if (fileType == "jpg") {
        mimeType = "image/jpg";
      }
      if (fileType == "jpeg") {
        mimeType = "image/jpeg";
      }
      var request = http.MultipartRequest(httpType, Uri.parse(url));
      request.headers.addAll(headers);
      final httpImage = http.MultipartFile.fromBytes('profile_picture', file,
          contentType: MediaType.parse(mimeType), filename: fileName);
      request.files.add(httpImage);
      request.fields.addAll(model!);
      var response = await request.send();

      var responsedata = await http.Response.fromStream(response);
      responseJson = returnResponse(responsedata, url, "POST", model: model);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> put(String url, http.Client client, token,
      {dynamic model}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: token
    };
    dynamic responseJson;
    log(jsonEncode(model));
    log('token: $token');
    try {
      final http.Response response = await client.put(Uri.parse(url),
          headers: headers, body: model != null ? jsonEncode(model) : null);
      responseJson = returnResponse(response, url, "PUT", model: model);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<bool> putBinary(String url, http.Client client, data) async {
    // Map<String, String> headers = {
    //   'Content-Type': 'application/json; charset=UTF-8',
    // };
    log(data);
    final http.Response response;
    try {
      response = await client.put(Uri.parse(url), body: data);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> get(String url, http.Client client, token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    dynamic responseJson;
    log(url);
    try {
      http.Response response =
          await client.get(Uri.parse(url), headers: headers);
      log(response.body);
      if (response.statusCode == 502) {
        response = await check502(url, client, response);
        responseJson = returnResponse(response, url, "GET");
      } else {
        responseJson = returnResponse(response, url, "GET");
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      rethrow;
    } finally {}
    return responseJson;
  }

  Future<http.Response> check502(
      String url, http.Client client, http.Response res) async {
    logger(method: 'GET', response: res, url: url, model: '');
    log('502 error : ${res.statusCode}');
    log('502 error : $url');
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      // HttpHeaders.authorizationHeader: token
    };
    http.Response response = await client.get(Uri.parse(url), headers: headers);
    log('502 error : 1 ${response.statusCode}');
    if (response.statusCode == 502) {
      http.Response response1 =
          await client.get(Uri.parse(url), headers: headers);
      log('502 error : 2 ${response1.statusCode}');
      return response1;
    } else {
      return response;
    }
  }

  Future<dynamic> getwithoutToken(
    String url,
    http.Client client,
  ) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    dynamic responseJson;
    try {
      final http.Response response =
          await client.get(Uri.parse(url), headers: headers);
      responseJson = returnResponse(response, url, "GET");
    } on Exception {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postwithoutToken(String url, http.Client client,
      {dynamic model}) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    dynamic responseJson;
    try {
      final http.Response response = await client.post(Uri.parse(url),
          headers: headers, body: jsonEncode(model));
      responseJson =
          returnResponse(response, url, "POST", model: model, toLogin: false);
    } on Exception {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postwithCustomToken(
      String url, http.Client client, String btoken,
      {dynamic model}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: btoken
    };
    dynamic responseJson;
    try {
      final http.Response response = await client.post(Uri.parse(url),
          headers: headers, body: jsonEncode(model));
      responseJson = returnResponse(
        response,
        url,
        "POST",
        model: model,
      );
    } on Exception {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response, url, method,
      {bool toLogin = true, model, bool showError = true}) async {
    log(response.body);
    log("response.statusCode : ${response.statusCode}");
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = response.body;
        return responseJson;
      case 201:
        dynamic responseJson = response.body;
        return responseJson;

      // throw FetchDataException(
      //     'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  futureDelayed() {
    Future.delayed(const Duration(seconds: 3), () {
      // LoginSession.shared.logOutExpire();
      Get.offAllNamed(Routes.SIGNIN);
    });
  }

  Future<void> logger(
      {required String url,
      model,
      required http.Response response,
      required String method}) async {
    // Map<String, String> headers = {'Content-Type': 'application/json'};

    // var body = {
    //   "statusCode": response.statusCode,
    //   "method": method,
    //   "url": url,
    //   "payload": model != null ? jsonEncode(model) : '',
    //   "error": response.body,
    // };
  }
}
