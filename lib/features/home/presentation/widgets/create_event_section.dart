import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_images.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/core/constants/app_text_style.dart';

class CreateEventSection extends StatefulWidget {
  const CreateEventSection({super.key});

  @override
  CreateEventSectionState createState() => CreateEventSectionState();
}

class CreateEventSectionState extends State<CreateEventSection> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 352 / 171,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: AppSizes.eventTopPadding,
              bottom: AppSizes.dotIndicatorPadding,
            ),
            decoration: ShapeDecoration(
              color: Colors.grey,
              image: DecorationImage(
                opacity: 0.9,
                colorFilter: ColorFilter.mode(
                    AppColors.eventOpacity, BlendMode.exclusion),
                image: AssetImage(
                  eventData[_currentIndex]['imageUrl'],
                ),
                fit: BoxFit.cover,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppSizes.eventCardRadius),
                ),
              ),
            ),
            child: Column(
              children: [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: AppSizes.eventTopPadding,
                      left: AppSizes.eventTopPadding,
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: 80,
                            child: PageView.builder(
                              physics: BouncingScrollPhysics(),
                              controller: _pageController,
                              onPageChanged: _onPageChanged,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              itemCount: eventData.length,
                              itemBuilder: (context, index) {
                                return Text(
                                  eventData[index]['title'],
                                  style: AppTextStyle.textStyle20ExtraBold
                                      .copyWith(color: Colors.white),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                );
                              },
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.secondaryColor,
                              side: BorderSide(color: Colors.transparent),
                            ),
                            onPressed: () {},
                            child: Text('Create now'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      eventData.length,
                      (index) => Container(
                        width: 8,
                        height: 8,
                        decoration: ShapeDecoration(
                          color: _currentIndex == index
                              ? Colors.white
                              : Colors.grey, // Active dot color change
                          shape: CircleBorder(),
                        ),
                        margin: EdgeInsets.all(4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<Map<String, dynamic>> eventData = [
  {
    'title': 'Create your own event and invite your friends.',
    'imageUrl': AppImages.event1, // Change image paths accordingly
  },
  {
    'title': 'Provided by your location you will get events recommendation.',
    'imageUrl': AppImages.event2,
  },
  {
    'title': 'Select your favorite hobbies and majors to attend events.',
    'imageUrl': AppImages.event1,
  }
];
