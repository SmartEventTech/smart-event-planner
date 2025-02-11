// ignore_for_file: library_private_types_in_public_api


import 'package:flutter/material.dart';
import 'package:smart_event_planner/features/map/presentation/screens/map_screen.dart';


class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final List<String> categories = [
    'Birthday',
    'Friendsgiving',
    'Graduation Gala',
    'Wedding',
    'Anniversary',
    'Studying Goal',
  ];

  final Set<int> selectedIndexes = {};
  

  double _calculateFontSize(double screenWidth) =>
      (screenWidth * 0.03).clamp(12.0, 16.0);

  double _calculateAdjustedAspectRatio(double screenWidth) {
    if (screenWidth < 400) return 3.5;
    if (screenWidth < 600) return 3.5;
    return 4.0;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: const Text('Create Event'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 25,
                right: 20,
                top: 10,
                bottom: MediaQuery.of(context).padding.bottom + 70,
              ),
              child: _buildContent(screenSize),
            ),
          ),
        
        ],
      ),
    );
  }

  Widget _buildContent(Size screenSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField('Event Name', 45),
        const SizedBox(height: 20),
        _buildTextField('Event Description', screenSize.height * 0.13,
            maxLines: null),
        const SizedBox(height: 20),
        _buildLocationConfirmation(),
        const SizedBox(height: 12),
        _buildSectionTitle('Choose a category'),
        _buildCategoryGrid(),
        const SizedBox(height: 15),
        _buildSectionTitle('Else'),
        _buildTextField('Type your category', 40),
        const SizedBox(height: 15),
        _buildSectionTitle('Event Photo'),
        _buildPhotoUploadSection(screenSize),
      ],
    );
  }

  Widget _buildTextField(String label, double height, {int? maxLines}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 5),
        SizedBox(
          height: height,
          child: TextField(
            maxLines: maxLines,
            expands: maxLines == null,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationConfirmation() {
    return IntrinsicWidth(

      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MapScreen()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 45,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xffA00651),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.location_on_sharp, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                'Confirmed',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Column(
      children: [
        Text(title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget _buildCategoryGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: categories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: _calculateAdjustedAspectRatio(screenWidth),
          ),
          itemBuilder: (context, index) {
            final isSelected = selectedIndexes.contains(index);
            return GestureDetector(
              onTap: () => setState(() => isSelected
                  ? selectedIndexes.remove(index)
                  : selectedIndexes.add(index)),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.02,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xffA00651) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? const Color(0xffA00651) : Colors.grey,
                    width: 1.2,
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/Ellipse.png',
                      width: screenWidth * 0.05,
                      height: screenWidth * 0.05,
                    ),
                    SizedBox(width: screenWidth * 0.015),
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          categories[index],
                          style: TextStyle(
                            fontSize: _calculateFontSize(screenWidth) * 0.9,
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPhotoUploadSection(Size screenSize) {
    return Container(
      height: screenSize.height * 0.2,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: IconButton(
          icon: Icon(Icons.add_a_photo,
              size: screenSize.width * 0.08, color: Colors.grey),
          onPressed: () {},
        ),
      ),
    );
  }

}
