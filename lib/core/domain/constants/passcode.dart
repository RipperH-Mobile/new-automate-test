// Length of empty passcode is max of can input passcode
const emptyPassCode = <String?>[null, null, null, null, null, null];
const maxIncorrectSteak = 5;
const halfIncorrectSteak = 3;
const startBlockDuration = Duration(minutes: 2);

const passcodeTimeOut = Duration(seconds: 30);
