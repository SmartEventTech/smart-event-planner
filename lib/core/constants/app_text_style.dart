import 'package:flutter/material.dart';
import 'package:smart_event_planner/core/utils/helpers/app_context.dart';

class AppTextStyle {
  AppTextStyle._();

  static final TextStyle textStyle32Bold =
      Theme.of(AppContext.context).textTheme.headlineLarge!;

  static final TextStyle textStyle20Bold = Theme.of(AppContext.context)
      .textTheme
      .titleMedium!
      .copyWith(fontSize: 20, fontWeight: FontWeight.w700);

  static final TextStyle textStyle13SemiBold = Theme.of(AppContext.context)
      .textTheme
      .bodyMedium!
      .copyWith(fontWeight: FontWeight.w600, fontSize: 13);

  static final TextStyle textStyle20ExtraBold = Theme.of(AppContext.context)
      .textTheme
      .titleLarge!
      .copyWith(fontWeight: FontWeight.w800, fontSize: 20);

  static final TextStyle textStyle20Medium = Theme.of(AppContext.context)
      .textTheme
      .titleMedium!
      .copyWith(fontSize: 20, fontWeight: FontWeight.w500);

  static final TextStyle textStyle32Medium =
      Theme.of(AppContext.context).textTheme.headlineMedium!;

  static final TextStyle textStyle24Medium =
      Theme.of(AppContext.context).textTheme.headlineSmall!;

  static final TextStyle textStyle14Regular =
      Theme.of(AppContext.context).textTheme.bodyMedium!;

  static final TextStyle textStyle16Regular =
      Theme.of(AppContext.context).textTheme.bodyMedium!.copyWith(fontSize: 16);

  static final TextStyle textStyle12Regular =
      Theme.of(AppContext.context).textTheme.bodySmall!;
      
  static final TextStyle textStyle15Regular =
      Theme.of(AppContext.context).textTheme.bodyMedium!.copyWith(fontSize: 15);

  static final TextStyle textStyle13Light = Theme.of(AppContext.context)
      .textTheme
      .bodyMedium!
      .copyWith(fontWeight: FontWeight.w300, fontSize: 13);
}
