enum ChatFolderEditType {
  create('CREATE'),
  edit('EDIT');

  final String value;
  const ChatFolderEditType(this.value);

  factory ChatFolderEditType.fromString(String stateName) {
    return values.firstWhere((e) => e.value == stateName);
  }
}
