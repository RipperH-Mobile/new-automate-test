enum InvitedStatus {
  none('NONE'),
  pending('PENDING'),
  member('MEMBER');

  final String value;
  const InvitedStatus(this.value);

  static InvitedStatus from(String val) {
    switch (val) {
      case 'PENDING':
        return InvitedStatus.pending;
      case 'MEMBER':
        return InvitedStatus.member;
      case 'NONE':
      default:
        return InvitedStatus.none;
    }
  }
}
