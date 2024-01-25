import 'package:flutter/material.dart';
import 'package:trapper/app/presentation/widget/form_text_field.dart';
import 'package:trapper/app/presentation/widget/rounded_text_field.dart';
import 'package:trapper/app/presentation/widget/sign_up_box.dart';
import 'package:trapper/utils/validator.dart';

class DialogTools {
  static void showFailureDialog(
    BuildContext context, {
    required String message,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static void showSignupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const SimpleDialog(
        title: Text('Sign up'),
        children: [
          SignUpBox(),
        ],
      ),
    );
  }
}