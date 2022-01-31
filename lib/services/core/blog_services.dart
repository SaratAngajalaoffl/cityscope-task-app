import 'package:cityscope/models/blog_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cityscope/helpers/dio_helpers.dart';

const _baseUrl = "http://192.168.1.8:8080";

const _storage = FlutterSecureStorage();

Future<List<BlogModel>> getDashboardData({required String city}) async {
  String? accessToken = await _storage.read(key: 'accessToken');

  if (accessToken == null) {
    throw Error();
  }

  Map<String, dynamic> response = await getRequest(
    url: "$_baseUrl/blogs/get-dashboard-data",
    queryParams: {
      "city": city,
    },
    accessToken: accessToken,
  );

  return response["data"]["data"]
      .map<BlogModel>(
        (blog) => BlogModel(
          body: blog["body"] ?? "",
          category: blog["category"] ?? "",
          city: blog["city"] ?? "",
          isDraft: blog["isDraft"] ?? "",
          likes: blog["likes"].map((item) => item.toString()).toList(),
          owner: blog["owner"] ?? "",
          title: blog["title"] ?? "",
          id: blog["_id"] ?? "",
          createdAt: blog["createdAt"] ?? "",
          comments: blog["comments"] ?? "",
        ),
      )
      .toList();
}

Future<BlogModel> getBlogData(String blogId) async {
  String? accessToken = await _storage.read(key: 'accessToken');

  if (accessToken == null) {
    throw Error();
  }

  Map<String, dynamic> response = await getRequest(
    url: "$_baseUrl/blogs/get-blog",
    queryParams: <String, String>{
      "blogId": blogId,
    },
    accessToken: accessToken,
  );

  Map<String, dynamic> blog = response["data"]["data"];

  return BlogModel(
    body: blog["body"] ?? "",
    category: blog["category"] ?? "",
    city: blog["city"] ?? "",
    isDraft: blog["isDraft"] ?? "",
    likes: blog["likes"].map((item) => item.toString()).toList(),
    owner: blog["owner"] ?? "",
    title: blog["title"] ?? "",
    id: blog["_id"] ?? "",
    createdAt: blog["createdAt"] ?? "",
    comments: blog["comments"] ?? "",
  );
}

Future<BlogModel> likeBlog(String blogId) async {
  String? accessToken = await _storage.read(key: 'accessToken');

  if (accessToken == null) {
    throw Error();
  }

  Map<String, dynamic> response = await getRequest(
    url: "$_baseUrl/blogs/like-blog",
    queryParams: <String, String>{
      "blogId": blogId,
    },
    accessToken: accessToken,
  );

  Map<String, dynamic> blog = response["data"]["data"];

  return BlogModel(
    body: blog["body"] ?? "",
    category: blog["category"] ?? "",
    city: blog["city"] ?? "",
    isDraft: blog["isDraft"] ?? "",
    likes: blog["likes"].map((item) => item.toString()).toList(),
    owner: blog["owner"] ?? "",
    title: blog["title"] ?? "",
    id: blog["_id"] ?? "",
    createdAt: blog["createdAt"] ?? "",
    comments: blog["comments"] ?? "",
  );
}

Future<BlogModel> commentBlog({
  required String blogId,
  required String comment,
}) async {
  String? accessToken = await _storage.read(key: 'accessToken');

  if (accessToken == null) {
    throw Error();
  }

  Map<String, dynamic> response = await postRequest(
    url: "$_baseUrl/blogs/comment-blog",
    data: <String, dynamic>{
      "comment": comment,
    },
    queryParams: <String, String>{
      "blogId": blogId,
    },
    accessToken: accessToken,
  );

  Map<String, dynamic> blog = response["data"]["data"];

  return BlogModel(
    body: blog["body"] ?? "",
    category: blog["category"] ?? "",
    city: blog["city"] ?? "",
    isDraft: blog["isDraft"] ?? "",
    likes: blog["likes"].map((item) => item.toString()).toList(),
    owner: blog["owner"] ?? "",
    title: blog["title"] ?? "",
    id: blog["_id"] ?? "",
    createdAt: blog["createdAt"] ?? "",
    comments: blog["comments"] ?? "",
  );
}
