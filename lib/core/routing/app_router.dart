import 'package:posts_app/core/routing/routes.dart';
import 'package:posts_app/features/posts/data/models/post_model.dart';
import 'package:posts_app/features/posts/presentation/screens/post_details_screen.dart';
import 'package:posts_app/features/posts/presentation/screens/posts_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.postsScreen:
        return MaterialPageRoute(builder: (_) => const PostsScreen());
      case Routes.postDetailsScreen:
        return MaterialPageRoute(
          builder: (_) =>
              PostDetailsScreen(post: settings.arguments as PostModel),
        );
      default:
        return null;
    }
  }
}
