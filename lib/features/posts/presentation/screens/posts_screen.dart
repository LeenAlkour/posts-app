import 'package:posts_app/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../logic/posts_provider.dart';
import '../widgets/post_card.dart';
import '../widgets/create_post_bottom_sheet.dart';
import 'package:posts_app/core/theming/colors.dart';
import 'package:posts_app/core/theming/styles.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PostsProvider>(context, listen: false).loadPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostsProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: ColorsManager.bg_color,
          floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.r),
            ),
            backgroundColor: ColorsManager.orange,
            child: const Icon(Icons.add, color: ColorsManager.bg_color),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                builder: (context) => const CreatePostBottomSheet(),
              );
            },
          ),
          appBar: AppBar(
            backgroundColor: ColorsManager.bg_color,
            elevation: 0,

            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Posts', style: TextStyles.font16BlackBold),
                Text(
                  '${provider.posts.length} posts',
                  style: const TextStyle(
                    fontSize: 14,
                    color: ColorsManager.gray,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.autorenew, color: ColorsManager.gray),
                onPressed: () {
                  provider.loadPosts();
                },
              ),
            ],
          ),
          body: Builder(
            builder: (context) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (provider.failure != null) {
                return Center(
                  child: Text('Error: ${provider.failure!.message}'),
                );
              }

              if (provider.posts.isEmpty) {
                return const Center(child: Text('No posts available'));
              }

              return ListView.builder(
                itemCount: provider.posts.length,
                itemBuilder: (context, index) {
                  final post = provider.posts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.postDetailsScreen,
                        arguments: post,
                      );
                    },
                    child: PostCard(post: post),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
