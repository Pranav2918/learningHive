import 'package:hive_flutter/hive_flutter.dart';
part 'post_model.g.dart';

@HiveType(typeId: 1)
class Posts {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String content;
  @HiveField(2)
  final String image;
  @HiveField(3)
  final int id;

  Posts({required this.title, required this.content, required this.image, required this.id});

  factory Posts.fromJson(Map<String, dynamic> json) => Posts(
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      image: json['image'] ?? '',
      id: json['id'] ?? 0);
}
