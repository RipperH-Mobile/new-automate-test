class MobileContactSelectionArguments {
  final int maxSelectedContact;

  MobileContactSelectionArguments({
    this.maxSelectedContact = -1,
  }) : assert(maxSelectedContact != 0);
}
