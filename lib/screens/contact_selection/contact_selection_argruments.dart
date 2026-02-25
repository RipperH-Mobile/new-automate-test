class ContactSelectionArguments {
  final int maxSelectedContact;
  final List<String> ignoredContacts;

  ContactSelectionArguments({
    this.maxSelectedContact = -1,
    this.ignoredContacts = const [],
  }) : assert(maxSelectedContact != 0);
}
