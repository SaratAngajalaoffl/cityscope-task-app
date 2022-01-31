import 'package:cityscope/models/blog_model.dart';
import 'package:cityscope/screens/home/blog_screen.dart';
import 'package:cityscope/services/auth/auth_service.dart';
import 'package:cityscope/services/core/blog_services.dart';
import 'package:cityscope/widgets/loading_widget.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';

const List<String> cities = [
  "Adilabad",
  "Anantapur",
  "Chittoor",
  "Kakinada",
  "Guntur",
  "Hyderabad",
  "Karimnagar",
  "Khammam",
  "Krishna",
  "Kurnool",
  "Mahbubnagar",
  "Medak",
  "Nalgonda",
  "Nizamabad",
  "Ongole",
  "Hyderabad",
  "Srikakulam",
  "Nellore",
  "Visakhapatnam",
  "Vizianagaram",
  "Warangal",
  "Eluru",
  "Kadapa",
];

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
  bool isLoading = true;
  List<BlogModel> blogs = <BlogModel>[];
  String? selectedCity;

  Future<void> getData(String city) async {
    setState(() {
      isLoading = true;
    });

    var data = await getDashboardData(city: city);

    setState(() {
      blogs = data;
      selectedCity = city;
      isLoading = false;
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

    return Scaffold(
      appBar: AppBar(
        title: const Text("CityScope"),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                selectedCity = null;
              });
            },
            icon: const Icon(Icons.edit_location),
            label: Text(selectedCity ?? ""),
          ),
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
      body: selectedCity == null
          ? SimpleDialog(
              title: const Text('Select City'),
              children: cities
                  .map((city) => SimpleDialogOption(
                        onPressed: () {
                          getData(city);
                        },
                        child: Text(city),
                      ))
                  .toList())
          : Container(
              child: isLoading
                  ? const LoadingIndicator()
                  : ListView(
                      children: blogs.map((e) => _getBlogListItem(e)).toList(),
                    ),
            ),
    );
  }
}
