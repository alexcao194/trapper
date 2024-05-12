import 'package:flutter/cupertino.dart';

import '../../generated/l10n.dart';

class MessageDistribution {
  const MessageDistribution._();

  static fromID(String id) {

    id = id.replaceAll('"', '');

    if (id != "invalid-data" && id.startsWith('invalid-')) {
      return S.current.invalid_field(id.substring(9));
    }

    debugPrint('Message Distribution: $id');

    switch (id) {
      case 'reading': return S.current.reading;
      case 'coding': return S.current.coding;
      case 'cooking': return S.current.cooking;
      case 'music': return S.current.music;
      case 'game': return S.current.game;
      case 'chatting': return S.current.chatting;
      case 'dating': return S.current.dating;
      case 'animals': return S.current.animals;
      case 'traveling': return S.current.traveling;
      case 'sports': return S.current.sports;
      case 'movies': return S.current.movies;
      case 'fashion': return S.current.fashion;
      case 'photography': return S.current.photography;
      case 'art': return S.current.art;
      case 'password-changed': return S.current.password_changed;
      case 'invalid-data': return S.current.invalid_data;
      case 'incorrect-email-or-password': return S.current.incorrect_email_or_password;
      case 'old-password-incorrect': return S.current.old_password_incorrect;
      case 'email-exists': return S.current.email_already_in_use;
      case 'send-message-failed': return S.current.send_message_failed;
      case 'profile-not-found': return S.current.profile_not_found;
      case 'hobbies-not-found': return S.current.hobbies_not_found;
      case 'file-invalid': return S.current.file_invalid;
      case 'invalid-password!': return S.current.incorrect_email_or_password;
      case 'jwt-expired!': return S.current.jwt_expired;
      case 'incorrect-email-or-password': return S.current.incorrect_email_or_password;

      default: return id;
    }
  }
}