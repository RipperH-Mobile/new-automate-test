class PasswordConditionEntity {
  final bool isLengthValid;
  final bool isLowercaseValid;
  final bool isUppercaseValid;
  final bool isNumberValid;
  final bool isSymbolValid;

  PasswordConditionEntity({
    this.isLengthValid = false,
    this.isLowercaseValid = false,
    this.isUppercaseValid = false,
    this.isNumberValid = false,
    this.isSymbolValid = false,
  });

  bool get isValid => isLengthValid && isLowercaseValid && isUppercaseValid && isNumberValid && isSymbolValid;

  PasswordConditionEntity copyWith({
    bool? isLengthValid,
    bool? isLowercaseValid,
    bool? isUppercaseValid,
    bool? isNumberValid,
    bool? isSymbolValid,
  }) {
    return PasswordConditionEntity(
      isLengthValid: isLengthValid ?? this.isLengthValid,
      isLowercaseValid: isLowercaseValid ?? this.isLowercaseValid,
      isUppercaseValid: isUppercaseValid ?? this.isUppercaseValid,
      isNumberValid: isNumberValid ?? this.isNumberValid,
      isSymbolValid: isSymbolValid ?? this.isSymbolValid,
    );
  }
}