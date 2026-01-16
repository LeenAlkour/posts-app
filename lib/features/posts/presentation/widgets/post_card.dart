import 'package:ebtech_task_flutter/features/posts/data/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1.w),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(post.image),
                  ),
                  horizontalSpace(8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post.author, style: TextStyles.font16BlackBold),
                        Text(
                          timeago.format(post.createdAt),
                          style: TextStyles.font12GrayRegular,
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.more_vert),
                ],
              ),
              verticalSpace(10),

              Text(post.title, style: TextStyles.font16BlackBold),

              verticalSpace(6),

              Text(
                post.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.font14BlackRegular,
              ),

              verticalSpace(10),

              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 3.w),
                    child: ImageIcon(
                      AssetImage('assets/icons/comment-icon.png'),
                      color: ColorsManager.gray,
                      size: 16.w,
                    ),
                  ),

                  Text(
                    '${post.commentsCount}',
                    style: TextStyles.font12GrayRegular,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
