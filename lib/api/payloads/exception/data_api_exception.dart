import 'dart:convert';

class DataApiException {
  DataApiException({
    this.type,
    this.description,
    this.message,
    this.counter,
    this.cooldown,
    this.countdown,
    this.bannedContentEN,
    this.bannedContentTH,
  });

  final String? type;
  final String? description;
  final String? message;
  final int? counter;
  final int? cooldown;
  final int? countdown;
  final String? bannedContentEN;
  final String? bannedContentTH;

  factory DataApiException.fromJson(String str) {
    return DataApiException.fromMap(json.decode(str));
  }

  String toJson() => json.encode(toMap());

  factory DataApiException.fromMap(Map<String, dynamic> data) {
    String msg;
    try {
      msg = json.encode(data['message']);
    } catch (e) {
      msg = data['message'];
    }
    return DataApiException(
      type: data['type'],
      description: data['description'],
      message: msg,
      counter: data['counter'],
      cooldown: data['cooldown'],
      countdown: data['countdown'],
      bannedContentEN: data['EN'],
      bannedContentTH: data['TH'],
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
      'type': type,
      'description': description,
      'message': message,
      'counter': counter,
      'cooldown': cooldown,
      'countdown': countdown,
    };
  }
}
