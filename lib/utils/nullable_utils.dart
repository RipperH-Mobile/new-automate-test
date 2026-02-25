class Nullable<T> {
  final T? value;
  final bool isSet;

  const Nullable.value(this.value) : isSet = true;
}
