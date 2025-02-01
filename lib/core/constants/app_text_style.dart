import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/utils/helpers/app_context.dart';

class AppTextStyle {
  AppTextStyle._();

  static TextStyle textStyle32Bold(BuildContext context) {
    return Theme.of(AppContext.context).textTheme.headlineLarge!;
  }

  static TextStyle textStyle20Bold(BuildContext context) {
    return Theme.of(AppContext.context)
        .textTheme
        .titleMedium!
        .copyWith(fontSize: 20, fontWeight: FontWeight.w700);
  }

  static TextStyle textStyle13SemiBold(BuildContext context) =>
      Theme.of(AppContext.context)
          .textTheme
          .bodyMedium!
          .copyWith(fontWeight: FontWeight.w600, fontSize: 13);

  static TextStyle textStyle18ExtraBold(BuildContext context) =>
      Theme.of(AppContext.context).textTheme.titleLarge!.copyWith(fontSize: 18);

  static TextStyle textStyle20Medium(BuildContext context) =>
      Theme.of(AppContext.context).textTheme.titleMedium!;

  static TextStyle textStyle32Medium(BuildContext context) =>
      Theme.of(AppContext.context).textTheme.headlineMedium!;

  static TextStyle textStyle24Medium(BuildContext context) =>
      Theme.of(AppContext.context).textTheme.headlineSmall!;

  static TextStyle textStyle14Regular(BuildContext context) =>
      Theme.of(AppContext.context).textTheme.bodyMedium!;

  static TextStyle textStyle16Regular(BuildContext context) =>
      Theme.of(AppContext.context).textTheme.bodyMedium!;

  static TextStyle textStyle16Medium(BuildContext context) =>
      Theme.of(AppContext.context).textTheme.bodyLarge!.copyWith(fontSize: 14);

  static defaultCalendarTextStyle(BuildContext context) => Theme.of(context)
      .textTheme
      .bodyLarge!
      .copyWith(fontWeight: FontWeight.w500);

  static TextStyle textStyle16Bold(BuildContext context) =>
      Theme.of(AppContext.context)
          .textTheme
          .bodyLarge!
          .copyWith(fontSize: 16, fontWeight: FontWeight.w700);

  static TextStyle textStyle17Medium(BuildContext context) =>
      Theme.of(AppContext.context)
          .textTheme
          .headlineSmall!
          .copyWith(fontSize: 17);

  static TextStyle textStyle12Regular(BuildContext context) =>
      Theme.of(AppContext.context).textTheme.bodySmall!;

  static TextStyle textStyle15Regular(BuildContext context) =>
      Theme.of(AppContext.context).textTheme.bodyMedium!.copyWith(fontSize: 15);

  static TextStyle textStyle13Light(BuildContext context) =>
      Theme.of(AppContext.context).textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.w300, fontSize: 13, color: Colors.white);
  static TextStyle textStyle14Light(BuildContext context) =>
      Theme.of(AppContext.context).textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.w300, fontSize: 14, color: Colors.white);
}
