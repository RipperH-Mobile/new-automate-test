import 'package:flutter/material.dart';
import 'package:super_clipboard/super_clipboard.dart';

List<ContextMenuButtonItem> buildPasteContextMenuItems({
  required EditableTextState editableTextState,
  required bool hasCopiedText,
  required bool hasCopiedImages,
  required VoidCallback onPaste,
}) {
  final buttons = editableTextState.contextMenuButtonItems;

  if (!hasCopiedText || hasCopiedImages) {
    final index = buttons.indexWhere((e) => e.type == ContextMenuButtonType.paste);
    final pasteButton = ContextMenuButtonItem(label: 'Paste', onPressed: onPaste);

    if (index != -1) {
      buttons.removeAt(index);
      buttons.insert(index, pasteButton);
    } else {
      buttons.insert(0, pasteButton);
    }
  }

  return buttons;
}

FileFormat? getAvailableFormats(ClipboardDataReader item) {
  if (item.canProvide(Formats.jpeg)) {
    return Formats.jpeg;
  } else if (item.canProvide(Formats.png)) {
    return Formats.png;
  } else if (item.canProvide(Formats.gif)) {
    return Formats.gif;
  } else if (item.canProvide(Formats.webp)) {
    return Formats.webp;
  } else if (item.canProvide(Formats.heic)) {
    return Formats.heic;
  } else if (item.canProvide(Formats.heif)) {
    return Formats.heif;
  } else if (item.canProvide(Formats.tiff)) {
    return Formats.tiff;
  }

  return null;
}
