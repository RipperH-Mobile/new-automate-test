import 'package:uchat/api/backend_path.dart';

const checkCanChangePhoneNumberPath = BackendPathModel(
  http: 'v3/users/settings/phone-number/validate',
  socket: 'v3.accounts.settings.changePhoneNumber.check',
);
const checkNewPhoneNumberPath = BackendPathModel(
  http: 'v3/users/settings/new-phone-number/validate',
  socket: 'v3.accounts.settings.newPhoneNumber.check',
);
const updatePhoneNumberPath = BackendPathModel(
  http: 'v3/users/settings/phone-number',
  socket: 'v3.accounts.settings.phoneNumber.post',
);
