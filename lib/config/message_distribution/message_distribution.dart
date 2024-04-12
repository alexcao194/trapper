import '../../generated/l10n.dart';

class MessageDistribution {
  const MessageDistribution._();

  static fromID(String id) {
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
      default: return 'unknown';
    }
  }
}