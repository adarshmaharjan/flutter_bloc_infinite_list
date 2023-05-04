part of 'post_bloc.dart';

enum PostStatus { initial, success, failure }

class PostState extends Equatable {
  const PostState({
    this.hasReachedMax = false,
    this.posts = const <Post>[],
    this.status = PostStatus.initial,
  });

  final bool hasReachedMax;
  final List<Post> posts;
  final PostStatus status;

  @override
  List<Object> get props => [status, posts, hasReachedMax];

  @override
  String toString() {
    return 'PostState{status:$status, hasReachedMax:$hasReachedMax,posts:${posts.length}}';
  }

  PostState copyWith({
    PostStatus? status,
    List<Post>? posts,
    bool? hasReachedMax,
  }) {
    return PostState(
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      posts: posts ?? this.posts,
      status: status ?? this.status,
    );
  }
}
