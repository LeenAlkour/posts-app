import 'package:ebtech_task_flutter/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ebtech_task_flutter/features/posts/logic/posts_provider.dart';
import 'package:ebtech_task_flutter/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ebtech_task_flutter/core/helpers/spacing.dart';

class DeletePostDialog extends StatelessWidget {
  final String postId;
  final String postTitle;

  const DeletePostDialog({
    super.key,
    required this.postId,
    required this.postTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.0.h, horizontal: 16.0.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Delete Post',
              style: TextStyles.font16BlackBold,
              textAlign: TextAlign.center,
            ),
            verticalSpace(16),
            Text(
              'Are you sure you want to delete this post? This will also delete all comments. This action cannot be undone.',
              style: TextStyles.font14BlackRegular,
              textAlign: TextAlign.center,
            ),
            verticalSpace(24),
            // Delete Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<PostsProvider>(
                    context,
                    listen: false,
                  ).deletePost(postId);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Post deleted successfully')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  backgroundColor: ColorsManager.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  elevation: 0,
                ),
                child: Text('Delete', style: TextStyles.font14BlackBold),
              ),
            ),
            verticalSpace(12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  side: BorderSide(color: Colors.grey, width: 1.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                ),
                child: Text('Cancel', style: TextStyles.font14BlackRegular),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
