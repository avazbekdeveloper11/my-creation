import 'package:sovchilar_mobile/src/data/models/home/user_model.dart';

class AccountsModel {
  AccountsModel({
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
    this.devices,
    this.attachments,
  });

  AccountsModel.fromJson(dynamic json) {
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
    profile = json['profile'] != null ? LikeProfile.fromJson(json['profile']) : null;
    if (json['devices'] != null) {
      devices = [];
      json['devices'].forEach((v) {
        devices?.add(Devices.fromJson(v));
      });
    }
    if (json['attachments'] != null) {
      attachments = [];
      json['attachments'].forEach((v) {
        attachments?.add(LikeAttachments.fromJson(v));
      });
    }
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
  LikeProfile? profile;
  List<Devices>? devices;
  List<LikeAttachments>? attachments;

  AccountsModel copyWith({
    String? id,
    String? login,
    String? gender,
    num? age,
    String? level,
    String? firstName,
    String? lastName,
    String? status,
    dynamic softBlockedDate,
    String? langKey,
    String? createdBy,
    dynamic createdDate,
    String? lastModifiedBy,
    String? lastModifiedDate,
    List<String>? authorities,
    LikeProfile? profile,
    List<Devices>? devices,
    dynamic images,
    List<LikeAttachments>? attachments,
  }) =>
      AccountsModel(
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
        devices: devices ?? this.devices,
        attachments: attachments ?? this.attachments,
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
    if (devices != null) {
      map['devices'] = devices?.map((v) => v.toJson()).toList();
    }
    if (attachments != null) {
      map['attachments'] = attachments?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class LikeAttachments {
  LikeAttachments({
    this.id,
    this.fileKey,
    this.state,
    this.status,
    this.storageUrl,
    this.fileType,
  });

  LikeAttachments.fromJson(dynamic json) {
    id = json['id'];
    fileKey = json['fileKey'];
    state = json['state'];
    status = json['status'];
    storageUrl = json['storageUrl'];
    fileType = json['fileType'];
  }

  String? id;
  String? fileKey;
  String? state;
  String? status;
  String? storageUrl;
  String? fileType;

  LikeAttachments copyWith({
    String? id,
    String? fileKey,
    String? state,
    String? status,
    String? storageUrl,
    String? fileType,
  }) =>
      LikeAttachments(
        id: id ?? this.id,
        fileKey: fileKey ?? this.fileKey,
        state: state ?? this.state,
        status: status ?? this.status,
        storageUrl: storageUrl ?? this.storageUrl,
        fileType: fileType ?? this.fileType,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['fileKey'] = fileKey;
    map['state'] = state;
    map['status'] = status;
    map['storageUrl'] = storageUrl;
    map['fileType'] = fileType;
    return map;
  }
}

class LikeUsers {
  LikeUsers({
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
    this.devices,
    this.attachments,
  });

  LikeUsers.fromJson(dynamic json) {
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
    profile = json['profile'] != null ? LikeProfile.fromJson(json['profile']) : null;
    if (json['devices'] != null) {
      devices = [];
      json['devices'].forEach((v) {
        devices?.add(Devices.fromJson(v));
      });
    }
    if (json['attachments'] != null) {
      attachments = [];
      json['attachments'].forEach((v) {
        attachments?.add(LikeAttachments.fromJson(v));
      });
    }
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
  LikeProfile? profile;
  List<Devices>? devices;
  List<LikeAttachments>? attachments;

  LikeUsers copyWith({
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
    LikeProfile? profile,
    List<Devices>? devices,
    List<LikeAttachments>? attachments,
  }) =>
      LikeUsers(
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
        devices: devices ?? this.devices,
        attachments: attachments ?? this.attachments,
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
    if (devices != null) {
      map['devices'] = devices?.map((v) => v.toJson()).toList();
    }
    if (attachments != null) {
      map['attachments'] = attachments?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class LikeProfile {
  LikeProfile({
    this.id,
    this.name,
    this.viewed,
    this.liked,
  });

  LikeProfile.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    viewed = json['viewed'];
    liked = json['liked'];
  }

  String? id;
  String? name;
  bool? viewed;
  bool? liked;

  LikeProfile copyWith({
    String? id,
    String? name,
    bool? viewed,
    bool? liked,
  }) =>
      LikeProfile(
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
