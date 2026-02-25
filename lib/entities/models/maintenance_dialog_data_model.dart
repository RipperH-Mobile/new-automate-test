import 'dart:convert';

class MaintenanceDialogDataModel {
  MaintenanceDialogDataModel({
    this.isMaintenance,
    this.message,
    this.whitelist,
  });

  final bool? isMaintenance;
  final String? message;

  /// account id
  final List<String>? whitelist;

  String toJson() => json.encode(toMap());

  factory MaintenanceDialogDataModel.fromMap(Map<String, dynamic> data) {
    String msg;
    try {
      msg = json.encode(data['message']);
    } catch (e) {
      msg = data['message'];
    }
    return MaintenanceDialogDataModel(
      isMaintenance: data['isMaintenance'],
      whitelist: data['whitelist'] != null ? List<String>.from(data['whitelist']) : null,
      message: msg,
    );
  }

  String? getMessageData(String key) {
    if (message == null) {
      return null;
    }
    final dataMap = json.decode(message!);
    if (dataMap == null) return null;
    return dataMap[key];
  }

  Map<String, dynamic> toMap() {
    return {
      'isMaintenance': isMaintenance,
      'message': message,
      'whitelist': whitelist,
    };
  }
}
