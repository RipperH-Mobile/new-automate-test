import 'package:get/get.dart';

extension ForceUpdate<T> on RxObjectMixin<T> {
  // Use this to force update to Rx value. Because value setter in Rx will check whether new value and
  // old value is equal or not first, Using operator ==, If they are equal, It will not update the value
  // This function will bypass that check by setting firstRebuild to true.
  //
  // if (_value == val && !firstRebuild) return; <- this is the line in Rx class that we want to bypass
  //
  // This is useful when you want to update the value when new object and old object have the same id but different
  // values.
  void forceUpdate(T val) {
    firstRebuild = true;
    value = val;
  }
}