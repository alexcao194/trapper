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
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
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
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Trapper`
  String get app_name {
    return Intl.message(
      'Trapper',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `@Trapper`
  String get app_name_annotation {
    return Intl.message(
      '@Trapper',
      name: 'app_name_annotation',
      desc: '',
      args: [],
    );
  }

  /// `Dating app no.1 PTIT`
  String get app_description {
    return Intl.message(
      'Dating app no.1 PTIT',
      name: 'app_description',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signup {
    return Intl.message(
      'Sign up',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirm_password {
    return Intl.message(
      'Confirm password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgot_password {
    return Intl.message(
      'Forgot password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get reset_password {
    return Intl.message(
      'Reset password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get full_name {
    return Intl.message(
      'Full name',
      name: 'full_name',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phone_number {
    return Intl.message(
      'Phone number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Date of birth`
  String get date_of_birth {
    return Intl.message(
      'Date of birth',
      name: 'date_of_birth',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Bio`
  String get bio {
    return Intl.message(
      'Bio',
      name: 'bio',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `example@gmail.com`
  String get email_example {
    return Intl.message(
      'example@gmail.com',
      name: 'email_example',
      desc: '',
      args: [],
    );
  }

  /// `********`
  String get password_example {
    return Intl.message(
      '********',
      name: 'password_example',
      desc: '',
      args: [],
    );
  }

  /// `********`
  String get confirm_password_example {
    return Intl.message(
      '********',
      name: 'confirm_password_example',
      desc: '',
      args: [],
    );
  }

  /// `John Doe`
  String get full_name_example {
    return Intl.message(
      'John Doe',
      name: 'full_name_example',
      desc: '',
      args: [],
    );
  }

  /// `0123456789`
  String get phone_number_example {
    return Intl.message(
      '0123456789',
      name: 'phone_number_example',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get email_invalid {
    return Intl.message(
      'Invalid email',
      name: 'email_invalid',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get email_required {
    return Intl.message(
      'Email is required',
      name: 'email_required',
      desc: '',
      args: [],
    );
  }

  /// `Invalid password`
  String get password_invalid {
    return Intl.message(
      'Invalid password',
      name: 'password_invalid',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get password_required {
    return Intl.message(
      'Password is required',
      name: 'password_required',
      desc: '',
      args: [],
    );
  }

  /// `Invalid confirm password`
  String get confirm_password_invalid {
    return Intl.message(
      'Invalid confirm password',
      name: 'confirm_password_invalid',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password is required`
  String get confirm_password_required {
    return Intl.message(
      'Confirm password is required',
      name: 'confirm_password_required',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password does not match`
  String get confirm_password_not_match {
    return Intl.message(
      'Confirm password does not match',
      name: 'confirm_password_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get password_length_error {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'password_length_error',
      desc: '',
      args: [],
    );
  }

  /// `Full name is required`
  String get full_name_required {
    return Intl.message(
      'Full name is required',
      name: 'full_name_required',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone number`
  String get phone_number_invalid {
    return Intl.message(
      'Invalid phone number',
      name: 'phone_number_invalid',
      desc: '',
      args: [],
    );
  }

  /// `Phone number is required`
  String get phone_number_required {
    return Intl.message(
      'Phone number is required',
      name: 'phone_number_required',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again later.`
  String get common_error {
    return Intl.message(
      'Something went wrong. Please try again later.',
      name: 'common_error',
      desc: '',
      args: [],
    );
  }

  /// `Please fill all required fields.`
  String get common_fields_error {
    return Intl.message(
      'Please fill all required fields.',
      name: 'common_fields_error',
      desc: '',
      args: [],
    );
  }

  /// `dd/mm/yyyy`
  String get date_of_birth_example {
    return Intl.message(
      'dd/mm/yyyy',
      name: 'date_of_birth_example',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile_button {
    return Intl.message(
      'Profile',
      name: 'profile_button',
      desc: '',
      args: [],
    );
  }

  /// `Friends`
  String get friends_button {
    return Intl.message(
      'Friends',
      name: 'friends_button',
      desc: '',
      args: [],
    );
  }

  /// `Messages`
  String get messages_button {
    return Intl.message(
      'Messages',
      name: 'messages_button',
      desc: '',
      args: [],
    );
  }

  /// `Connect`
  String get connect_button {
    return Intl.message(
      'Connect',
      name: 'connect_button',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings_button {
    return Intl.message(
      'Settings',
      name: 'settings_button',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help_button {
    return Intl.message(
      'Help',
      name: 'help_button',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout_button {
    return Intl.message(
      'Logout',
      name: 'logout_button',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update_button {
    return Intl.message(
      'Update',
      name: 'update_button',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete_button {
    return Intl.message(
      'Delete',
      name: 'delete_button',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save_button {
    return Intl.message(
      'Save',
      name: 'save_button',
      desc: '',
      args: [],
    );
  }

  /// `Vietnamese`
  String get vietnamese {
    return Intl.message(
      'Vietnamese',
      name: 'vietnamese',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Show`
  String get show {
    return Intl.message(
      'Show',
      name: 'show',
      desc: '',
      args: [],
    );
  }

  /// `Hide`
  String get hide {
    return Intl.message(
      'Hide',
      name: 'hide',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Primary color`
  String get primary_color {
    return Intl.message(
      'Primary color',
      name: 'primary_color',
      desc: '',
      args: [],
    );
  }

  /// `Red`
  String get red {
    return Intl.message(
      'Red',
      name: 'red',
      desc: '',
      args: [],
    );
  }

  /// `Green`
  String get green {
    return Intl.message(
      'Green',
      name: 'green',
      desc: '',
      args: [],
    );
  }

  /// `Blue`
  String get blue {
    return Intl.message(
      'Blue',
      name: 'blue',
      desc: '',
      args: [],
    );
  }

  /// `Online`
  String get online {
    return Intl.message(
      'Online',
      name: 'online',
      desc: '',
      args: [],
    );
  }

  /// `Offline`
  String get offline {
    return Intl.message(
      'Offline',
      name: 'offline',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Search...`
  String get search_hint {
    return Intl.message(
      'Search...',
      name: 'search_hint',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Which type of person are you looking for?`
  String get search_prompt {
    return Intl.message(
      'Which type of person are you looking for?',
      name: 'search_prompt',
      desc: '',
      args: [],
    );
  }

  /// `Hobbies`
  String get hobbies {
    return Intl.message(
      'Hobbies',
      name: 'hobbies',
      desc: '',
      args: [],
    );
  }

  /// `Reading`
  String get reading {
    return Intl.message(
      'Reading',
      name: 'reading',
      desc: '',
      args: [],
    );
  }

  /// `Music`
  String get music {
    return Intl.message(
      'Music',
      name: 'music',
      desc: '',
      args: [],
    );
  }

  /// `Cooking`
  String get cooking {
    return Intl.message(
      'Cooking',
      name: 'cooking',
      desc: '',
      args: [],
    );
  }

  /// `Traveling`
  String get traveling {
    return Intl.message(
      'Traveling',
      name: 'traveling',
      desc: '',
      args: [],
    );
  }

  /// `Coding`
  String get coding {
    return Intl.message(
      'Coding',
      name: 'coding',
      desc: '',
      args: [],
    );
  }

  /// `Game`
  String get game {
    return Intl.message(
      'Game',
      name: 'game',
      desc: '',
      args: [],
    );
  }

  /// `Sports`
  String get sports {
    return Intl.message(
      'Sports',
      name: 'sports',
      desc: '',
      args: [],
    );
  }

  /// `Movies`
  String get movies {
    return Intl.message(
      'Movies',
      name: 'movies',
      desc: '',
      args: [],
    );
  }

  /// `Fashion`
  String get fashion {
    return Intl.message(
      'Fashion',
      name: 'fashion',
      desc: '',
      args: [],
    );
  }

  /// `Photography`
  String get photography {
    return Intl.message(
      'Photography',
      name: 'photography',
      desc: '',
      args: [],
    );
  }

  /// `Art`
  String get art {
    return Intl.message(
      'Art',
      name: 'art',
      desc: '',
      args: [],
    );
  }

  /// `Animals`
  String get animals {
    return Intl.message(
      'Animals',
      name: 'animals',
      desc: '',
      args: [],
    );
  }

  /// `Chatting`
  String get chatting {
    return Intl.message(
      'Chatting',
      name: 'chatting',
      desc: '',
      args: [],
    );
  }

  /// `Dating`
  String get dating {
    return Intl.message(
      'Dating',
      name: 'dating',
      desc: '',
      args: [],
    );
  }

  /// `Type a message...`
  String get text_message_hint {
    return Intl.message(
      'Type a message...',
      name: 'text_message_hint',
      desc: '',
      args: [],
    );
  }

  /// `You can select up to 3 hobbies`
  String get hobbies_limit {
    return Intl.message(
      'You can select up to 3 hobbies',
      name: 'hobbies_limit',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully`
  String get password_changed {
    return Intl.message(
      'Password changed successfully',
      name: 'password_changed',
      desc: '',
      args: [],
    );
  }

  /// `Invalid data`
  String get invalid_data {
    return Intl.message(
      'Invalid data',
      name: 'invalid_data',
      desc: '',
      args: [],
    );
  }

  /// `Invalid {field}`
  String invalid_field(String field) {
    return Intl.message(
      'Invalid $field',
      name: 'invalid_field',
      desc: 'Invalid field',
      args: [field],
    );
  }

  /// `Incorrect email or password`
  String get incorrect_email_or_password {
    return Intl.message(
      'Incorrect email or password',
      name: 'incorrect_email_or_password',
      desc: '',
      args: [],
    );
  }

  /// `Email already in use`
  String get email_already_in_use {
    return Intl.message(
      'Email already in use',
      name: 'email_already_in_use',
      desc: '',
      args: [],
    );
  }

  /// `Send message failed`
  String get send_message_failed {
    return Intl.message(
      'Send message failed',
      name: 'send_message_failed',
      desc: '',
      args: [],
    );
  }

  /// `Profile not found`
  String get profile_not_found {
    return Intl.message(
      'Profile not found',
      name: 'profile_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Hobbies not found`
  String get hobbies_not_found {
    return Intl.message(
      'Hobbies not found',
      name: 'hobbies_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Invalid file`
  String get file_invalid {
    return Intl.message(
      'Invalid file',
      name: 'file_invalid',
      desc: '',
      args: [],
    );
  }

  /// `Nothing to update`
  String get nothing_to_update {
    return Intl.message(
      'Nothing to update',
      name: 'nothing_to_update',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated`
  String get profile_updated {
    return Intl.message(
      'Profile updated',
      name: 'profile_updated',
      desc: '',
      args: [],
    );
  }

  /// `No friends`
  String get no_friends {
    return Intl.message(
      'No friends',
      name: 'no_friends',
      desc: '',
      args: [],
    );
  }

  /// `Please select at least one hobby`
  String get no_hobbies_error {
    return Intl.message(
      'Please select at least one hobby',
      name: 'no_hobbies_error',
      desc: '',
      args: [],
    );
  }

  /// `Send a message`
  String get last_message_placeholder {
    return Intl.message(
      'Send a message',
      name: 'last_message_placeholder',
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
      Locale.fromSubtags(languageCode: 'vi'),
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
