class SocialLinkEntity {
  final String? appleId;
  final String? facebookAccount;
  final String? googleAccount;
  final bool isSuccess;
  final bool isAccountUpdated;

  SocialLinkEntity({
    this.appleId,
    this.facebookAccount,
    this.googleAccount,
    this.isSuccess = false,
    this.isAccountUpdated = true,
  });
}
