String sanitizeThaiText(String input) {
  // Remove repeated vowels or tone marks by capturing one occurrence and replacing multiple with a single one
  return input.replaceAllMapped(
    RegExp(r'([ัิีึืุู็่้๊๋์])\1{2,}'),
    (match) => match.group(1) ?? '',
  );
}
