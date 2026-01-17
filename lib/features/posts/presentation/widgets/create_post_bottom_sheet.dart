import 'package:posts_app/core/helpers/spacing.dart';
import 'package:posts_app/core/theming/colors.dart';
import 'package:posts_app/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:posts_app/features/posts/logic/posts_provider.dart';

class CreatePostBottomSheet extends StatefulWidget {
  final String? postId;
  final String? initialTitle;
  final String? initialContent;
  final String? initialAuthor;

  const CreatePostBottomSheet({
    super.key,
    this.postId,
    this.initialTitle,
    this.initialContent,
    this.initialAuthor,
  });

  @override
  State<CreatePostBottomSheet> createState() => _CreatePostBottomSheetState();
}

class _CreatePostBottomSheetState extends State<CreatePostBottomSheet> {
  late TextEditingController _nameController;
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialAuthor ?? '');
    _titleController = TextEditingController(text: widget.initialTitle ?? '');
    _contentController = TextEditingController(
      text: widget.initialContent ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 24.0.w,
                  right: 24.0.w,
                  top: 24.0.h,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                    verticalSpace(20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.postId == null
                                  ? 'Create New Post'
                                  : 'Edit Post',
                              style: TextStyles.font16BlackBold,
                            ),
                            verticalSpace(4),
                            Text(
                              widget.postId == null
                                  ? 'Share your thoughts with the community'
                                  : 'Update your post details',
                              style: TextStyles.font12GrayRegular,
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.close, color: Colors.grey),
                        ),
                      ],
                    ),
                    verticalSpace(24),

                    _buildTextField(
                      label: 'Your Name',
                      controller: _nameController,
                      hint: 'Enter your name',
                    ),
                    verticalSpace(16),

                    _buildTextField(
                      label: 'Title',
                      controller: _titleController,
                      hint: 'Enter post title',
                    ),
                    verticalSpace(16),

                    _buildTextField(
                      label: 'Content',
                      controller: _contentController,
                      hint: 'Write your content here...',
                      maxLines: 4,
                    ),
                    verticalSpace(24),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              side: const BorderSide(color: Colors.grey),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        horizontalSpace(12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_nameController.text.isNotEmpty &&
                                  _titleController.text.isNotEmpty &&
                                  _contentController.text.isNotEmpty) {
                                if (widget.postId == null) {
                                  Provider.of<PostsProvider>(
                                    context,
                                    listen: false,
                                  ).createPost(
                                    author: _nameController.text,
                                    title: _titleController.text,
                                    content: _contentController.text,
                                  );
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Post created successfully',
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Post updated successfully',
                                      ),
                                    ),
                                  );
                                  Navigator.pop(context);
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please fill all fields'),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              backgroundColor: ColorsManager.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: Text(
                              widget.postId == null ? 'Create' : 'Update',
                              style: TextStyles.font16WhiteBold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyles.font16BlackBold),
        verticalSpace(8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: ColorsManager.lightGray,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
          ),
        ),
      ],
    );
  }
}
