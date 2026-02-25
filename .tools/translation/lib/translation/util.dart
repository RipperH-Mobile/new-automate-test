bool isOnlyVariable(String text) {
  final trimmed = text.trim();

  if (trimmed == '') {
    return true;
  }

  final patterns = [
    RegExp(r'^@[a-zA-Z0-9_]+$'), // @variable
    RegExp(r'^\$\{[a-zA-Z0-9_.!]+\}$'), // ${variable}
    RegExp(r'^\$[a-zA-Z0-9_.!]+$'), // $variable
  ];

  return patterns.any((pattern) => pattern.hasMatch(trimmed));
}

bool hasDartVariable(String text) {
  final trimmed = text.trim();

  if (trimmed == '') {
    return true;
  }

  final pattern = RegExp(
    r'\$\{[a-zA-Z_][a-zA-Z0-9_]*(?:\[\d+\])?(?:\(\)|\([^}]+\))?(?:\??\.[a-zA-Z_][a-zA-Z0-9_]*(?:\[\d+\])?(?:\(\)|\([^}]+\))?)*\}|\$[a-zA-Z_][a-zA-Z0-9_]*',
  );

  return pattern.hasMatch(trimmed);
}
