
import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';

class MessegesPopupElement extends StatelessWidget {
  const MessegesPopupElement({
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
        border: Border.all(color: Colors.purple, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          return ListTile(

            leading: Icon(Iconsax.message),
            title: Text(
              "Message",
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