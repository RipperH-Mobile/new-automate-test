part 'emoji_data.dart';
part 'emoji_group.dart';
part 'emoji_subgroup.dart';

class Emoji {
  static const variationSelector16 = 65039;
  static const zwj = 8205;

  final String name;
  final String char;
  final String shortName;
  final EmojiGroup emojiGroup;
  final EmojiSubgroup emojiSubgroup;
  final bool modifiable;
  final List<String> keywords;
  List<int>? _runes;

  /// Emoji class.
  /// [name] of emoji. [char] and character of emoji. [shortName] and a digest name of emoji, [emojiGroup] is emoji's group and [emojiSubgroup] is emoji's subgroup. [keywords] list of keywords for emoji. [modifiable] `true` if emoji has skin.
  Emoji({
    required this.name,
    required this.char,
    required this.shortName,
    required this.emojiGroup,
    required this.emojiSubgroup,
    this.keywords = const [],
    this.modifiable = false,
  });

  /// Runes of Emoji Character
  List<int> get charRunes {
    return _runes ??= char.runes.toList();
  }

  /// Returns current Emoji with New requested [skinTone] if modifiable, else Returns current Emoji
  Emoji newSkin(Fitzpatrick skinTone) {
    if (modifiable) {
      switch (skinTone) {
        case Fitzpatrick.light:
          return Emoji(
            name: '$name, tone1',
            char: modify(char, skinTone),
            shortName: '${shortName}_tone1',
            emojiGroup: emojiGroup,
            emojiSubgroup: emojiSubgroup,
            keywords: keywords,
            modifiable: true,
          );
        case Fitzpatrick.mediumLight:
          return Emoji(
            name: '$name, tone2',
            char: modify(char, skinTone),
            shortName: '${shortName}_tone2',
            emojiGroup: emojiGroup,
            emojiSubgroup: emojiSubgroup,
            keywords: keywords,
            modifiable: true,
          );
        case Fitzpatrick.medium:
          return Emoji(
            name: '$name, tone3',
            char: modify(char, skinTone),
            shortName: '${shortName}_tone3',
            emojiGroup: emojiGroup,
            emojiSubgroup: emojiSubgroup,
            keywords: keywords,
            modifiable: true,
          );
        case Fitzpatrick.mediumDark:
          return Emoji(
            name: '$name, tone4',
            char: modify(char, skinTone),
            shortName: '${shortName}_tone4',
            emojiGroup: emojiGroup,
            emojiSubgroup: emojiSubgroup,
            keywords: keywords,
            modifiable: true,
          );
        case Fitzpatrick.dark:
          return Emoji(
            name: '$name, tone5',
            char: modify(char, skinTone),
            shortName: '${shortName}_tone5',
            emojiGroup: emojiGroup,
            emojiSubgroup: emojiSubgroup,
            keywords: keywords,
            modifiable: true,
          );
        case Fitzpatrick.none:
          return Emoji.byChar(stabilize(char));
      }
    }
    return this;
  }

  /// Get all Emojis
  static List<Emoji> all() => List.unmodifiable(_emojis);

  /// Returns Emoji by [char] and character
  factory Emoji.byChar(String char) {
    return _emojis.firstWhere((Emoji emoji) => emoji.char == char);
  }

  /// Returns Emoji by [name]
  factory Emoji.byName(String name) {
    name = name.toLowerCase(); // todo: searchable name
    return _emojis.firstWhere((Emoji emoji) => emoji.name == name);
  }

  /// Returns Emoji by [name] as short name.
  factory Emoji.byShortName(String name) {
    return _emojis.firstWhere((Emoji emoji) => emoji.char == name);
  }

  /// Returns list of Emojis in a same [group]
  static Iterable<Emoji> byGroup(EmojiGroup group) {
    return _emojis.where((Emoji emoji) => emoji.emojiGroup == group);
  }

  /// Returns list of Emojis in a same [subgroup]
  static Iterable<Emoji> bySubgroup(EmojiSubgroup subgroup) {
    return _emojis.where((Emoji emoji) => emoji.emojiSubgroup == subgroup);
  }

  /// Returns List of Emojis with Specific [keyword]
  static Iterable<Emoji> byKeyword(String keyword) {
    keyword = keyword.toLowerCase();
    return _emojis.where((Emoji emoji) => emoji.keywords.contains(keyword));
  }

  /// disassemble [emoji] to list of emojis, without skin tones if [noSkin] be `true`.
  static List<String> disassemble(String emoji, {bool noSkin = false}) {
    List<int> emojiRunes = emoji.runes.toList();
    emojiRunes
        .removeWhere((codeChar) => zeroWidthCharCodes.contains(codeChar) || (noSkin && _isFitzpatrickCode(codeChar)));
    return emojiRunes.map((char) => String.fromCharCode(char)).toList();
    // return emoji.runes.toList()..removeWhere((codeChar) => ZeroWidthCharCodes.contains(codeChar) || (noSkin && _isFitzpatrickCode(codeChar))).map((char) => String.fromCharCode(char)).toList()
  }

  /// assemble emojis with [emojiChars] codes.
  static String assemble(List<String> emojiChars) {
    List<int> codeCharPoints = [];

    for (var i = 0; i < emojiChars.length; i++) {
      if (i != 0 && !isFitzpatrick(emojiChars[i - 1])) {
        codeCharPoints.add(zwj);
      }
      final emojiRunes = emojiChars[i].runes.toList();
      codeCharPoints.addAll(emojiRunes);
    }
    codeCharPoints.add(variationSelector16);
    return String.fromCharCodes(codeCharPoints);
  }

  /// Modify skin tone of [emoji] by requested [skinTone]
  static String modify(String emoji, Fitzpatrick skinTone) {
    int skinToneCharCode;
    switch (skinTone) {
      case Fitzpatrick.light:
        skinToneCharCode = 127995;
        break;
      case Fitzpatrick.mediumLight:
        skinToneCharCode = 127996;
        break;
      case Fitzpatrick.medium:
        skinToneCharCode = 127997;
        break;
      case Fitzpatrick.mediumDark:
        skinToneCharCode = 127998;
        break;
      case Fitzpatrick.dark:
        skinToneCharCode = 127999;
        break;
      case Fitzpatrick.none:
        return stabilize(emoji);
    }

    final emojiRunes = emoji.runes.toList();
    List<int> finalCharCodes = [];
    for (final charCode in emojiRunes) {
      if (!_isFitzpatrickCode(charCode)) {
        finalCharCodes.add(charCode);
        if (_isModifiable(charCode)) {
          finalCharCodes.add(skinToneCharCode);
        }
      }
    }
    return String.fromCharCodes(finalCharCodes);
  }

  // todo: support unspecified gender for "... holding hands", "kiss", "couple with heart" and "family".
  /// stabilize [skin] and [gender] of [emoji], if `true`.
  static String stabilize(String emoji, {bool skin = true, bool gender = false}) {
    if (gender) {
      emoji = emoji
          .replaceAll('\u{200D}\u{2642}\u{FE0F}', '') // remove ZWJ man from emoji
          .replaceAll('\u{200D}\u{2640}\u{FE0F}', '') // remove ZWJ woman from emoji
          .replaceAll('\u{1F468}', '\u{1F9D1}') // replace man with person
          .replaceAll('\u{1F469}', '\u{1F9D1}') // replace woman with person
          .replaceAll('\u{1F474}', '\u{1F9D3}') // replace old man with old person
          .replaceAll('\u{1F475}', '\u{1F9D3}'); // replace old woman with old person
    }

    final List<int> emojiRunes = emoji.runes.toList();

    if (skin) {
      emojiRunes.removeWhere((codeChar) => _isFitzpatrickCode(codeChar));
    }
    return String.fromCharCodes(emojiRunes);
  }

  /// returns `true` if [emojiCode] is code of Emoji with skin!.
  static _isModifiable(int emojiCode) {
    return _modifiableCharCodes.contains(emojiCode);
  }

  /// returns `true` if [emoji] is a Fitzpatrick Emoji.
  static bool isFitzpatrick(String emoji) {
    return skinToneEmojiChars.contains(emoji);
  }

  /// returns `true` if [emojiCode] is code of Fitzpatrick Emoji.
  static bool _isFitzpatrickCode(int emojiCode) {
    return _skinToneCharCodes.contains(emojiCode);
  }

  @override
  toString() => char;
}
