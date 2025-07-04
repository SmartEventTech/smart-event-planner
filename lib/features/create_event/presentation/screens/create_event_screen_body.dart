import 'package:eventy/features/create_event/presentation/widgets/progress_indecator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/validators/validation.dart';
import 'package:eventy/features/create_event/presentation/widgets/category_list.dart';
import 'package:eventy/features/create_event/presentation/widgets/confirmation_location_button.dart';
import 'package:eventy/features/create_event/presentation/widgets/upload_event_image_section.dart';

class CreateEventScreenBody extends StatefulWidget {
  const CreateEventScreenBody({super.key});

  @override
  State<CreateEventScreenBody> createState() => _CreateEventScreenBodyState();
}

class _CreateEventScreenBodyState extends State<CreateEventScreenBody> {
  int _currentStep = 0;
  final PageController _pageController = PageController();

  final List<String> _stepTitles = [
    "Event Details",
    "Category",
    "Event Location",
    "Event Image",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Progress Indicator with Title and Step Count
          ProgressIndecator(currentStep: _currentStep, stepTitles: _stepTitles),
          const SizedBox(height: AppSizes.md),
      
          // Main Content
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildStep1(context),
                _buildStep2(context),
                _buildStep3(context),
                _buildStep4(context),
              ],
            ),
          ),
      
          // Navigation Buttons
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.defaultScreenPadding,
              vertical: AppSizes.md,
            ),
            child: Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _previousStep,
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Back'),
                    ),
                  ),
                if (_currentStep > 0) const SizedBox(width: AppSizes.md),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _nextStep,
                    icon: Icon(_currentStep == 3
                        ? Icons.check
                        : Icons.arrow_forward),
                    label: Text(_currentStep == 3 ? 'Create Event' : 'Next'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
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

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() => _currentStep++);
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context);
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _buildStep1(BuildContext context) {
    return _buildScrollContainer(
      children: [

        _buildEventName(context),
        const SizedBox(height: AppSizes.spaceBtwTextField),
        _buildEventDescription(context),
      ],
    );
  }

  Widget _buildStep3(BuildContext context) {
  return _buildScrollContainer(
    children: [
      // Section title
      Text(
        'Location on Map',
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontWeight: FontWeight.w600),
      ),
      const SizedBox(height: AppSizes.spaceBtwTextField),

      // Map button
      const ConfirmationLocationButton(),
      const SizedBox(height: 32),

      // Required location input
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Location Details',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 12),
          TextFormField(
            validator: (value) =>
                value == null || value.isEmpty ? 'Location is required' : null,
            decoration: InputDecoration(
              hintText: 'Enter location address or name',
              hintStyle: TextStyle(color: Colors.grey.shade500),
              filled: true,
              fillColor: Colors.grey.shade100,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(AppSizes.textFieldRadius),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(AppSizes.textFieldRadius),
                borderSide: BorderSide(
                  color: AppColors.secondaryColor,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}


  Widget _buildStep2(BuildContext context) {
    return _buildScrollContainer(
      children: [
        Text('Choose a Category',
            style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: AppSizes.slg),
        const CategoryList(),
        const SizedBox(height: AppSizes.spaceBtwTextField),
        Text('Or specify your own',
            style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: AppSizes.md),
        _buildCategoryField(context),
      ],
    );
  }

  Widget _buildStep4(BuildContext context) {
    return _buildScrollContainer(
      children: const [
        UploadEventImageSection(),
      ],
    );
  }

  Widget _buildScrollContainer({required List<Widget> children}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.defaultScreenPadding,
        vertical: AppSizes.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

Widget _buildEventDescription(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Event Description',
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      const SizedBox(height: 12),
      TextFormField(
        maxLines: 5,
        keyboardType: TextInputType.multiline,
        textAlignVertical: TextAlignVertical.top,
        validator: (value) =>
            TValidator.validateEmptyText('Event Description', value),
        decoration: InputDecoration(
          hintText: 'Describe your event',
          hintStyle: TextStyle(color: Colors.grey.shade500),
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.textFieldRadius),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.textFieldRadius),
            borderSide: BorderSide(
              color: AppColors.secondaryColor,
              width: 1.5,
            ),
          ),
        ),
      ),
    ],
  );
}

  Widget _buildEventName(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Event Name',
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      const SizedBox(height: 12),
      TextFormField(
        validator: (value) =>
            TValidator.validateEmptyText('Event Name', value),
        decoration: InputDecoration(
          hintText: 'Enter event name',
          hintStyle: TextStyle(color: Colors.grey.shade500),
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.textFieldRadius),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.textFieldRadius),
            borderSide: BorderSide(
              color: AppColors.secondaryColor,
              width: 1.5,
            ),
          ),
        ),
      ),
    ],
  );
}


  TextFormField _buildCategoryField(BuildContext context) {
  return TextFormField(
    inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'^[0-9]'))],
    decoration: InputDecoration(
      hintText: 'Type your category',
      hintStyle: TextStyle(color: Colors.grey.shade500),
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.textFieldRadius),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.textFieldRadius),
        borderSide: BorderSide(
          color: AppColors.secondaryColor,
          width: 1.5,
        ),
      ),
    ),
  );
}

}


