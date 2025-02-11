import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_images.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/core/constants/app_text_style.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    this.editCard = false,
    this.onEditTap,
    this.seeMoreTap,
  });

  final bool editCard;
  final Function()? onEditTap;
  final Function()? seeMoreTap;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 352 / 151,
      child: Stack(
        children: [
          /// Background Image with Gradient Overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.eventCardRadius),
              image: DecorationImage(
                image: AssetImage(AppImages.event2),
                fit: BoxFit.cover,
              ),
            ),
            foregroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.eventCardRadius),
              gradient: AppColors.eventCardGradientColor,
            ),
          ),

          /// Event Details Positioned at Bottom
          Positioned(
            left: AppSizes.defaultPadding,
            right: AppSizes.defaultPadding,
            bottom: AppSizes.defaultPadding / 2,
            top: AppSizes.defaultPadding + 2,
            child: Event(
              editCard: editCard,
              onEditTap: onEditTap,
              seeMoreTap: seeMoreTap,
            ),
          ),
        ],
      ),
    );
  }
}

class Event extends StatelessWidget {
  const Event({
    super.key,
    required this.editCard,
    required this.onEditTap,
    required this.seeMoreTap,
  });

  final bool editCard;
  final Function()? onEditTap;
  final Function()? seeMoreTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Event Name',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.textStyle17Medium(context).copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Flexible(
                fit: FlexFit.loose,
                child: FittedBox(
                  child: InkWell(
                    onTap: () {},
                    child: Icon(Iconsax.star, color: AppColors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.md),
        Text(
          'Lorem ipsum dolor sit amet,consectetur adipiscing elit. Ut et massa mi. Aliquam in hendrerit urna.',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.textStyle14Light(context),
        ),
        const SizedBox(height: AppSizes.md),
        Flexible(
          fit: FlexFit.loose,
          child: Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton(
              onPressed: editCard ? onEditTap : seeMoreTap,
              style: OutlinedButton.styleFrom(
                padding: editCard ? EdgeInsets.symmetric(horizontal: 40) : null,
              ),
              child: FittedBox(child: Text(editCard ? 'Edit' : 'See More')),
            ),
          ),
        )
      ],
    );
  }
}
