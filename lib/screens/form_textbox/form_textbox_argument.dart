class FormTextboxArgument {
  bool showBackButton;
  bool showRestoreOriginalValue;
  String title;
  String? restoreOriginalValueText;
  String actionButtonTitle;
  int? maxLength;
  String? value;
  String? description;
  Future<bool> Function(String? value)? onActionButton;

  FormTextboxArgument({
    required this.title,
    required this.actionButtonTitle,
    this.showBackButton = true,
    this.showRestoreOriginalValue = true,
    this.value,
    this.restoreOriginalValueText,
    this.description,
    this.onActionButton,
    required this.maxLength,
  });
}
