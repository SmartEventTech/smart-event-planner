
import 'package:flutter/material.dart';

class NotificationPopupElement extends StatelessWidget {
  const NotificationPopupElement({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
            ),
            title: Text(
              "Event name",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            ),
          );
        }),
      ),
    );
  }
}