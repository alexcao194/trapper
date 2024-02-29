import 'package:flutter/material.dart';
import 'package:trapper/app/presentation/screen/login/widget/sign_up_box.dart';
import 'package:trapper/config/const/dimen.dart';
import 'package:trapper/generated/l10n.dart';

class DialogTools {
  static void showFailureDialog(
    BuildContext context, {
    required String message,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.current.error),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(S.current.ok),
          ),
        ],
      ),
    );
  }

  static void showSignupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(S.current.signup),
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: Dimen.mobileWidth),
            child: const SignUpBox(),
          ),
        ],
      ),
    );
  }
}
