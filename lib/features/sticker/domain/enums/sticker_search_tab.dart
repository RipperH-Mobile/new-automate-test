enum StickerSearchTab {
  all('All'),
  character('Character'),
  creator('Creator');

  final String value;
  const StickerSearchTab(this.value);

  static List<StickerSearchTab> get valuesWithoutAll => StickerSearchTab.values
      .where(
        (tab) => tab != StickerSearchTab.all,
      )
      .toList();

  bool get isAll => this == StickerSearchTab.all;
  bool get isCharacter => this == StickerSearchTab.character;
  bool get isCreator => this == StickerSearchTab.creator;
}
