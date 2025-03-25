



import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ListOfContent extends StatefulWidget {
  final String text;
  final double screenWidth;
  const ListOfContent(
      {super.key, required this.text, required this.screenWidth});

  @override
  State<ListOfContent> createState() => _ListOfContentState();
}

class _ListOfContentState extends State<ListOfContent> {
  bool isSelected = false; // Tracks if the item is selected

  @override
  Widget build(BuildContext context) {
    return ListTile(
      
      leading: Icon(
        isSelected ? Iconsax.tick_square5 : Iconsax.tick_square4,
        color: isSelected ? Colors.blue : Colors.black,
        size: widget.screenWidth < 600 ? 18 : 24, // Responsive icon size
      ),
      title: Text(
        widget.text,
        style: TextStyle(
          fontSize: widget.screenWidth < 600 ? 10 : 12, // Responsive font size
          fontWeight: FontWeight.bold,
          color: isSelected
              ? Colors.blue
              : Colors.black, // Highlight selected item
        ),
      ),
      onTap: () {
        setState(() {
          isSelected = !isSelected; // Toggle selection
        });
      },
    );
  }
}
