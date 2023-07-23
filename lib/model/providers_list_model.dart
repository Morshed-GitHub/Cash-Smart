import 'package:flutter/material.dart';

class ProvidersListModel {
  bool? success;
  String? message;
  List<Data>? data;

  ProvidersListModel({this.success, this.message, this.data});

  ProvidersListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    debugPrint("fromJson called");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? uuid;
  String? providerUuid;
  String? consumerUuid;
  String? accountNumber;
  int? percentage;
  String? startDate;
  int? authId;
  String? createdAt;
  String? updatedAt;
  Consumer? consumer;
  Provider? provider;

  Data(
      {this.id,
      this.uuid,
      this.providerUuid,
      this.consumerUuid,
      this.accountNumber,
      this.percentage,
      this.startDate,
      this.authId,
      this.createdAt,
      this.updatedAt,
      this.consumer,
      this.provider});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    providerUuid = json['provider_uuid'];
    consumerUuid = json['consumer_uuid'];
    accountNumber = json['account_number'];
    percentage = json['percentage'];
    startDate = json['start_date'];
    authId = json['auth_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    consumer = json['consumer'] != null
        ? new Consumer.fromJson(json['consumer'])
        : null;
    provider = json['provider'] != null
        ? new Provider.fromJson(json['provider'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['provider_uuid'] = this.providerUuid;
    data['consumer_uuid'] = this.consumerUuid;
    data['account_number'] = this.accountNumber;
    data['percentage'] = this.percentage;
    data['start_date'] = this.startDate;
    data['auth_id'] = this.authId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.consumer != null) {
      data['consumer'] = this.consumer!.toJson();
    }
    if (this.provider != null) {
      data['provider'] = this.provider!.toJson();
    }
    return data;
  }
}

class Consumer {
  String? uuid;
  String? businessName;
  String? vatNo;
  String? regNo;
  String? idNo;
  String? type;
  String? email;
  String? phone;
  String? note;

  Consumer(
      {this.uuid,
      this.businessName,
      this.vatNo,
      this.regNo,
      this.idNo,
      this.type,
      this.email,
      this.phone,
      this.note});

  Consumer.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    businessName = json['business_name'];
    vatNo = json['vat_no'];
    regNo = json['reg_no'];
    idNo = json['id_no'];
    type = json['type'];
    email = json['email'];
    phone = json['phone'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['business_name'] = this.businessName;
    data['vat_no'] = this.vatNo;
    data['reg_no'] = this.regNo;
    data['id_no'] = this.idNo;
    data['type'] = this.type;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['note'] = this.note;
    return data;
  }
}

class Provider {
  String? uuid;
  String? businessName;
  Null categoryId;
  String? vatNo;
  String? regNo;
  String? idNo;
  String? type;
  String? email;
  String? phone;
  String? note;
  String? webLink;
  int? highlight;
  String? category;
  Null keyword;
  String? imagePath;
  String? backgroundImagePath;
  File? file;

  Provider(
      {this.uuid,
      this.businessName,
      this.categoryId,
      this.vatNo,
      this.regNo,
      this.idNo,
      this.type,
      this.email,
      this.phone,
      this.note,
      this.webLink,
      this.highlight,
      this.category,
      this.keyword,
      this.imagePath,
      this.backgroundImagePath,
      this.file});

  Provider.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    businessName = json['business_name'];
    categoryId = json['category_id'];
    vatNo = json['vat_no'];
    regNo = json['reg_no'];
    idNo = json['id_no'];
    type = json['type'];
    email = json['email'];
    phone = json['phone'];
    note = json['note'];
    webLink = json['web_link'];
    highlight = json['highlight'];
    category = json['category'];
    keyword = json['keyword'];
    imagePath = json['image_path'];
    backgroundImagePath = json['background_image_path'];
    file = json['file'] != null ? new File.fromJson(json['file']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['business_name'] = this.businessName;
    data['category_id'] = this.categoryId;
    data['vat_no'] = this.vatNo;
    data['reg_no'] = this.regNo;
    data['id_no'] = this.idNo;
    data['type'] = this.type;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['note'] = this.note;
    data['web_link'] = this.webLink;
    data['highlight'] = this.highlight;
    data['category'] = this.category;
    data['keyword'] = this.keyword;
    data['image_path'] = this.imagePath;
    data['background_image_path'] = this.backgroundImagePath;
    if (this.file != null) {
      data['file'] = this.file!.toJson();
    }
    return data;
  }
}

class File {
  int? id;
  String? uuid;
  String? name;
  String? extension;
  String? creatorUuid;
  String? createdAt;
  String? updatedAt;
  String? backgroundImage;

  File(
      {this.id,
      this.uuid,
      this.name,
      this.extension,
      this.creatorUuid,
      this.createdAt,
      this.updatedAt,
      this.backgroundImage});

  File.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    name = json['name'];
    extension = json['extension'];
    creatorUuid = json['creator_uuid'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    backgroundImage = json['background_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['name'] = this.name;
    data['extension'] = this.extension;
    data['creator_uuid'] = this.creatorUuid;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['background_image'] = this.backgroundImage;
    return data;
  }
}
