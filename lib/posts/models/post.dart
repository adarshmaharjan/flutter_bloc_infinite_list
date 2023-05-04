import 'package:equatable/equatable.dart';

class Post extends Equatable {
  const Post({required this.id, required this.title, required this.body});

  final String body;
  final int id;
  final String title;

  @override
  List<Object?> get props => [id, title, body];
}
