import 'package:uchat/entities/interfaces.dart';

class MemberEditRoleItemModel {
  final ContactInterface contact;
  final String? previousRole;
  final String currentRole;
  final bool hasChanged;
  final bool show;

  MemberEditRoleItemModel({
    required this.contact,
    this.previousRole,
    this.currentRole = 'Member',
    this.hasChanged = false,
    this.show = true,
  });

  MemberEditRoleItemModel copyWith({
    ContactInterface? contact,
    String? previousRole,
    String? currentRole,
    bool? hasChanged,
    bool? show,
  }) {
    return MemberEditRoleItemModel(
      contact: contact ?? this.contact,
      previousRole: previousRole ?? this.previousRole,
      currentRole: currentRole ?? this.currentRole,
      hasChanged: hasChanged ?? this.hasChanged,
      show: show ?? this.show,
    );
  }

  @override
  String toString() {
    return 'MemberEditRoleItemModel(contact: $contact, previousRole: $previousRole, currentRole: $currentRole, hasChanged: $hasChanged, show: $show)';
  }

  @override
  bool operator ==(covariant MemberEditRoleItemModel other) {
    if (identical(this, other)) return true;

    return other.contact == contact &&
        other.previousRole == previousRole &&
        other.currentRole == currentRole &&
        other.hasChanged == hasChanged &&
        other.show == show;
  }

  @override
  int get hashCode {
    return contact.hashCode ^ previousRole.hashCode ^ currentRole.hashCode ^ hasChanged.hashCode ^ show.hashCode;
  }
}
