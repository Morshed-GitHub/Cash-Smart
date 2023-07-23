class ProviderModel {
  bool? success;
  String? message;
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  Null nextPageUrl;
  String? path;
  int? perPage;
  Null prevPageUrl;
  int? to;
  int? total;

  ProviderModel(
      {this.success,
      this.message,
      this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  ProviderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data {
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
  Cashback? cashback;

  Data(
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
      this.file,
      this.cashback});

  Data.fromJson(Map<String, dynamic> json) {
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
    cashback = json['cashback'] != null
        ? new Cashback.fromJson(json['cashback'])
        : null;
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
    if (this.cashback != null) {
      data['cashback'] = this.cashback!.toJson();
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

class Cashback {
  String? uuid;
  String? providerUuid;
  int? percentage;
  String? startDate;

  Cashback({this.uuid, this.providerUuid, this.percentage, this.startDate});

  Cashback.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    providerUuid = json['provider_uuid'];
    percentage = json['percentage'];
    startDate = json['start_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['provider_uuid'] = this.providerUuid;
    data['percentage'] = this.percentage;
    data['start_date'] = this.startDate;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
