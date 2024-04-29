import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../app/presentation/screen/login/widget/forgot_password_box.dart';
import '../app/presentation/screen/login/widget/sign_up_box.dart';
import '../config/const/dimen.dart';
import '../generated/l10n.dart';

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

  static void showForgotPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(S.current.forgot_password),
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: Dimen.mobileWidth),
            child: const ForgotPasswordBox(),
          ),
        ],
      ),
    );
  }

  static void showConnectDialog(BuildContext context, VoidCallback onCancel) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.current.connect_dialog_title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LoadingAnimationWidget.waveDots(
              size: 30,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 10),
            Text(S.current.connect_dialog_content),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              onCancel();
              Navigator.of(context).pop();
            },
            child: Text(S.current.cancel),
          ),
        ],
      ),
    );
  }
}
