class GetRoomTypeGroupAndBeOwnerRequest {
  final bool? isIgnoreOnlyMe;

  GetRoomTypeGroupAndBeOwnerRequest({
    this.isIgnoreOnlyMe = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'isIgnoreOnlyMe': isIgnoreOnlyMe,
    };
  }
}
