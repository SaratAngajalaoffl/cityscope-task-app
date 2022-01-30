import 'dart:io';

import 'package:dio/dio.dart' as http;

http.Dio dio = http.Dio();

Future<Map<String, dynamic>> getRequest({
  required String url,
  Map<String, String>? queryParams,
  String? accessToken,
}) async {
  Map<String, String> headers = <String, String>{};

  if (accessToken != null) {
    headers['authorization'] = accessToken;
  }

  http.Response response = await dio.get(
    url,
    queryParameters: queryParams,
    options: http.Options(headers: headers),
  );

  Map<String, dynamic> result = <String, dynamic>{
    "status": response.statusCode == 200 ? true : false,
    "data": response.data,
  };

  return result;
}

Future<Map<String, dynamic>> postRequest({
  required Map<String, dynamic> data,
  required String url,
  Map<String, String>? queryParams,
  String contentType = 'application/json',
  String? accessToken,
}) async {
  queryParams ??= <String, String>{};
  Map<String, String> headers = <String, String>{};

  if (accessToken != null) {
    headers['authorization'] = accessToken;
  }

  headers['Content-Type'] = contentType;

  http.Response response = await dio.post(
    url,
    queryParameters: queryParams,
    options: http.Options(
      headers: headers,
    ),
    data: data,
  );

  Map<String, dynamic> result = <String, dynamic>{
    "status": response.statusCode == 200 ? true : false,
    "data": response.data,
  };

  return result;
}

Future<Map<String, dynamic>> postRequestwithFormData({
  required Map<String, dynamic> data,
  List<File> files = const <File>[],
  required String url,
  String? accessToken,
  String contentType = 'multipart/form-data',
}) async {
  Map<String, String> headers = <String, String>{};

  if (accessToken != null) {
    headers['authorization'] = accessToken;
  }

  List<http.MultipartFile> multipartFiles = <http.MultipartFile>[];

  for (File file in files) {
    multipartFiles.add(
      http.MultipartFile.fromBytes(
        file.readAsBytesSync(),
        filename: 'images',
      ),
    );
  }

  var formData = http.FormData.fromMap({
    ...data,
    'images': multipartFiles,
  });

  headers['Content-Type'] = contentType;

  http.Response response = await dio.post(url,
      options: http.Options(headers: headers), data: formData);

  Map<String, dynamic> result = <String, dynamic>{
    "status": response.statusCode == 200 ? true : false,
    "data": response.data,
  };

  return result;
}
