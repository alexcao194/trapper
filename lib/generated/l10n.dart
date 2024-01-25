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

  /// `Trap all person you want`
  String get app_description {
    return Intl.message(
      'Trap all person you want',
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
