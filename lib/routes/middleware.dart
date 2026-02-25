
import 'package:get/get.dart';

class UChatMiddleware extends GetMiddleware {
  final void Function()? onPageCalledTask;
  final void Function()? onPageDisposeTask;

  UChatMiddleware({this.onPageCalledTask, this.onPageDisposeTask});

  @override
  GetPage? onPageCalled(GetPage? page) {
    onPageCalledTask?.call();
    return page;
  }

  @override
  void onPageDispose() {
    onPageDisposeTask?.call();
  }
}