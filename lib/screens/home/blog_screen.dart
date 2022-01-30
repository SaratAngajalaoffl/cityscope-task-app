import 'package:cityscope/models/blog_model.dart';
import 'package:cityscope/services/core/blog_services.dart';
import 'package:cityscope/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _storage = FlutterSecureStorage();

class BlogScreen extends StatefulWidget {
  final String blogId;

  const BlogScreen({
    Key? key,
    required this.blogId,
  }) : super(key: key);

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  BlogModel? blog;
  bool isLoading = true;
  String userId = "";

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    BlogModel data = await getBlogData(widget.blogId);
    String id = await _storage.read(key: "userId") ?? "";

    print(id);

    setState(() {
      blog = data;
      userId = id;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> handleLikeBlog() async {
      BlogModel data = await likeBlog(widget.blogId);

      setState(() {
        blog = data;
        isLoading = false;
      });
    }

    if (isLoading) {
      return const LoadingIndicator();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Posted on ${DateTime.parse(blog?.createdAt ?? "").toHumanString()}",
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 550, child: Markdown(data: blog?.body ?? "")),
          Row(
            children: [
              IconButton(
                onPressed: handleLikeBlog,
                icon: Icon(
                  Icons.favorite,
                  color:
                      blog!.likes.contains(userId) ? Colors.red : Colors.grey,
                ),
              ),
              Text("${blog?.likes.length} liked this"),
              IconButton(onPressed: () {}, icon: const Icon(Icons.comment)),
              Text("${blog?.comments.length}"),
            ],
          )
        ],
      ),
    );
  }
}
