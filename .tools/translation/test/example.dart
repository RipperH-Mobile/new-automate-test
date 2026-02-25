import 'package:get/get.dart';

mock() {
  'BEGIN 1 Normal key END'.tr;
  'BEGIN 2 Normal key\nLine2 END'.tr;
  'BEGIN 2-1 Key with \' " test test \'t " test test END'.tr;
  'BEGIN 2-2 Key with \' " test test \'t " test test END'.tr;
  'BEGIN 3 Normal key with param @param1 END'.trParams({'param1': 'value1'});
  'BEGIN 4 Normal key with 2 params @param1 @param2 END'.trParams({
    'param1': 'value1',
    'param2': 'value2',
  });
  'BEGIN 5 Normal key with 2 params @param1 @param2 END'.trParams(
    {
      'param1': 'value1',
      'param2': 'value2',
    },
  );
  print('${'BEGIN 6-1 Norm\'al key'.tr} two keys ${'BEGIN 6-2 Normal key2'.tr}');
  print('${'BEGIN 7-1 Norm\'al key'.tr} two keys ${'BEGIN 7-2 Nor"mal key2\n'
      "\ntest test".tr}');

  'BEGIN 8 Normal key'.tr;
  'BEGIN 9 Multi line key'
          ', line 2'
          ', line 3 END'
      .tr;
  'BEGIN 10 Multi line key2 with back n\n'
          ', line 2\n'
          ', line 3 END'
      .tr;

  'BEGIN 11 Multiline key with 2\n'
          '\nparams @param1 @param2 yo END'
      .trParams(
    {
      'param1': 'value1',
      'param2': 'value2',
    },
  );

  '${'BEGIN 12-1 Normal key END'.tr} two keys ${'BEGIN 12-2 Normal key2 END'.tr}';
  '${'BEGIN 13-1 Nor\'mal key END'.tr} two keys ${'BEGIN 13-2 Nor"mal key2 END'.tr}';
  "'displayName': 'BEGIN 14 Y'''ou''' END'.tr,";

  "'displayName': 'BEGIN 15 Y'''ou END'.tr,";
  "'BEGIN 16 Y'ou END'.tr: 'displayName',";

  // final loopKeys = ['key1', 'key2'];
  // final mapKeys = {'key1': 'value1', 'key2': 'value2'};

  // TrKeys: $loopKeys
  // - key1
  // - key2
  // '10 Loop key $loopKeys'.trParams({'param1': 'value1'});
  //
  // '11 Array key ${loopKeys[0]}'.tr;
  // '12 2 Array keys ${loopKeys[0]} ${loopKeys[1]}'.tr;

  // TrKeys: ${mapKeys['key1']?.camelCase}
  // - KEY1
  // - KEY2
  // '13 Array key ${mapKeys['key1']?.camelCase} (with optional)'.tr;
  // '14 2 Array key ${mapKeys['key1']?.camelCase}, ${mapKeys['key2']?.camelCase} (with optional)'.tr;
  //
  // print('${'15-1 Normal key ${mapKeys['key1']?.camelCase}'.tr} two keys ${'15-2 Normal key2'.tr}');
}
