import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';

class UserAvatarWidget extends StatelessWidget {
  const UserAvatarWidget({
    super.key,
    required this.userImageUrl,
    this.isNetworkImage = false,
    this.minRadius,
    this.maxRadius,
    this.showBorder = true,
  });
  final String userImageUrl;
  final bool isNetworkImage;
  final double? minRadius;
  final double? maxRadius;
  final bool showBorder;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.sm),
      decoration: ShapeDecoration(
        shape: CircleBorder(
          side: showBorder
              ? BorderSide(
                  width: 2,
                  color: AppColors.primaryTextColor,
                )
              : BorderSide.none,
        ),
      ),
      child: CircleAvatar(
        minRadius: minRadius ?? 12,
        maxRadius: maxRadius ?? 15,
        backgroundColor: AppColors.bodyTextColor,
        backgroundImage: isNetworkImage
            ? CachedNetworkImageProvider(userImageUrl)
            : AssetImage(userImageUrl),
      ),
    );
  }
}
