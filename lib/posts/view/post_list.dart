import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_infinte_list/posts/bloc/post_bloc.dart';
import 'package:flutter_bloc_infinte_list/posts/view/view.dart';

class PostList extends StatefulWidget {
  const PostList({super.key});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onScroll() {
    if (_isBottom) context.read<PostBloc>().add(PostFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        switch (state.status) {
          case PostStatus.failure:
            return const Center(
              child: Text('failed to fetch the post'),
            );
          case PostStatus.success:
            if (state.posts.isEmpty) {
              return const Center(
                child: Text('The posts are empty'),
              );
            }
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (BuildContext context, int index) {
                return index >= state.posts.length
                    ? const BottomLoader()
                    : PostListItem(
                        post: state.posts[index],
                      );
              },
              controller: _scrollController,
            );
          case PostStatus.initial:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
