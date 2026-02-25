import 'package:uchat/features/auth/data/models/enum/link_account_type.dart';

class LinkAccountAuthEntity {
  final LinkAccountType type;
  final String email;
  final String? token;

  LinkAccountAuthEntity({
    required this.type,
    required this.email,
    this.token,
  });
}
