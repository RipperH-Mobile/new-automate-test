import 'package:uchat/api/http.dart';
import 'package:uchat/api/socket.dart';

mixin ServiceMixin {
  HttpCaller httpCaller = HttpCaller();
  SocketCaller socketCaller = SocketCaller();
}
