// ignore_for_file: must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/data/models/image/image_model.dart';

import '../profile/profile_model.dart';

class UserModel extends Equatable {
  UserModel({
    this.id,
    this.name,
    this.user,
    this.height,
    this.weight,
    this.education,
    this.profession,
    this.workPlace,
    this.isHealthy,
    this.healthIssues,
    this.dateOfBirth,
    this.placeOfBirth,
    this.dwellingPlace,
    this.maritalStatus,
    this.childPlanInFuture,
    this.numOfMembersInFamily,
    this.numOfChildrenInFamily,
    this.birthPositionInFamily,
    this.ownDwelling,
    this.viewed,
    this.liked,
    this.skills,
    this.bio,
    this.requirements,
    this.profileState,
    this.location,
    this.discoverability,
    this.nationality,
    this.genderTags,
    this.attachments,
    this.actionTrackers,
    this.likes,
    this.profilePictureType,
    this.sharedWithUsers,
    this.knowledgeOfLanguages,
  });

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    height = json['height'];
    weight = json['weight'];
    education = json['education'];
    profession = json['profession'];
    workPlace = json['workPlace'];
    isHealthy = json['isHealthy'];
    healthIssues = json['healthIssues'];
    dateOfBirth = json['dateOfBirth'];
    placeOfBirth = json['placeOfBirth'] != null ? PlaceOfBirth.fromJson(json['placeOfBirth']) : null;
    dwellingPlace = json['dwellingPlace'] != null ? PlaceOfBirth.fromJson(json['dwellingPlace']) : null;
    maritalStatus = json['maritalStatus'];
    childPlanInFuture = json['childPlanInFuture'];
    numOfMembersInFamily = json['numOfMembersInFamily'];
    numOfChildrenInFamily = json['numOfChildrenInFamily'];
    birthPositionInFamily = json['birthPositionInFamily'];
    ownDwelling = json['ownDwelling'];

    viewed = json['viewed'];
    liked = json['liked'];
    skills = json['skills'];
    bio = json['bio'];
    requirements = json['requirements'];
    profileState = json['profileState'];
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    discoverability = json['discoverability'];
    nationality = json['nationality'] != null ? Nationality.fromJson(json['nationality']) : null;
    if (json['genderTags'] != null) {
      genderTags = [];
      json['genderTags'].forEach((v) {
        genderTags?.add(GenderTags.fromJson(v));
      });
    }
    if (json['attachments'] != null) {
      attachments = [];
      json['attachments'].forEach((v) {
        attachments?.add(Attachments.fromJson(v));
      });
    }
    if (json['actionTrackers'] != null) {
      actionTrackers = [];
      json['actionTrackers'].forEach((v) {
        actionTrackers?.add(ActionTrackers.fromJson(v));
      });
    }
    if (json['likes'] != null) {
      likes = [];
      json['likes'].forEach((v) {
        likes?.add(v);
      });
    }

    profilePictureType = json['profilePictureType'];
    if (json['sharedWithUsers'] != null) {
      sharedWithUsers = [];
      json['sharedWithUsers'].forEach((v) {
        sharedWithUsers?.add(v);
      });
    }

    if (json['knowledgeOfLanguages'] != null) {
      knowledgeOfLanguages = [];
      json['knowledgeOfLanguages'].forEach((v) {
        knowledgeOfLanguages?.add(v);
      });
    }
  }

  String? id;
  String? name;
  User? user;
  num? height;
  num? weight;
  String? education;
  String? profession;
  String? workPlace;
  bool? isHealthy;
  String? healthIssues;
  String? dateOfBirth;
  PlaceOfBirth? placeOfBirth;
  PlaceOfBirth? dwellingPlace;
  String? maritalStatus;
  String? childPlanInFuture;
  num? numOfMembersInFamily;
  num? numOfChildrenInFamily;
  num? birthPositionInFamily;
  dynamic ownDwelling;
  bool? viewed;
  bool? liked;
  String? skills;
  String? bio;
  String? requirements;
  String? profileState;
  Location? location;
  dynamic discoverability;
  Nationality? nationality;
  List<GenderTags>? genderTags;
  List<Attachments>? attachments;
  List<ActionTrackers>? actionTrackers;
  List<dynamic>? likes;
  String? profilePictureType;
  List<String>? sharedWithUsers;
  List<String>? knowledgeOfLanguages;

  UserModel copyWith({
    String? id,
    dynamic code,
    String? name,
    User? user,
    num? height,
    num? weight,
    String? education,
    String? profession,
    String? workPlace,
    bool? isHealthy,
    String? healthIssues,
    String? dateOfBirth,
    PlaceOfBirth? placeOfBirth,
    PlaceOfBirth? dwellingPlace,
    String? maritalStatus,
    String? childPlanInFuture,
    num? numOfMembersInFamily,
    num? numOfChildrenInFamily,
    num? birthPositionInFamily,
    dynamic ownDwelling,
    bool? viewed,
    bool? liked,
    String? skills,
    String? bio,
    String? requirements,
    String? profileState,
    Location? location,
    dynamic discoverability,
    Nationality? nationality,
    List<GenderTags>? genderTags,
    List<Attachments>? attachments,
    List<ActionTrackers>? actionTrackers,
    List<dynamic>? likes,
    String? profilePictureType,
    List<String>? sharedWithUsers,
    List<String>? knowledgeOfLanguages,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        user: user ?? this.user,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        education: education ?? this.education,
        profession: profession ?? this.profession,
        workPlace: workPlace ?? this.workPlace,
        isHealthy: isHealthy ?? this.isHealthy,
        healthIssues: healthIssues ?? this.healthIssues,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        placeOfBirth: placeOfBirth ?? this.placeOfBirth,
        dwellingPlace: dwellingPlace ?? this.dwellingPlace,
        maritalStatus: maritalStatus ?? this.maritalStatus,
        childPlanInFuture: childPlanInFuture ?? this.childPlanInFuture,
        numOfMembersInFamily: numOfMembersInFamily ?? this.numOfMembersInFamily,
        numOfChildrenInFamily: numOfChildrenInFamily ?? this.numOfChildrenInFamily,
        birthPositionInFamily: birthPositionInFamily ?? this.birthPositionInFamily,
        ownDwelling: ownDwelling ?? this.ownDwelling,
        viewed: viewed ?? this.viewed,
        liked: liked ?? this.liked,
        skills: skills ?? this.skills,
        bio: bio ?? this.bio,
        requirements: requirements ?? this.requirements,
        profileState: profileState ?? this.profileState,
        location: location ?? this.location,
        discoverability: discoverability ?? this.discoverability,
        nationality: nationality ?? this.nationality,
        genderTags: genderTags ?? this.genderTags,
        attachments: attachments ?? this.attachments,
        actionTrackers: actionTrackers ?? this.actionTrackers,
        likes: likes ?? this.likes,
        profilePictureType: profilePictureType ?? this.profilePictureType,
        sharedWithUsers: sharedWithUsers ?? this.sharedWithUsers,
        knowledgeOfLanguages: knowledgeOfLanguages ?? this.knowledgeOfLanguages,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['height'] = height;
    map['weight'] = weight;
    map['education'] = education;
    map['profession'] = profession;
    map['workPlace'] = workPlace;
    map['isHealthy'] = isHealthy;
    map['healthIssues'] = healthIssues;
    map['dateOfBirth'] = dateOfBirth;
    if (placeOfBirth != null) {
      map['placeOfBirth'] = placeOfBirth?.toJson();
    }
    if (dwellingPlace != null) {
      map['dwellingPlace'] = dwellingPlace?.toJson();
    }
    map['maritalStatus'] = maritalStatus;
    map['childPlanInFuture'] = childPlanInFuture;
    map['numOfMembersInFamily'] = numOfMembersInFamily;
    map['numOfChildrenInFamily'] = numOfChildrenInFamily;
    map['birthPositionInFamily'] = birthPositionInFamily;
    map['ownDwelling'] = ownDwelling;
    map['viewed'] = viewed;
    map['liked'] = liked;
    map['skills'] = skills;
    map['bio'] = bio;
    map['requirements'] = requirements;
    map['profileState'] = profileState;
    if (location != null) {
      map['location'] = location?.toJson();
    }
    map['discoverability'] = discoverability;
    if (nationality != null) {
      map['nationality'] = nationality?.toJson();
    }
    if (genderTags != null) {
      map['genderTags'] = genderTags?.map((v) => v.toJson()).toList();
    }
    if (attachments != null) {
      map['attachments'] = attachments?.map((v) => v.toJson()).toList();
    }
    if (actionTrackers != null) {
      map['actionTrackers'] = actionTrackers?.map((v) => v.toJson()).toList();
    }
    if (likes != null) {
      map['likes'] = likes?.map((v) => v.toJson()).toList();
    }
    map['profilePictureType'] = profilePictureType;
    if (sharedWithUsers != null) {
      map['sharedWithUsers'] = sharedWithUsers?.map((v) => v).toList();
    }
    return map;
  }

  @override
  List<Object?> get props => [
        id,
        name,
        user,
        height,
        weight,
        education,
        profession,
        workPlace,
        isHealthy,
        healthIssues,
        dateOfBirth,
        placeOfBirth,
        dwellingPlace,
        maritalStatus,
        childPlanInFuture,
        numOfMembersInFamily,
        numOfChildrenInFamily,
        birthPositionInFamily,
        ownDwelling,
        viewed,
      ];
}

class ActionTrackers extends Equatable {
  ActionTrackers({
    this.id,
    this.model,
    this.type,
    this.createdAt,
    this.createdBy,
  });

  ActionTrackers.fromJson(dynamic json) {
    id = json['id'];
    model = json['model'];
    type = json['type'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
  }

  String? id;
  String? model;
  String? type;
  String? createdAt;
  String? createdBy;

  ActionTrackers copyWith({
    String? id,
    String? model,
    String? type,
    String? createdAt,
    String? createdBy,
  }) =>
      ActionTrackers(
        id: id ?? this.id,
        model: model ?? this.model,
        type: type ?? this.type,
        createdAt: createdAt ?? this.createdAt,
        createdBy: createdBy ?? this.createdBy,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['model'] = model;
    map['type'] = type;
    map['createdAt'] = createdAt;
    map['createdBy'] = createdBy;
    return map;
  }

  @override
  List<Object?> get props => [id, model, type, createdAt, createdBy];
}

class Nationality extends Equatable {
  Nationality({
    this.id,
    this.name,
    this.localization,
    this.ord,
    this.state,
  });

  Nationality.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    localization = json['localization'] != null ? LocalizationLanguage.fromJson(json['localization']) : null;
    ord = json['ord'];
    state = json['state'];
  }

  String? id;
  String? name;
  LocalizationLanguage? localization;
  num? ord;
  String? state;

  Nationality copyWith({
    String? id,
    String? name,
    LocalizationLanguage? localization,
    num? ord,
    String? state,
  }) =>
      Nationality(
        id: id ?? this.id,
        name: name ?? this.name,
        localization: localization ?? this.localization,
        ord: ord ?? this.ord,
        state: state ?? this.state,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['localization'] = localization;
    map['ord'] = ord;
    map['state'] = state;
    return map;
  }

  @override
  List<Object?> get props => [id, name, localization, ord, state];
}

class Location extends Equatable {
  Location({
    this.id,
    this.lat,
    this.lon,
    this.ord,
    this.state,
  });

  Location.fromJson(dynamic json) {
    id = json['id'];
    lat = json['lat'];
    lon = json['lon'];
    ord = json['ord'];
    state = json['state'];
  }

  String? id;
  num? lat;
  num? lon;
  num? ord;
  String? state;

  Location copyWith({
    String? id,
    num? lat,
    num? lon,
    num? ord,
    String? state,
  }) =>
      Location(
        id: id ?? this.id,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        ord: ord ?? this.ord,
        state: state ?? this.state,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['lat'] = lat;
    map['lon'] = lon;
    map['ord'] = ord;
    map['state'] = state;
    return map;
  }

  @override
  List<Object?> get props => [id, lat, lon, ord, state];
}

class PlaceOfBirth extends Equatable {
  PlaceOfBirth({
    this.id,
    this.name,
    this.children,
    this.localization,
  });

  PlaceOfBirth.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    children;

    if (json['children'] != null) {
      children =
          (json['children'] as List<dynamic>?)?.map((e) => PlaceOfBirth.fromJson(e as Map<String, dynamic>)).toList();
    }
    localization = json['localization'] != null ? LocalizationLanguage.fromJson(json['localization']) : null;
  }

  String? id;
  String? name;
  List<PlaceOfBirth>? children;
  LocalizationLanguage? localization;

  PlaceOfBirth copyWith({
    String? id,
    String? name,
    List<PlaceOfBirth>? children,
    LocalizationLanguage? localization,
  }) =>
      PlaceOfBirth(
        id: id ?? this.id,
        name: name ?? this.name,
        children: children ?? this.children,
        localization: localization ?? this.localization,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['children'] = children;
    map['localization'] = localization;
    return map;
  }

  @override
  List<Object?> get props => [id, name, children, localization];
}

class User extends Equatable {
  User({
    this.id,
    this.login,
    this.gender,
    this.age,
    this.level,
    this.firstName,
    this.lastName,
    this.status,
    // this.softBlockedDate,
    this.langKey,
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.authorities,
    this.profile,
    this.devices,
    this.images,
    this.attachments,
    this.reports,
  });

  User.fromJson(dynamic json) {
    id = json['id'];
    login = json['login'];
    gender = json['gender'];
    age = json['age'];
    level = json['level'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    status = json['status'];
    // softBlockedDate = json['softBlockedDate'];
    langKey = json['langKey'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    lastModifiedBy = json['lastModifiedBy'];
    lastModifiedDate = json['lastModifiedDate'];
    authorities = json['authorities'] != null ? json['authorities'].cast<String>() : [];
    profile = json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    if (json['devices'] != null) {
      devices = [];
      json['devices'].forEach((v) {
        devices?.add(Devices.fromJson(v));
      });
    }
    images = json['images'];
    if (json['attachments'] != null) {
      attachments = [];
      json['attachments'].forEach((v) {
        attachments?.add(Attachments.fromJson(v));
      });
    }
    if (json['reports'] != null) {
      reports = [];
      json['reports'].forEach((v) {
        reports?.add(Reports.fromJson(v));
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

  // dynamic softBlockedDate;
  String? langKey;
  String? createdBy;
  String? createdDate;
  String? lastModifiedBy;
  String? lastModifiedDate;
  List<String>? authorities;
  Profile? profile;
  List<Devices>? devices;
  List<ImageModel>? images;
  List<Attachments>? attachments;
  List<Reports>? reports;

  User copyWith({
    String? id,
    String? login,
    String? gender,
    num? age,
    String? level,
    String? firstName,
    String? lastName,
    String? status,
    // dynamic softBlockedDate,
    String? langKey,
    String? createdBy,
    String? createdDate,
    String? lastModifiedBy,
    String? lastModifiedDate,
    List<String>? authorities,
    Profile? profile,
    List<Devices>? devices,
    List<ImageModel>? images,
    List<Attachments>? attachments,
    List<Reports>? reports,
  }) =>
      User(
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
    // map['softBlockedDate'] = softBlockedDate;
    map['langKey'] = langKey;
    map['createdBy'] = createdBy;
    map['createdDate'] = createdDate;
    map['lastModifiedBy'] = lastModifiedBy;
    map['lastModifiedDate'] = lastModifiedDate;
    map['authorities'] = authorities;
    if (profile != null) {
      map['profile'] = profile?.toJson();
    }
    if (devices != null) {
      map['devices'] = devices?.map((v) => v.toJson()).toList();
    }
    map['images'] = images;
    if (attachments != null) {
      map['attachments'] = attachments?.map((v) => v.toJson()).toList();
    }
    if (reports != null) {
      map['reports'] = reports?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  List<Object?> get props => [
        id,
        login,
        gender,
        age,
        level,
        firstName,
        lastName,
        status,
        // softBlockedDate,
        langKey,
        createdBy,
        createdDate,
        lastModifiedBy,
        lastModifiedDate,
        authorities,
        profile,
        devices,
        images,
        attachments,
        reports,
      ];
}

class Devices extends Equatable {
  Devices({
    this.id,
    this.deviceId,
    this.deviceName,
    this.deviceType,
    this.deviceOsVersion,
    this.firebaseToken,
    this.users,
  });

  Devices.fromJson(dynamic json) {
    id = json['id'];
    deviceId = json['deviceId'];
    deviceName = json['deviceName'];
    deviceType = json['deviceType'];
    deviceOsVersion = json['deviceOsVersion'];
    firebaseToken = json['firebaseToken'];
    users = json['users'];
  }

  String? id;
  String? deviceId;
  String? deviceName;
  String? deviceType;
  String? deviceOsVersion;
  String? firebaseToken;
  dynamic users;

  Devices copyWith({
    String? id,
    String? deviceId,
    String? deviceName,
    String? deviceType,
    String? deviceOsVersion,
    String? firebaseToken,
    dynamic users,
  }) =>
      Devices(
        id: id ?? this.id,
        deviceId: deviceId ?? this.deviceId,
        deviceName: deviceName ?? this.deviceName,
        deviceType: deviceType ?? this.deviceType,
        deviceOsVersion: deviceOsVersion ?? this.deviceOsVersion,
        firebaseToken: firebaseToken ?? this.firebaseToken,
        users: users ?? this.users,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['deviceId'] = deviceId;
    map['deviceName'] = deviceName;
    map['deviceType'] = deviceType;
    map['deviceOsVersion'] = deviceOsVersion;
    map['firebaseToken'] = firebaseToken;
    map['users'] = users;
    return map;
  }

  @override
  List<Object?> get props => [
        id,
        deviceId,
        deviceName,
        deviceType,
        deviceOsVersion,
        firebaseToken,
        users,
      ];
}

class Profile extends Equatable {
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

  @override
  List<Object?> get props => [
        id,
        name,
        viewed,
        liked,
      ];
}

class Reports extends Equatable {
  Reports({
    this.id,
    this.message,
    this.type,
    this.target,
    this.createdBy,
    this.createdAt,
    this.users,
    this.localization,
  });

  Reports.fromJson(dynamic json) {
    id = json['id'];
    message = json['message'];
    type = json['type'];
    target = json['target'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    users = json['users'];
    localization = json['localization'];
  }

  String? id;
  String? message;
  String? type;
  String? target;
  String? createdBy;
  String? createdAt;
  dynamic users;
  dynamic localization;

  Reports copyWith({
    String? id,
    String? message,
    String? type,
    String? target,
    String? createdBy,
    String? createdAt,
    dynamic users,
    dynamic localization,
  }) =>
      Reports(
        id: id ?? this.id,
        message: message ?? this.message,
        type: type ?? this.type,
        target: target ?? this.target,
        createdBy: createdBy ?? this.createdBy,
        createdAt: createdAt ?? this.createdAt,
        users: users ?? this.users,
        localization: localization ?? this.localization,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['message'] = message;
    map['type'] = type;
    map['target'] = target;
    map['createdBy'] = createdBy;
    map['createdAt'] = createdAt;
    map['users'] = users;
    map['localization'] = localization;
    return map;
  }

  @override
  List<Object?> get props => [
        id,
        message,
        type,
        target,
        createdBy,
        createdAt,
        users,
        localization,
      ];
}

class GenderTags extends Equatable {
  GenderTags({
    this.id,
    this.hashtag,
    this.gender,
    this.state,
    this.localization,
  });

  GenderTags.fromJson(dynamic json) {
    id = json['id'];
    hashtag = json['hashtag'];
    gender = json['gender'];
    state = json['state'];
    localization = json['localization'] != null ? LocalizationLanguage.fromJson(json['localization']) : null;
  }

  String? id;
  String? hashtag;
  String? gender;
  String? state;
  LocalizationLanguage? localization;

  GenderTags copyWith({
    String? id,
    String? hashtag,
    String? gender,
    String? state,
    LocalizationLanguage? localization,
  }) =>
      GenderTags(
        id: id ?? this.id,
        hashtag: hashtag ?? this.hashtag,
        gender: gender ?? this.gender,
        state: state ?? this.state,
        localization: localization ?? this.localization,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['hashtag'] = hashtag;
    map['gender'] = gender;
    map['state'] = state;
    map['localization'] = localization?.toJson();
    return map;
  }

  @override
  List<Object?> get props => [
        id,
        hashtag,
        gender,
        state,
        localization,
      ];
}

class LocalizationLanguage extends Equatable {
  LocalizationLanguage({
    this.uzcyril,
    this.en,
    this.uzlatin,
    this.ru,
  });

  LocalizationLanguage.fromJson(dynamic json) {
    uzcyril = json['UZ_CYRIL'];
    en = json['EN'];
    uzlatin = json['UZ_LATIN'];
    ru = json['RU'];
  }

  String? uzcyril;
  String? en;
  String? uzlatin;
  String? ru;

  String get localizedValue => switch (localSource.locale) {
        'ru' => ru ?? '',
        'oz' => uzcyril ?? '',
        'uz' => uzlatin ?? '',
        _ => uzlatin ?? '',
      };

  LocalizationLanguage copyWith({
    String? uzcyril,
    String? en,
    String? uzlatin,
    String? ru,
  }) =>
      LocalizationLanguage(
        uzcyril: uzcyril ?? this.uzcyril,
        en: en ?? this.en,
        uzlatin: uzlatin ?? this.uzlatin,
        ru: ru ?? this.ru,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['UZ_CYRIL'] = uzcyril;
    map['EN'] = en;
    map['UZ_LATIN'] = uzlatin;
    map['RU'] = ru;
    return map;
  }

  @override
  List<Object?> get props => [uzcyril, en, uzlatin, ru];
}
