import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/constants/app_colors.dart';
import 'package:smart_event_planner/core/constants/app_sizes.dart';
import 'package:smart_event_planner/core/constants/app_text_style.dart';
import 'package:smart_event_planner/core/utils/helpers/extensions/date_time_formatting_extension.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderSection extends StatefulWidget {
  const CalenderSection({super.key, required this.onFocusDay});
  final Function(DateTime focusedDay) onFocusDay;
  @override
  CalenderSectionState createState() => CalenderSectionState();
}

class CalenderSectionState extends State<CalenderSection> {
  // The selected date
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  // The calendar format (e.g., month, week, etc.)
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppSizes.defaultScreenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
            weekendDays: [DateTime.friday, DateTime.saturday],
            headerStyle: HeaderStyle(
              titleTextStyle: AppTextStyle.textStyle18Medium,
              headerPadding: const EdgeInsets.only(bottom: 8.0),
            ),
            calendarStyle: CalendarStyle(
              defaultTextStyle: AppTextStyle.defaultCalendarTextStyle,
              outsideTextStyle: AppTextStyle.defaultCalendarTextStyle.copyWith(
                color:
                    AppTextStyle.defaultCalendarTextStyle.color!.withAlpha(80),
              ),
              weekendTextStyle: AppTextStyle.defaultCalendarTextStyle,
              isTodayHighlighted: true,
              todayDecoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: AppColors.blueTextColor, width: 1.6),
                borderRadius: BorderRadius.circular(4.0),
              ),
              todayTextStyle: AppTextStyle.defaultCalendarTextStyle,
              selectedDecoration: ShapeDecoration(
                color: AppColors.secondaryColor.withAlpha(135),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              selectedTextStyle: AppTextStyle.defaultCalendarTextStyle.copyWith(
                fontSize: 17,
                color: AppColors.black,
              ),
            ),
            selectedDayPredicate: (day) {
              // Highlight the selected date
              return isSameDay(_selectedDate, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
                _focusedDay = focusedDay;
                widget.onFocusDay(focusedDay);
              });
            },
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay; // update focused day
            },
          ),
          const SizedBox(height: AppSizes.spaceBtwSection),
          Text(
            _focusedDay.toFormattedFullDate(),
            style: AppTextStyle.textStyle16Bold,
          ),
        ],
      ),
    );
  }
}
