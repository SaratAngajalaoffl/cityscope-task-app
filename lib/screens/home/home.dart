import 'package:cityscope/models/blog_model.dart';
import 'package:cityscope/screens/home/blog_screen.dart';
import 'package:cityscope/services/auth/auth_service.dart';
import 'package:cityscope/services/core/blog_services.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final void Function() getAccessToken;

  const HomeScreen({
    Key? key,
    required this.getAccessToken,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<BlogModel> blogs = <BlogModel>[];

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    var data = await getDashboardData();

    setState(() {
      blogs = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _getBlogListItem(BlogModel item) {
      return Card(
        elevation: 10.0,
        child: MaterialButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlogScreen(blogId: item.id),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(item.title),
                Text(DateTime.parse(item.createdAt).toHumanString()),
                Text("${item.likes.length.toString()} liked this"),
              ],
            ),
          ),
        ),
      );
    }

    ;

    return Scaffold(
      appBar: AppBar(
        title: const Text("CityScope"),
        actions: [
          IconButton(
            onPressed: () async {
              await logoutUser();
              widget.getAccessToken();
            },
            icon: const Icon(
              EvaIcons.logOut,
            ),
          ),
        ],
      ),
      body: ListView(
        children: blogs.map((e) => _getBlogListItem(e)).toList(),
      ),
    );
  }
}
