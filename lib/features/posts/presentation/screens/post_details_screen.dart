import 'package:posts_app/core/helpers/spacing.dart';
import 'package:posts_app/core/theming/colors.dart';
import 'package:posts_app/core/theming/styles.dart';
import 'package:posts_app/features/posts/presentation/widgets/add_comment_bottom_sheet.dart';
import 'package:posts_app/features/posts/presentation/widgets/delete_post_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../data/models/post_model.dart';
import '../../logic/posts_provider.dart';
import '../widgets/create_post_bottom_sheet.dart';

class PostDetailsScreen extends StatefulWidget {
  final PostModel post;

  const PostDetailsScreen({super.key, required this.post});

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PostsProvider>(
      builder: (context, provider, child) {
        final updatedPost = provider.posts.firstWhere(
          (p) => p.id == widget.post.id,
          orElse: () => widget.post,
        );

        return Scaffold(
          backgroundColor: ColorsManager.bg_color,
          appBar: AppBar(
            backgroundColor: ColorsManager.bg_color,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: ColorsManager.black),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text('Post Details', style: TextStyles.font16BlackBold),
            centerTitle: false,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 16.0.h,
                    horizontal: 16.0.w,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!, width: 1.w),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 16.0.h,
                      horizontal: 16.0.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundImage: NetworkImage(
                                    updatedPost.image.isNotEmpty
                                        ? updatedPost.image
                                        : 'https://via.placeholder.com/48',
                                  ),
                                ),
                                horizontalSpace(12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      updatedPost.author,
                                      style: TextStyles.font16BlackBold,
                                    ),
                                    Text(
                                      _formatDate(updatedPost.createdAt),
                                      style: TextStyles.font12GrayRegular,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: ColorsManager.gray,
                                    size: 18,
                                  ),
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
                                      builder: (context) =>
                                          CreatePostBottomSheet(
                                            postId: updatedPost.id,
                                            initialTitle: updatedPost.title,
                                            initialContent: updatedPost.content,
                                            initialAuthor: updatedPost.author,
                                          ),
                                    );
                                  },
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 18,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => DeletePostDialog(
                                        postId: updatedPost.id,
                                        postTitle: updatedPost.title,
                                      ),
                                    );
                                  },
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                              ],
                            ),
                          ],
                        ),
                        verticalSpace(12),

                        Text(
                          updatedPost.title,
                          style: TextStyles.font16BlackBold,
                        ),
                        verticalSpace(8),

                        Text(
                          updatedPost.content,
                          style: TextStyles.font16GrayRegular,
                        ),
                        verticalSpace(12),
                        Row(
                          children: [
                            ImageIcon(
                              AssetImage('assets/icons/comment-icon.png'),
                              color: ColorsManager.gray,
                              size: 16.w,
                            ),
                            horizontalSpace(6),
                            Text(
                              '${updatedPost.comments.length} comment${updatedPost.comments.length != 1 ? 's' : ''}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Comments', style: TextStyles.font16BlackBold),
                          ElevatedButton(
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
                                builder: (context) => AddCommentBottomSheet(
                                  postId: updatedPost.id,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorsManager.orange,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 8.h,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                            ),
                            child: Text(
                              'Add Comment',
                              style: TextStyles.font12WhiteBold,
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(16),
                      if (updatedPost.comments.isEmpty)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Text(
                              'No comments yet',
                              style: TextStyles.font16GrayRegular,
                            ),
                          ),
                        )
                      else
                        Column(
                          children: updatedPost.comments.map((comment) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 16.0.h),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey[200]!,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.0.w,
                                  vertical: 12.0.h,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 16,
                                              backgroundColor: const Color(
                                                0xFFFF9500,
                                              ),
                                              child: Text(
                                                comment.author[0].toUpperCase(),
                                                style:
                                                    TextStyles.font12WhiteBold,
                                              ),
                                            ),
                                            horizontalSpace(8),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  comment.author,
                                                  style: TextStyles
                                                      .font12BlackBold,
                                                ),
                                                Text(
                                                  _formatTimeAgo(
                                                    comment.createdAt,
                                                  ),
                                                  style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.more_vert,
                                            color: Colors.grey,
                                            size: 16,
                                          ),
                                          onPressed: () {},
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                        ),
                                      ],
                                    ),
                                    verticalSpace(8),
                                    Text(
                                      comment.content,
                                      style: TextStyles.font12GrayRegular,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime dateTime) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year} at ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.hour >= 12 ? 'PM' : 'AM'}';
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'just now';
    }
  }
}
