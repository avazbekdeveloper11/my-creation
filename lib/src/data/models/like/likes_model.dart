import 'package:sovchilar_mobile/src/data/models/auth/account_model.dart';
import 'package:sovchilar_mobile/src/data/models/home/user_model.dart';

class LikesModel {
  LikesModel({
    this.id,
    this.profile,
    this.likedProfile,
    this.status,
    this.createdDate,
    this.updatedDate,
  });

  LikesModel.fromJson(dynamic json) {
    id = json['id'];
    profile = json['profile'] != null ? LikesProfile.fromJson(json['profile']) : null;
    likedProfile = json['likedProfile'] != null ? LikedProfile.fromJson(json['likedProfile']) : null;
    status = json['status'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  String? id;
  LikesProfile? profile;
  LikedProfile? likedProfile;
  String? status;
  String? createdDate;
  String? updatedDate;

  LikesModel copyWith({
    String? id,
    LikesProfile? profile,
    LikedProfile? likedProfile,
    String? status,
    String? createdDate,
    String? updatedDate,
  }) =>
      LikesModel(
        id: id ?? this.id,
        profile: profile ?? this.profile,
        likedProfile: likedProfile ?? this.likedProfile,
        status: status ?? this.status,
        createdDate: createdDate ?? this.createdDate,
        updatedDate: updatedDate ?? this.updatedDate,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (profile != null) {
      map['profile'] = profile?.toJson();
    }
    if (likedProfile != null) {
      map['likedProfile'] = likedProfile?.toJson();
    }
    map['status'] = status;
    map['createdDate'] = createdDate;
    map['updatedDate'] = updatedDate;
    return map;
  }
}

class LikedProfile {
  LikedProfile({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.code,
    this.name,
    this.status,
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
    this.knowledgeOfLanguages,
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
    this.aboutChildren,
    this.profilePictureType,
    this.sharedWithUsers,
    this.busy,
  });

  LikedProfile.fromJson(dynamic json) {
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    lastModifiedBy = json['lastModifiedBy'];
    lastModifiedDate = json['lastModifiedDate'];
    id = json['id'];
    code = json['code'];
    name = json['name'];
    status = json['status'];
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
    knowledgeOfLanguages = json['knowledgeOfLanguages'] != null ? json['knowledgeOfLanguages'].cast<String>() : [];
    viewed = json['viewed'];
    liked = json['liked'];
    skills = json['skills'];
    bio = json['bio'];
    requirements = json['requirements'];
    profileState = json['profileState'];
    location = json['location'];
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
    aboutChildren = json['aboutChildren'];
    profilePictureType = json['profilePictureType'];
    if (json['sharedWithUsers'] != null) {
      sharedWithUsers = [];
      json['sharedWithUsers'].forEach((v) {
        sharedWithUsers = json['sharedWithUsers'];
      });
    }
    busy = json['busy'];
  }

  dynamic createdBy;
  dynamic createdDate;
  String? lastModifiedBy;
  String? lastModifiedDate;
  String? id;
  dynamic code;
  String? name;
  String? status;
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
  String? ownDwelling;
  List<String>? knowledgeOfLanguages;
  bool? viewed;
  bool? liked;
  String? skills;
  String? bio;
  String? requirements;
  String? profileState;
  dynamic location;
  dynamic discoverability;
  Nationality? nationality;
  List<dynamic>? genderTags;
  List<dynamic>? attachments;
  List<dynamic>? actionTrackers;
  dynamic aboutChildren;
  String? profilePictureType;
  List<dynamic>? sharedWithUsers;
  dynamic busy;

  LikedProfile copyWith({
    dynamic createdBy,
    dynamic createdDate,
    String? lastModifiedBy,
    String? lastModifiedDate,
    String? id,
    dynamic code,
    String? name,
    String? status,
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
    String? ownDwelling,
    List<String>? knowledgeOfLanguages,
    bool? viewed,
    bool? liked,
    String? skills,
    String? bio,
    String? requirements,
    String? profileState,
    dynamic location,
    dynamic discoverability,
    Nationality? nationality,
    List<dynamic>? genderTags,
    List<dynamic>? attachments,
    List<dynamic>? actionTrackers,
    dynamic aboutChildren,
    String? profilePictureType,
    List<dynamic>? sharedWithUsers,
    dynamic busy,
  }) =>
      LikedProfile(
        createdBy: createdBy ?? this.createdBy,
        createdDate: createdDate ?? this.createdDate,
        lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
        lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
        id: id ?? this.id,
        code: code ?? this.code,
        name: name ?? this.name,
        status: status ?? this.status,
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
        knowledgeOfLanguages: knowledgeOfLanguages ?? this.knowledgeOfLanguages,
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
        aboutChildren: aboutChildren ?? this.aboutChildren,
        profilePictureType: profilePictureType ?? this.profilePictureType,
        sharedWithUsers: sharedWithUsers ?? this.sharedWithUsers,
        busy: busy ?? this.busy,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['createdBy'] = createdBy;
    map['createdDate'] = createdDate;
    map['lastModifiedBy'] = lastModifiedBy;
    map['lastModifiedDate'] = lastModifiedDate;
    map['id'] = id;
    map['code'] = code;
    map['name'] = name;
    map['status'] = status;
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
    map['knowledgeOfLanguages'] = knowledgeOfLanguages;
    map['viewed'] = viewed;
    map['liked'] = liked;
    map['skills'] = skills;
    map['bio'] = bio;
    map['requirements'] = requirements;
    map['profileState'] = profileState;
    map['location'] = location;
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
    map['aboutChildren'] = aboutChildren;
    map['profilePictureType'] = profilePictureType;
    if (sharedWithUsers != null) {
      map['sharedWithUsers'] = sharedWithUsers?.map((v) => v.toJson()).toList();
    }
    map['busy'] = busy;
    return map;
  }
}

class LikesUser {
  LikesUser({
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
    // this.tariff,
    // this.tariffExpirationDate,
    // this.dateOfBirth,
  });

  LikesUser.fromJson(dynamic json) {
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
    authorities = json['authorities'];
    profile = json['profile'];
    devices = json['devices'];
    images = json['images'];
    attachments = json['attachments'];
    reports = json['reports'];
    // tariff = json['tariff'];
    // tariffExpirationDate = json['tariffExpirationDate'];
    // dateOfBirth = json['dateOfBirth'];
  }

  String? id;
  String? login;
  String? gender;
  num? age;
  dynamic level;
  dynamic firstName;
  dynamic lastName;
  String? status;
  // dynamic softBlockedDate;
  dynamic langKey;
  dynamic createdBy;
  dynamic createdDate;
  dynamic lastModifiedBy;
  dynamic lastModifiedDate;
  dynamic authorities;
  dynamic profile;
  dynamic devices;
  dynamic images;
  dynamic attachments;
  dynamic reports;

  // dynamic tariff;
  // dynamic tariffExpirationDate;
  // dynamic dateOfBirth;

  User copyWith({
    String? id,
    String? login,
    String? gender,
    num? age,
    dynamic level,
    dynamic firstName,
    dynamic lastName,
    String? status,
    // dynamic softBlockedDate,
    dynamic langKey,
    dynamic createdBy,
    dynamic createdDate,
    dynamic lastModifiedBy,
    dynamic lastModifiedDate,
    dynamic authorities,
    dynamic profile,
    dynamic devices,
    dynamic images,
    dynamic attachments,
    dynamic reports,
    // dynamic tariff,
    // dynamic tariffExpirationDate,
    // dynamic dateOfBirth,
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
        // softBlockedDate: softBlockedDate ?? this.softBlockedDate,
        langKey: langKey ?? this.langKey,
        createdBy: createdBy ?? this.createdBy,
        createdDate: createdDate ?? this.createdDate,
        lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
        lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
        authorities: authorities ?? this.authorities,
        profile: profile ?? this.profile,
        devices: devices ?? this.devices,
        images: images ?? this.images,
        attachments: attachments ?? this.attachments,
        reports: reports ?? this.reports,
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
    map['profile'] = profile;
    map['devices'] = devices;
    map['images'] = images;
    map['attachments'] = attachments;
    map['reports'] = reports;
    // map['tariff'] = tariff;
    // map['tariffExpirationDate'] = tariffExpirationDate;
    // map['dateOfBirth'] = dateOfBirth;
    return map;
  }
}

class LikesProfile {
  LikesProfile({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.code,
    this.name,
    this.status,
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
    this.knowledgeOfLanguages,
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
    this.aboutChildren,
    this.profilePictureType,
    this.sharedWithUsers,
    this.busy,
  });

  LikesProfile.fromJson(dynamic json) {
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    lastModifiedBy = json['lastModifiedBy'];
    lastModifiedDate = json['lastModifiedDate'];
    id = json['id'];
    code = json['code'];
    name = json['name'];
    status = json['status'];
    user = json['user'] != null ? LikesUser.fromJson(json['user']) : null;
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
    knowledgeOfLanguages = json['knowledgeOfLanguages'] != null ? json['knowledgeOfLanguages'].cast<String>() : [];
    viewed = json['viewed'];
    liked = json['liked'];
    skills = json['skills'];
    bio = json['bio'];
    requirements = json['requirements'];
    profileState = json['profileState'];
    location = json['location'];
    discoverability = json['discoverability'];
    nationality = json['nationality'] != null ? Nationality.fromJson(json['nationality']) : null;
    if (json['genderTags'] != null) {
      genderTags = [];
      json['genderTags'].forEach((v) {
        genderTags?.add(GenderTags.fromJson(v));
      });
    }
    // if (json['attachments'] != null) {
    //   attachments = [];
    //   json['attachments'].forEach((v) {
    //     attachments?.add(Dynamic.fromJson(v));
    //   });
    // }
    if (json['actionTrackers'] != null) {
      actionTrackers = [];
      json['actionTrackers'].forEach((v) {
        actionTrackers?.add(ActionTrackers.fromJson(v));
      });
    }
    aboutChildren = json['aboutChildren'];
    profilePictureType = json['profilePictureType'];
    if (json['sharedWithUsers'] != null) {
      sharedWithUsers = [...json['sharedWithUsers']];
    }
    busy = json['busy'];
  }

  dynamic createdBy;
  dynamic createdDate;
  String? lastModifiedBy;
  String? lastModifiedDate;
  String? id;
  dynamic code;
  String? name;
  String? status;
  LikesUser? user;
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
  String? ownDwelling;
  List<String>? knowledgeOfLanguages;
  bool? viewed;
  bool? liked;
  String? skills;
  String? bio;
  String? requirements;
  String? profileState;
  dynamic location;
  dynamic discoverability;
  Nationality? nationality;
  List<GenderTags>? genderTags;
  List<Attachments>? attachments;
  List<ActionTrackers>? actionTrackers;
  dynamic aboutChildren;
  String? profilePictureType;
  List<String>? sharedWithUsers;
  dynamic busy;

  LikesProfile copyWith({
    dynamic createdBy,
    dynamic createdDate,
    String? lastModifiedBy,
    String? lastModifiedDate,
    String? id,
    dynamic code,
    String? name,
    String? status,
    LikesUser? user,
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
    String? ownDwelling,
    List<String>? knowledgeOfLanguages,
    bool? viewed,
    bool? liked,
    String? skills,
    String? bio,
    String? requirements,
    String? profileState,
    dynamic location,
    dynamic discoverability,
    Nationality? nationality,
    List<GenderTags>? genderTags,
    List<Attachments>? attachments,
    List<ActionTrackers>? actionTrackers,
    dynamic aboutChildren,
    String? profilePictureType,
    List<String>? sharedWithUsers,
    dynamic busy,
  }) =>
      LikesProfile(
        createdBy: createdBy ?? this.createdBy,
        createdDate: createdDate ?? this.createdDate,
        lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
        lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
        id: id ?? this.id,
        code: code ?? this.code,
        name: name ?? this.name,
        status: status ?? this.status,
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
        knowledgeOfLanguages: knowledgeOfLanguages ?? this.knowledgeOfLanguages,
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
        aboutChildren: aboutChildren ?? this.aboutChildren,
        profilePictureType: profilePictureType ?? this.profilePictureType,
        sharedWithUsers: sharedWithUsers ?? this.sharedWithUsers,
        busy: busy ?? this.busy,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['createdBy'] = createdBy;
    map['createdDate'] = createdDate;
    map['lastModifiedBy'] = lastModifiedBy;
    map['lastModifiedDate'] = lastModifiedDate;
    map['id'] = id;
    map['code'] = code;
    map['name'] = name;
    map['status'] = status;
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
    map['knowledgeOfLanguages'] = knowledgeOfLanguages;
    map['viewed'] = viewed;
    map['liked'] = liked;
    map['skills'] = skills;
    map['bio'] = bio;
    map['requirements'] = requirements;
    map['profileState'] = profileState;
    map['location'] = location;
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
    map['aboutChildren'] = aboutChildren;
    map['profilePictureType'] = profilePictureType;
    if (sharedWithUsers != null) {
      map['sharedWithUsers'] = sharedWithUsers;
    }
    map['busy'] = busy;
    return map;
  }
}
