import 'package:flutter/material.dart';
import 'package:flutter_bloc_infinte_list/posts/view/posts_page.dart';

class App extends MaterialApp {
  const App({super.key}) : super(home: const PostsPage());
}
