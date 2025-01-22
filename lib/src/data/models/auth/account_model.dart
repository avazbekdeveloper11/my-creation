class AccountModel {
  AccountModel({
    this.id,
    this.login,
    this.gender,
    this.age,
    this.level,
    this.firstName,
    this.lastName,
    this.status,
    this.langKey,
    this.createdBy,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.authorities,
    this.profile,
    this.attachments,
    this.tariff,
  });

  AccountModel.fromJson(dynamic json) {
    id = json['id'];
    login = json['login'];
    gender = json['gender'];
    age = json['age'];
    level = json['level'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    status = json['status'];
    langKey = json['langKey'];
    createdBy = json['createdBy'];
    lastModifiedBy = json['lastModifiedBy'];
    lastModifiedDate = json['lastModifiedDate'];
    authorities = json['authorities'] != null ? json['authorities'].cast<String>() : [];
    profile = json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    if (json['attachments'] != null) {
      attachments = [];
      json['attachments'].forEach((v) {
        attachments?.add(Attachments.fromJson(v));
      });
    }
    tariff = json['tariff'] != null ? Tariff.fromJson(json['tariff']) : null;
  }
  String? id;
  String? login;
  String? gender;
  num? age;
  String? level;
  String? firstName;
  String? lastName;
  String? status;
  String? langKey;
  String? createdBy;
  String? lastModifiedBy;
  String? lastModifiedDate;
  List<String>? authorities;
  Profile? profile;
  List<Attachments>? attachments;
  Tariff? tariff;
  AccountModel copyWith({
    String? id,
    String? login,
    String? gender,
    num? age,
    String? level,
    String? firstName,
    String? lastName,
    String? status,
    String? langKey,
    String? createdBy,
    String? lastModifiedBy,
    String? lastModifiedDate,
    List<String>? authorities,
    Profile? profile,
    List<Attachments>? attachments,
    Tariff? tariff,
  }) =>
      AccountModel(
        id: id ?? this.id,
        login: login ?? this.login,
        gender: gender ?? this.gender,
        age: age ?? this.age,
        level: level ?? this.level,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        status: status ?? this.status,
        langKey: langKey ?? this.langKey,
        createdBy: createdBy ?? this.createdBy,
        lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
        lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
        authorities: authorities ?? this.authorities,
        profile: profile ?? this.profile,
        attachments: attachments ?? this.attachments,
        tariff: tariff ?? this.tariff,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['login'] = login;
    map['gender'] = gender;
    map['age'] = age;
    map['level'] = level;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['status'] = status;
    map['langKey'] = langKey;
    map['createdBy'] = createdBy;
    map['lastModifiedBy'] = lastModifiedBy;
    map['lastModifiedDate'] = lastModifiedDate;
    map['authorities'] = authorities;
    if (profile != null) {
      map['profile'] = profile?.toJson();
    }
    if (attachments != null) {
      map['attachments'] = attachments?.map((v) => v.toJson()).toList();
    }
    if (tariff != null) {
      map['tariff'] = tariff?.toJson();
    }
    return map;
  }
}

class Tariff {
  Tariff({
    this.id,
    this.name,
    this.amount,
    this.intervalPeriod,
    this.description,
  });

  Tariff.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    amount = json['amount'];
    intervalPeriod = json['intervalPeriod'];
    description = json['description'];
  }
  String? id;
  String? name;
  num? amount;
  String? intervalPeriod;
  String? description;
  Tariff copyWith({
    String? id,
    String? name,
    num? amount,
    String? intervalPeriod,
    String? description,
  }) =>
      Tariff(
        id: id ?? this.id,
        name: name ?? this.name,
        amount: amount ?? this.amount,
        intervalPeriod: intervalPeriod ?? this.intervalPeriod,
        description: description ?? this.description,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['amount'] = amount;
    map['intervalPeriod'] = intervalPeriod;
    map['description'] = description;
    return map;
  }
}

class Attachments {
  Attachments({
    this.id,
    this.orderNumber,
    this.fileKey,
    this.state,
    this.status,
    this.storageUrl,
    this.fileType,
    this.key,
  });

  Attachments.fromJson(dynamic json) {
    id = json['id'];
    orderNumber = json['orderNumber'];
    fileKey = json['fileKey'];
    state = json['state'];
    status = json['status'];
    storageUrl = json['storageUrl'];
    fileType = json['fileType'];
    key = json['key'];
  }
  String? id;
  num? orderNumber;
  String? fileKey;
  String? state;
  String? status;
  String? storageUrl;
  String? fileType;
  String? key;
  Attachments copyWith({
    String? id,
    num? orderNumber,
    String? fileKey,
    String? state,
    String? status,
    String? storageUrl,
    String? fileType,
    String? key,
  }) =>
      Attachments(
        id: id ?? this.id,
        orderNumber: orderNumber ?? this.orderNumber,
        fileKey: fileKey ?? this.fileKey,
        state: state ?? this.state,
        status: status ?? this.status,
        storageUrl: storageUrl ?? this.storageUrl,
        fileType: fileType ?? this.fileType,
        key: key ?? this.key,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['orderNumber'] = orderNumber;
    map['fileKey'] = fileKey;
    map['state'] = state;
    map['status'] = status;
    map['storageUrl'] = storageUrl;
    map['fileType'] = fileType;
    map['key'] = key;
    return map;
  }
}

class Profile {
  Profile({
    this.id,
    this.name,
    this.viewed,
    this.liked,
  });

  Profile.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    viewed = json['viewed'];
    liked = json['liked'];
  }
  String? id;
  String? name;
  bool? viewed;
  bool? liked;
  Profile copyWith({
    String? id,
    String? name,
    bool? viewed,
    bool? liked,
  }) =>
      Profile(
        id: id ?? this.id,
        name: name ?? this.name,
        viewed: viewed ?? this.viewed,
        liked: liked ?? this.liked,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['viewed'] = viewed;
    map['liked'] = liked;
    return map;
  }
}
