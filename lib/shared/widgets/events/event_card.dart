import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_images.dart';
import 'package:smart_event_planner/core/models/event/event_model.dart';
import 'package:smart_event_planner/core/constants/app_text_style.dart';
// ignore_for_file: deprecated_member_use


class EventCard extends StatelessWidget {
  final EventModel event;
  final bool editCard;
  final VoidCallback? onEditTap;
  final VoidCallback? seeMoreTap;
  final double cardAspectRatio;
  final double imageHeight;

  const EventCard({
    super.key,
    required this.event,
    this.editCard = false,
    this.onEditTap,
    this.seeMoreTap,
    this.cardAspectRatio = 352 / 151,
    this.imageHeight = 151,
  });

  String _getImageUrl() {
    if (event.imageUrl != null && event.imageUrl!.isNotEmpty) {
      if (event.imageUrl!.startsWith('http')) {
        return event.imageUrl!;
      }
      return 'https://eventplanner-production-ce6e.up.railway.app${event.imageUrl!.startsWith('/') ? '' : '/'}${event.imageUrl!}';
    }
    return AppImages.event2;
  }

  Widget _buildImageWidget() {
    final imageUrl = _getImageUrl();
    final isNetworkImage = imageUrl.startsWith('http');

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSizes.eventCardRadius),
      child: isNetworkImage
          ? CachedNetworkImage(
              imageUrl: imageUrl,
              width: double.infinity,
              height: imageHeight,
              fit: BoxFit.cover,
              placeholder: (context, url) => _buildImagePlaceholder(),
              errorWidget: (context, url, error) => _buildDefaultImage(),
            )
          : Image.asset(
              imageUrl,
              width: double.infinity,
              height: imageHeight,
              fit: BoxFit.cover,
            ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      width: double.infinity,
      height: imageHeight,
      color: Colors.grey[200],
      child: const Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultImage() {
    return Image.asset(
      AppImages.event2,
      width: double.infinity,
      height: imageHeight,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: seeMoreTap,
      child: SizedBox(
        width: double.infinity,
        height: imageHeight,
        child: Stack(
          children: [
            Stack(
              children: [
                _buildImageWidget(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizes.eventCardRadius),
                    gradient: AppColors.eventCardGradientColor,
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(AppSizes.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          event.title ?? 'Event Name',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.textStyle17Medium(context)
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      const Icon(Iconsax.star, color: AppColors.white),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.description ?? 'No description available',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.textStyle14Light(context),
                      ),
                      const SizedBox(height: AppSizes.md),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: OutlinedButton(
                          onPressed: editCard ? onEditTap : seeMoreTap,
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.lg,
                              vertical: AppSizes.sm,
                            ),
                            side: const BorderSide(color: AppColors.white),
                          ),
                          child: Text(
                            editCard ? 'Edit' : 'See More',
                            style: AppTextStyle.textStyle14Regular(context)
                                .copyWith(color: AppColors.primaryTextColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            if (editCard && onEditTap != null)
              Positioned(
                top: AppSizes.defaultPadding,
                right: AppSizes.defaultPadding,
                child: GestureDetector(
                  onTap: onEditTap,
                  child: Container(
                    padding: const EdgeInsets.all(AppSizes.sm),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.8),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Iconsax.edit,
                      size: 16,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}