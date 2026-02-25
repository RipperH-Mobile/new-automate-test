import 'package:isar_community/isar.dart';

part 'mobile_contact_model.g.dart';

@embedded
class MobileContactModel {
  String? displayName;
  String? phoneNumber;

  MobileContactModel({
    this.displayName,
    this.phoneNumber,
  });

  factory MobileContactModel.fromMap(Map<String, dynamic> data) {
    final mobileContact = MobileContactModel();

    if (data['phoneNumber'] != null) {
      mobileContact.phoneNumber = data['phoneNumber'];
    }

    if (data['displayName'] != null) {
      mobileContact.displayName = data['displayName'];
    }

    return mobileContact;
  }

  @override
  String toString() {
    return 'phoneNumber: $phoneNumber, displayName: $displayName';
  }

  Map<String, dynamic> toJson() {
    return {'phoneNumber': phoneNumber, 'displayName': displayName};
  }
}
