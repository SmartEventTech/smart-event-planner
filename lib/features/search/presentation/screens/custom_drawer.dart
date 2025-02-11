import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:smart_event_planner/core/constants/app_images.dart';
import 'package:smart_event_planner/features/search/presentation/widget/list_of_widgets.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    
  });

  

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Drawer(
      
          width: screenWidth < 600
              ? screenWidth * 0.35
              : screenWidth * 0.35, // Responsive drawer width
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: SvgPicture.asset(AppImages.filterIcon),
                  title: Text(
                    'Filters',
                    style: TextStyle(
                      color: Color(0xff0E377C),
                      fontSize:
                          screenWidth < 600 ? 18 : 20, // Responsive font size
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onTap: () {}, // Add functionality if needed
                ),
                
                // Scrollable List
                Expanded(
                  child: ListView.builder(

                    itemCount: 20,
                    
                    itemBuilder: (context, index) {
                      return ListOfContent(
                        text: 'Content ${index + 1}',
                        screenWidth:
                            screenWidth, // Pass screenWidth for responsiveness
                      );
                    },
                    padding:  EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}

