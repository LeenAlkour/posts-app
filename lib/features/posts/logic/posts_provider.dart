// posts_provider.dart
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import 'package:ebtech_task_flutter/core/error_handler/failure.dart';
import 'package:ebtech_task_flutter/features/posts/data/models/post_model.dart';
import 'package:ebtech_task_flutter/features/posts/data/repositories/posts_repository.dart';
import 'package:ebtech_task_flutter/core/error_handler/api_error_handler.dart';

class PostsProvider extends ChangeNotifier {
  final PostsRepository repository;

  bool isLoading = false;
  List<PostModel> posts = [];
  Failure? failure;

  PostsProvider(this.repository);

  Future<void> loadPosts() async {
    isLoading = true;
    failure = null;
    notifyListeners();

    final Either<Failure, List<PostModel>> result = await repository.getPosts();

    result.fold((f) => failure = f, (data) => posts = data);

    isLoading = false;
    notifyListeners();
  }

  Future<void> createPost({
    required String author,
    required String title,
    required String content,
  }) async {
    try {
      isLoading = true;
      failure = null;
      notifyListeners();

      final Either<Failure, PostModel> result = await repository.createPost(
        author: author,
        title: title,
        content: content,
      );

      result.fold(
        (f) {
          failure = f;
          isLoading = false;
          notifyListeners();
        },
        (newPost) {
          posts.insert(0, newPost);
          isLoading = false;
          notifyListeners();
        },
      );
    } catch (e) {
      failure = ApiErrorHandler.handle(e);
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addComment({
    required String postId,
    required String author,
    required String email,
    required String content,
  }) async {
    try {
      final Either<Failure, PostModel> result = await repository.addComment(
        postId: postId,
        author: author,
        email: email,
        content: content,
      );

      result.fold(
        (f) {
          failure = f;
          notifyListeners();
        },
        (updatedPost) {
          final index = posts.indexWhere((p) => p.id == postId);
          posts[index] = updatedPost;
          notifyListeners();
        },
      );
    } catch (e) {
      failure = ApiErrorHandler.handle(e);
      notifyListeners();
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      final Either<Failure, void> result = await repository.deletePost(postId);

      result.fold(
        (f) {
          failure = f;
          notifyListeners();
        },
        (_) {
          posts.removeWhere((p) => p.id == postId);
          notifyListeners();
        },
      );
    } catch (e) {
      failure = ApiErrorHandler.handle(e);
      notifyListeners();
    }
  }
}
