class GetExpirationTimeListResponse {
  List<int> expireActiveTimeList;
  List<int> expireFixedTimeList;

  GetExpirationTimeListResponse({
    required this.expireActiveTimeList,
    required this.expireFixedTimeList,
  });

  static GetExpirationTimeListResponse fromJson(Map<String, dynamic> json) {
    return GetExpirationTimeListResponse(
      expireActiveTimeList: json['expireActiveTimeList'].cast<int>(),
      expireFixedTimeList: json['expireFixedTimeList'].cast<int>(),
    );
  }
}
