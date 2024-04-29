import 'package:flutter/cupertino.dart';
import 'package:toastification/toastification.dart';

import '../generated/l10n.dart';

class NotificationTools {
  const NotificationTools._();

  static void showNotification({required BuildContext context, required String message}) {
    toastification.show(
      context: context,
      type: ToastificationType.info,
      style: ToastificationStyle.flatColored,
      title: Text(S.current.success),
      description: Text(message),
      alignment: Alignment.topRight,
      autoCloseDuration: const Duration(seconds: 3),
    );
  }

  static void showSuccessNotification({required BuildContext context, required String message}) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flatColored,
      title: Text(S.current.success),
      description: Text(message),
      alignment: Alignment.topRight,
      autoCloseDuration: const Duration(seconds: 3),
    );
  }

  static void showErrorNotification({required BuildContext context, required String message}) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      title: Text(S.current.failure),
      description: Text(message),
      alignment: Alignment.topRight,
      autoCloseDuration: const Duration(seconds: 3),
    );
  }
}
