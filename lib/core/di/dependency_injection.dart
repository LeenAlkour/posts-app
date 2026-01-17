import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:posts_app/core/network/dio_factory.dart';
import 'package:posts_app/features/posts/data/repositories/posts_repository.dart';
import 'package:posts_app/features/posts/data/services/posts_api.dart';

import '../../features/posts/logic/posts_provider.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Dio instance
  getIt.registerLazySingleton<Dio>(() => DioFactory.createDio());

  // API
  getIt.registerLazySingleton<PostsApi>(() => PostsApi(getIt<Dio>()));

  // Repository
  getIt.registerLazySingleton<PostsRepository>(
        () => PostsRepository(getIt<PostsApi>()),
  );

  // Provider
  getIt.registerLazySingleton<PostsProvider>(
        () => PostsProvider(getIt<PostsRepository>()),
  );
}
