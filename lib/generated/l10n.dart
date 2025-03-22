// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Find events with people that matches your interests.`
  String get onboardingStep1 {
    return Intl.message(
      'Find events with people that matches your interests.',
      name: 'onboardingStep1',
      desc: '',
      args: [],
    );
  }

  /// `Create your own event and invite your friends.`
  String get onboardingStep2 {
    return Intl.message(
      'Create your own event and invite your friends.',
      name: 'onboardingStep2',
      desc: '',
      args: [],
    );
  }

  /// `Provided by your location you will get events recommendation.`
  String get onboardingStep3 {
    return Intl.message(
      'Provided by your location you will get events recommendation.',
      name: 'onboardingStep3',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get userName {
    return Intl.message('User Name', name: 'userName', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `E-mail`
  String get email {
    return Intl.message('E-mail', name: 'email', desc: '', args: []);
  }

  // skipped getter for the 'Forgot Password' key

  /// `Remember Me`
  String get rememberMe {
    return Intl.message('Remember Me', name: 'rememberMe', desc: '', args: []);
  }

  /// `Password confirmation`
  String get passwordConfirmation {
    return Intl.message(
      'Password confirmation',
      name: 'passwordConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Or login with`
  String get orloginwith {
    return Intl.message(
      'Or login with',
      name: 'orloginwith',
      desc: '',
      args: [],
    );
  }

  /// `Or signup with`
  String get orSignupwith {
    return Intl.message(
      'Or signup with',
      name: 'orSignupwith',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an account? sign up`
  String get dontHaveAnAccount {
    return Intl.message(
      'Don’t have an account? sign up',
      name: 'dontHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `I agree with privacy policy`
  String get IAgreeWithPrivacyPolicy {
    return Intl.message(
      'I agree with privacy policy',
      name: 'IAgreeWithPrivacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? Login`
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already have an account? Login',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continuetext {
    return Intl.message('Continue', name: 'continuetext', desc: '', args: []);
  }

  /// `What are you interested in?`
  String get whatAreYouInterestedIn {
    return Intl.message(
      'What are you interested in?',
      name: 'whatAreYouInterestedIn',
      desc: '',
      args: [],
    );
  }

  /// `Select your favorite hobbies and majors to attend events`
  String get selectYourFavoriteHobbiesAndMajorsToAttendEvents {
    return Intl.message(
      'Select your favorite hobbies and majors to attend events',
      name: 'selectYourFavoriteHobbiesAndMajorsToAttendEvents',
      desc: '',
      args: [],
    );
  }

  /// `Interests`
  String get interests {
    return Intl.message('Interests', name: 'interests', desc: '', args: []);
  }

  /// `Create now`
  String get createNow {
    return Intl.message('Create now', name: 'createNow', desc: '', args: []);
  }

  /// `Events you might like`
  String get eventsYouMightLike {
    return Intl.message(
      'Events you might like',
      name: 'eventsYouMightLike',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Create event`
  String get createEvent {
    return Intl.message(
      'Create event',
      name: 'createEvent',
      desc: '',
      args: [],
    );
  }

  /// `Event Name`
  String get eventName {
    return Intl.message('Event Name', name: 'eventName', desc: '', args: []);
  }

  /// `Event Description`
  String get eventDescription {
    return Intl.message(
      'Event Description',
      name: 'eventDescription',
      desc: '',
      args: [],
    );
  }

  /// `Tap to choose a location`
  String get tapToChooseALocation {
    return Intl.message(
      'Tap to choose a location',
      name: 'tapToChooseALocation',
      desc: '',
      args: [],
    );
  }

  /// `Choose a category`
  String get chooseACategory {
    return Intl.message(
      'Choose a category',
      name: 'chooseACategory',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
