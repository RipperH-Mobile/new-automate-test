import 'package:uchat/features/auth/domain/entities/social_link_entity.dart';

class SocialLinkResponse {
  final String? appleId;
  final String? facebookAccount;
  final String? googleAccount;
  final bool isSuccess;

  SocialLinkResponse({
    this.appleId,
    this.facebookAccount,
    this.googleAccount,
    this.isSuccess = false,
  });

  // from json
  factory SocialLinkResponse.fromJson(Map<String, dynamic> json) {
    return SocialLinkResponse(
      appleId: json['data']?['account']?['linkAccounts']?['apple']?['email'],
      googleAccount: json['data']?['account']?['linkAccounts']?['google']?['email'],
      facebookAccount: json['data']?['account']?['linkAccounts']?['facebook']?['email'],
      isSuccess: json['type'] == 'SUCCESS',
    );
  }

  SocialLinkEntity toEntity() {
    return SocialLinkEntity(
      appleId: appleId,
      googleAccount: googleAccount,
      facebookAccount: facebookAccount,
      isSuccess: isSuccess,
    );
  }
}
