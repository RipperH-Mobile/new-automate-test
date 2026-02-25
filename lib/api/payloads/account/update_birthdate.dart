import 'package:uchat/utils/date.dart';

class UpdateBirthdateRequest {
  DateTime birthdate;

  UpdateBirthdateRequest({
    required this.birthdate,
  });

  Map<String, dynamic> toMap() {
    return {
      'birthDate': birthdate.format('yyyy-MM-dd', 'en-US'),
    };
  }
}
