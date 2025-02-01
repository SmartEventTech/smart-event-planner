import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_images.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/core/constants/app_text_style.dart';

class EventCard extends StatelessWidget {
  const EventCard(
      {super.key, this.editCard = false, this.onEditTap, this.seeMoreTap});
  // Model of Event
  final bool editCard;
  final Function()? onEditTap;
  final Function()? seeMoreTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.defaultPadding,
        vertical: AppSizes.verticalscreenPadding,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.eventCardRadius),
        image: DecorationImage(
          image: AssetImage(AppImages.event2),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Event Name',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.textStyle17Medium(context).copyWith(
                  color: Colors.white,
                ),
              ),
              Flexible(
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Iconsax.star, color: AppColors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.sm),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut et massa mi. Aliquam in hendrerit urna.',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.textStyle13Light(context),
          ),
          const SizedBox(height: AppSizes.lg),
          OutlinedButton(
            onPressed: editCard ? onEditTap : seeMoreTap,
            style: OutlinedButton.styleFrom(
              padding: editCard ? EdgeInsets.symmetric(horizontal: 46) : null,
            ),
            child: Text(editCard ? 'Edit' : 'See More'),
          ),
        ],
      ),
    );
  }
}
