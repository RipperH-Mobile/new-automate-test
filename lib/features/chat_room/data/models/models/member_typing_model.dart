import 'package:uchat/entities/interfaces/contact_interface.dart';

/// Model for member typing
///
/// Store the typing status of a member
class MemberTypingModel {
  /// Account id of the member
  ///
  /// This is used to identify the member
  ///
  /// This is `required`
  final String accountId;

  /// Last time the member type
  final DateTime? lastTypeAt;

  /// Contact info of the member
  ///
  /// This is used to display the member info in the UI
  /// such as avatar, name, etc.
  ///
  /// This is `required`
  final ContactInterface contact;

  /// Is the member currently typing
  ///
  /// Default is `false`
  final bool isTyping;

  MemberTypingModel({
    required this.accountId,
    required this.contact,
    this.lastTypeAt,
    this.isTyping = false,
  });

  MemberTypingModel copyWith({
    String? accountId,
    DateTime? lastTypeAt,
    ContactInterface? contact,
    bool? isTyping,
  }) {
    return MemberTypingModel(
      accountId: accountId ?? this.accountId,
      lastTypeAt: lastTypeAt ?? this.lastTypeAt,
      contact: contact ?? this.contact,
      isTyping: isTyping ?? this.isTyping,
    );
  }

  @override
  String toString() {
    return 'MemberTypingModel(accountId: $accountId, lastTypeAt: $lastTypeAt, contact: $contact, isTyping: $isTyping)';
  }
}
