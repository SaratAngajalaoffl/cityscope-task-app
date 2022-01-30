class BlogModel {
  final String id;
  final String title;
  final String body;
  final String owner;
  final List<dynamic> likes;
  final String city;
  final String category;
  final bool isDraft;
  final String createdAt;
  final List<dynamic> comments;

  const BlogModel({
    required this.title,
    required this.id,
    required this.body,
    required this.owner,
    required this.likes,
    required this.city,
    required this.category,
    required this.isDraft,
    required this.createdAt,
    required this.comments,
  });
}
