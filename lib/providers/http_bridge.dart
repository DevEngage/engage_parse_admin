import 'package:admin/project.dart';
import 'package:dio/dio.dart';

class HttpBridge {
  String url = 'https://${Project.parseAppUrl}/parse/classes/';
  Dio dio = Dio();

  HttpBridge(String className) {
    url += className;
  }

  Future<Map<String, String>> getHeader(
      {auth = true, json = true, pdf = false}) async {
    if (pdf) json = false;
    Map<String, String> header = {};
    header['X-Parse-Application-Id'] = '${Project.parseAppId}';
    header['X-Parse-REST-API-Key'] = '${Project.parseClientKey}';
    if (json) {
      header['Content-type'] = 'application/json';
    } else if (pdf) {
      header['Content-type'] = 'application/pdf';
    }
    return header;
  }
}
