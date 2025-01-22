// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:sovchilar_mobile/src/data/models/home/user_model.dart';

class ProfileModel extends Equatable {
  ProfileModel({
    // this.createdBy,
    // this.createdDate,
    // this.lastModifiedBy,
    // this.lastModifiedDate,
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
    // this.discoverability,
    this.nationality,
    this.genderTags,
    this.attachments,
    // this.actionTrackers,
    // this.aboutChildren,
    this.profilePictureType,
    this.sharedWithUsers,
    this.photoLimit,
  });

  ProfileModel.fromJson(dynamic json) {
    // createdBy = json['createdBy'];
    // createdDate = json['createdDate'];
    // lastModifiedBy = json['lastModifiedBy'];
    // lastModifiedDate = json['lastModifiedDate'];
    id = json['id'];
    code = json['code'];
    name = json['name'];
    status = json['status'];
    user = json['user'] != null ? UserProfile.fromJson(json['user']) : null;
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
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    // discoverability = json['discoverability'];
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
    // if (json['actionTrackers'] != null) {
    //   actionTrackers = [];
    //   json['actionTrackers'].forEach((v) {
    //     actionTrackers?.add(Dynamic.fromJson(v));
    //   });
    // }
    // if (json['aboutChildren'] != null) {
    //   aboutChildren = [];
    //   json['aboutChildren'].forEach((v) {
    //     aboutChildren?.add(Dynamic.fromJson(v));
    //   });
    // }
    profilePictureType = json['profilePictureType'];
    if (json['sharedWithUsers'] != null) {
      sharedWithUsers = [...json['sharedWithUsers']];
    }
    photoLimit = json['photoLimit'];
  }

  // String? createdBy;
  // String? createdDate;
  // String? lastModifiedBy;
  // String? lastModifiedDate;
  String? id;
  num? code;
  String? name;
  String? status;
  UserProfile? user;
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
  Location? location;

  // dynamic discoverability;
  Nationality? nationality;

  List<GenderTags>? genderTags;
  List<Attachments>? attachments;

  // List<dynamic>? actionTrackers;
  // List<dynamic>? aboutChildren;
  String? profilePictureType;

  List<String>? sharedWithUsers;
  int? photoLimit;

  ProfileModel copyWith({
    // String? createdBy,
    // String? createdDate,
    // String? lastModifiedBy,
    // String? lastModifiedDate,
    String? id,
    num? code,
    String? name,
    String? status,
    UserProfile? user,
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
    Location? location,
    dynamic discoverability,
    Nationality? nationality,
    List<GenderTags>? genderTags,
    List<Attachments>? attachments,
    List<dynamic>? actionTrackers,
    List<dynamic>? aboutChildren,
    String? profilePictureType,
    List<String>? sharedWithUsers,
    int? photoLimit,
  }) =>
      ProfileModel(
          // createdBy: createdBy ?? this.createdBy,
          // createdDate: createdDate ?? this.createdDate,
          // lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
          // lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
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
          // discoverability: discoverability ?? this.discoverability,
          nationality: nationality ?? this.nationality,
          genderTags: genderTags ?? this.genderTags,
          attachments: attachments ?? this.attachments,
          // actionTrackers: actionTrackers ?? this.actionTrackers,
          // aboutChildren: aboutChildren ?? this.aboutChildren,
          profilePictureType: profilePictureType ?? this.profilePictureType,
          sharedWithUsers: sharedWithUsers ?? this.sharedWithUsers,
          photoLimit: photoLimit ?? this.photoLimit);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    // map['createdBy'] = createdBy;
    // map['createdDate'] = createdDate;
    // map['lastModifiedBy'] = lastModifiedBy;
    // map['lastModifiedDate'] = lastModifiedDate;
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
    if (location != null) {
      map['location'] = location?.toJson();
    }
    // map['discoverability'] = discoverability;
    if (nationality != null) {
      map['nationality'] = nationality?.toJson();
    }
    // if (genderTags != null) {
    //   map['genderTags'] = genderTags?.map((v) => v.toJson()).toList();
    // }
    if (attachments != null) {
      map['attachments'] = attachments?.map((v) => v.toJson()).toList();
    }
    // if (actionTrackers != null) {
    //   map['actionTrackers'] = actionTrackers?.map((v) => v.toJson()).toList();
    // }
    // if (aboutChildren != null) {
    //   map['aboutChildren'] = aboutChildren?.map((v) => v.toJson()).toList();
    // }
    map['profilePictureType'] = profilePictureType;
    if (sharedWithUsers != null) {
      map['sharedWithUsers'] = sharedWithUsers;
    }
    map['photoLimit'] = photoLimit;
    return map;
  }

  @override
  List<Object?> get props => [
        id,
        code,
        name,
        status,
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
        knowledgeOfLanguages,
        viewed,
        liked,
        skills,
        bio,
        requirements,
        profileState,
        location,
        // discoverability,
        nationality,
        // genderTags,
        attachments,
        // actionTrackers,
        // aboutChildren,
        profilePictureType,
        sharedWithUsers,
        photoLimit
      ];
}

class Attachments extends Equatable {
  Attachments({
    this.id,
    this.orderNumber,
    this.fileKey,
    this.state,
    this.status,
    this.storageUrl,
    this.fileType,
    this.user,
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
    user = json['user'];
    key = json['key'];
  }

  String? id;
  num? orderNumber;
  String? fileKey;
  String? state;
  String? status;
  String? storageUrl;
  String? fileType;
  UserProfile? user;
  String? key;

  Attachments copyWith({
    String? id,
    num? orderNumber,
    String? fileKey,
    String? state,
    String? status,
    String? storageUrl,
    String? fileType,
    UserProfile? user,
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
        user: user ?? this.user,
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
    map['user'] = user;
    map['key'] = key;
    return map;
  }

  @override
  List<Object?> get props => [
        id,
        orderNumber,
        fileKey,
        state,
        status,
        storageUrl,
        fileType,
        user,
        key,
      ];
}

class Children {
  Children({
    this.id,
    this.name,
    this.children,
    this.localization,
  });

  Children.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    if (json['children'] != null) {
      children = [];
      json['children'].forEach((v) {
        children?.add(Children.fromJson(v));
      });
    }
    localization = json['localization'] != null ? LocalizationLanguage.fromJson(json['localization']) : null;
  }

  String? id;
  String? name;
  List<Children>? children;
  LocalizationLanguage? localization;

  Children copyWith({
    String? id,
    String? name,
    List<Children>? children,
    LocalizationLanguage? localization,
  }) =>
      Children(
        id: id ?? this.id,
        name: name ?? this.name,
        children: children ?? this.children,
        localization: localization ?? this.localization,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    if (children != null) {
      map['children'] = children?.map((v) => v.toJson()).toList();
    }
    if (localization != null) {
      map['localization'] = localization?.toJson();
    }
    return map;
  }
}

class UserProfile {
  UserProfile({
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
    // this.profile,
    // this.devices,
    // this.images,
    // this.attachments,
    // this.reports,
    // this.tariff,
    // this.tariffExpirationDate,
  });

  UserProfile.fromJson(dynamic json) {
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
    // profile = json['profile'];
    // devices = json['devices'];
    // images = json['images'];
    // attachments = json['attachments'];
    // reports = json['reports'];
    // tariff = json['tariff'];
    // tariffExpirationDate = json['tariffExpirationDate'];
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

  // dynamic profile;
  // dynamic devices;
  // dynamic images;
  // dynamic attachments;
  // dynamic reports;
  // dynamic tariff;
  // dynamic tariffExpirationDate;
  UserProfile copyWith({
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
    // dynamic profile,
    // dynamic devices,
    // dynamic images,
    // dynamic attachments,
    // dynamic reports,
    // dynamic tariff,
    // dynamic tariffExpirationDate,
  }) =>
      UserProfile(
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
        // profile: profile ?? this.profile,
        // devices: devices ?? this.devices,
        // images: images ?? this.images,
        // attachments: attachments ?? this.attachments,
        // reports: reports ?? this.reports,
        // tariff: tariff ?? this.tariff,
        // tariffExpirationDate: tariffExpirationDate ?? this.tariffExpirationDate,
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
    // map['profile'] = profile;
    // map['devices'] = devices;
    // map['images'] = images;
    // map['attachments'] = attachments;
    // map['reports'] = reports;
    // map['tariff'] = tariff;
    // map['tariffExpirationDate'] = tariffExpirationDate;
    return map;
  }
}
