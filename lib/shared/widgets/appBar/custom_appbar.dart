import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/core/constants/app_images.dart';
import 'package:smart_event_planner/shared/widgets/popup/messeges_popup_elements.dart';
import 'package:smart_event_planner/shared/widgets/popup/notification_popup_elements.dart';
import 'package:smart_event_planner/shared/widgets/appBar/user_avatar_widget.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  OverlayEntry? _overlayEntry;

  void _showMessagePopup(BuildContext context, Offset buttonPosition, Size buttonSize) {
    if (_overlayEntry != null) {
      _removePopup(); // Remove existing popup if any
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _removePopup,
              child: Container(color: Colors.transparent),
            ),
          ),
          Positioned(
            top: buttonPosition.dy + buttonSize.height,
            left: buttonPosition.dx - 230, // Adjust this offset as needed
            child: Material(
              elevation: 4.0,
              
              borderRadius: BorderRadius.circular(10),
              child: MessegesPopupElement(),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }
  void _showNotificationPopup(BuildContext context, Offset buttonPosition, Size buttonSize) {
    if (_overlayEntry != null) {
      _removePopup(); // Remove existing popup if any
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _removePopup,
              child: Container(color: Colors.transparent),
            ),
          ),
          Positioned(
            top: buttonPosition.dy + buttonSize.height,
            left: buttonPosition.dx + 30, // Adjust this offset as needed
            child: Material(
              elevation: 4.0,
              
              borderRadius: BorderRadius.circular(10),
              child: NotificationPopupElement(),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }


  void _removePopup() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.defaultScreenPadding,
      ),
      child: AppBar(
        elevation: 0,
        titleSpacing: 0,
        centerTitle: false,
        title: Image.asset(
          AppImages.appLogo,
          width: 90,
        ),
        automaticallyImplyLeading: false,
        actions: [
          Builder( // Use Builder to get the IconButton's position
            builder: (BuildContext context) {
              return IconButton(
                onPressed: () {
                  // Get button position and size using Builder's context
                  RenderBox buttonRenderBox = context.findRenderObject() as RenderBox;
                  Offset buttonPosition = buttonRenderBox.localToGlobal(Offset.zero);
                  Size buttonSize = buttonRenderBox.size;
                  _showMessagePopup(context, buttonPosition, buttonSize);
                },
                icon: Icon(Iconsax.message),
              );
            },
          ),
          IconButton(
            onPressed: () {
              // Get button position and size using Builder's context
                  RenderBox buttonRenderBox = context.findRenderObject() as RenderBox;
                  Offset buttonPosition = buttonRenderBox.localToGlobal(Offset.zero);
                  Size buttonSize = buttonRenderBox.size;
                  _showNotificationPopup(context, buttonPosition, buttonSize);
            },
            icon: Icon(Iconsax.notification),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: UserAvatarWidget(userImageUrl: AppImages.userAvatar),
          )
        ],
      ),
    );
  }

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}