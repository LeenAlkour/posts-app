import 'package:ebtech_task_flutter/core/di/dependency_injection.dart';
import 'package:ebtech_task_flutter/core/routing/app_router.dart';
import 'package:ebtech_task_flutter/features/posts/presentation/screens/posts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'features/posts/logic/posts_provider.dart';

void main() {
  setupDependencies();
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => getIt<PostsProvider>(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: PostsScreen(),
            onGenerateRoute: appRouter.generateRoute,
          ),
        );
      },
    );
  }
}
