class UnpublishMenuSubscribe {
  String? id;
  DateTime? lastUpdatedAt;

  UnpublishMenuSubscribe({
    this.id,
    this.lastUpdatedAt,
  });

  factory UnpublishMenuSubscribe.fromMap(Map<String, dynamic> json) {
    final publishMenuResp = UnpublishMenuSubscribe();

    if (json['id'] != null) {
      publishMenuResp.id = json['id'];
    }

    if (json['updatedAt'] != null) {
      publishMenuResp.lastUpdatedAt = DateTime.parse(json['updatedAt'].toString());
    }

    return publishMenuResp;
  }
}
