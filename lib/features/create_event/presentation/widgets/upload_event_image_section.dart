import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_sizes.dart';

class UploadEventImageSection extends StatelessWidget {
  const UploadEventImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final boxHeight = screenSize.height * 0.2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Event Image Section
        Text(
          'Event Image',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: AppSizes.lg),
        _buildUploadBox(
          context,
          height: boxHeight,
          icon: Icons.event,
          label: 'Upload Event Image',
          onPressed: () {
          
          },
        ),

        const SizedBox(height: AppSizes.spaceBtwSections),

        // Cover Image Section
        Text(
          'Cover Image',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: AppSizes.lg),
        _buildUploadBox(
          context,
          height: boxHeight*0.8,
          icon: Icons.image_outlined,
          label: 'Upload Cover Image',
          onPressed: () {
          
          },
        ),
      ],
    );
  }

  Widget _buildUploadBox(
    BuildContext context, {
    required double height,
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade100,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: Colors.grey.shade600),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
