// To parse this JSON data, do
//
//     final device = deviceFromJson(jsonString);

import 'dart:convert';

class Device {
  Device({
    this.userType,
    this.home,
    this.room,
    this.isFavorite: true,
    this.product,
  });

  String userType;
  String home;
  String room;
  String floor;
  bool isFavorite;
  Product product;

  factory Device.fromRawJson(String str) => Device.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        userType: json["userType"],
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "userType": userType,
        "product": product.toJson(),
      };
}

class Product {
  Product({
    this.info,
    this.channels,
    this.automation,
    this.id,
    this.serialNumber,
    this.createdAt,
    this.updatedAt,
    this.status: 'offline',
  });

  Info info;
  List<Channel> channels;
  List<Automation> automation;
  String id;
  String serialNumber;
  DateTime createdAt;
  DateTime updatedAt;
  String status;

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        info: Info.fromJson(json["info"]),
        channels: List<Channel>.from(
            json["channels"].map((x) => Channel.fromJson(x))),
        automation: List<Automation>.from(
            json["automation"].map((x) => Automation.fromJson(x))),
        id: json["_id"],
        serialNumber: json["serialNumber"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "info": info.toJson(),
        "channels": List<dynamic>.from(channels.map((x) => x.toJson())),
        "automation": List<dynamic>.from(automation.map((x) => x.toJson())),
        "_id": id,
        "serialNumber": serialNumber,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class Automation {
  Automation({
    this.startTime,
    this.trigger,
  });

  String startTime;
  List<Trigger> trigger;

  factory Automation.fromRawJson(String str) =>
      Automation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Automation.fromJson(Map<String, dynamic> json) => Automation(
        startTime: json["startTime"],
        trigger:
            List<Trigger>.from(json["trigger"].map((x) => Trigger.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "startTime": startTime,
        "trigger": List<dynamic>.from(trigger.map((x) => x.toJson())),
      };
}

class Trigger {
  Trigger({
    this.topic,
    this.value,
  });

  String topic;
  int value;

  factory Trigger.fromRawJson(String str) => Trigger.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Trigger.fromJson(Map<String, dynamic> json) => Trigger(
        topic: json["topic"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "topic": topic,
        "value": value,
      };
}

class Channel {
  Channel({
    this.channelIndex,
    this.channelName,
    this.topic,
    this.value,
  });

  String channelIndex;
  String channelName;
  String topic;
  String value;

  factory Channel.fromRawJson(String str) => Channel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Channel.fromJson(Map<String, dynamic> json) => Channel(
        channelIndex: json["channelIndex"],
        channelName: json["channelName"],
        topic: json["topic"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "channelIndex": channelIndex,
        "channelName": channelName,
        "topic": topic,
        "value": value,
      };
}

class Info {
  Info({
    this.name,
    this.model,
    this.type,
  });

  String name;
  String model;
  String type;

  factory Info.fromRawJson(String str) => Info.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        name: json["name"],
        model: json["model"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "model": model,
        "type": type,
      };
}
