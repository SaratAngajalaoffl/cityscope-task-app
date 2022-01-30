import 'package:cityscope/models/blog_model.dart';
import 'package:flutter/material.dart';
import 'package:dart_date/dart_date.dart';

class CommentScreen extends StatefulWidget {
  final BlogModel blog;
  final Function handleAddComment;

  const CommentScreen({
    Key? key,
    required this.blog,
    required this.handleAddComment,
  }) : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  String _activeComment = "";

  @override
  Widget build(BuildContext context) {
    List<Widget> _generateCommentsWidget() {
      List<Widget> result = [
        const SizedBox(height: 20),
      ];

      for (dynamic comment in widget.blog.comments) {
        result.add(
          Card(
            elevation: 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(comment["comment"]),
                      const SizedBox(height: 5),
                      Text(
                          DateTime.parse(comment["updatedAt"]).toHumanString()),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
        result.add(const Divider(height: 2));
      }

      return result;
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Comment"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        label: Text('Add Comment...'),
                      ),
                      onChanged: (text) {
                        setState(() {
                          _activeComment = text;
                        });
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      widget.handleAddComment(_activeComment);
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
              Expanded(
                child: ListView(
                  children: _generateCommentsWidget(),
                ),
              )
            ],
          ),
        ));
  }
}
