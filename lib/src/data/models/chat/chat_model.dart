import '../home/user_model.dart';

class MatchesModel {
  MatchesModel({
    this.id,
    this.like1,
    this.like2,
    this.chat,
    this.status,
    this.createdDate,
    this.updatedDate,
    this.isActive,
    // this.expirationDate,
    // this.chatDurationInHour,
    this.isOppositeBusy,
    this.oppositeProfile,
    this.chatDurationInHour,
  });

  MatchesModel.fromJson(dynamic json) {
    id = json['id'];
    like1 = json['like1'] != null ? Like1.fromJson(json['like1']) : null;
    like2 = json['like2'] != null ? Like2.fromJson(json['like2']) : null;
    chat = json['chat'] != null ? ChatModel.fromJson(json['chat']) : null;
    status = json['status'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    isActive = json['isActive'];
    // expirationDate = json['expirationDate'];
    // chatDurationInHour = json['chatDurationInHour'];
    isOppositeBusy = json['isOppositeBusy'];
    oppositeProfile = json['oppositeProfile'] != null ? OppositeProfile.fromJson(json['oppositeProfile']) : null;
    chatDurationInHour = json['chatDurationInHour'];
  }

  String? id;
  Like1? like1;
  Like2? like2;
  ChatModel? chat;
  String? status;
  String? createdDate;
  String? updatedDate;
  bool? isActive;

  // dynamic expirationDate;
  // dynamic chatDurationInHour;
  bool? isOppositeBusy;
  OppositeProfile? oppositeProfile;
  int? chatDurationInHour;

  MatchesModel copyWith({
    String? id,
    Like1? like1,
    Like2? like2,
    ChatModel? chat,
    String? status,
    String? createdDate,
    String? updatedDate,
    bool? isActive,
    // dynamic expirationDate,
    // dynamic chatDurationInHour,
    bool? isOppositeBusy,
    OppositeProfile? oppositeProfile,
    int? chatDurationInHour,
  }) =>
      MatchesModel(
        id: id ?? this.id,
        like1: like1 ?? this.like1,
        like2: like2 ?? this.like2,
        chat: chat ?? this.chat,
        status: status ?? this.status,
        createdDate: createdDate ?? this.createdDate,
        updatedDate: updatedDate ?? this.updatedDate,
        isActive: isActive ?? this.isActive,
        // expirationDate: expirationDate ?? this.expirationDate,
        // chatDurationInHour: chatDurationInHour ?? this.chatDurationInHour,
        isOppositeBusy: isOppositeBusy ?? this.isOppositeBusy,
        oppositeProfile: oppositeProfile ?? this.oppositeProfile,
        chatDurationInHour: chatDurationInHour ?? this.chatDurationInHour,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (like1 != null) {
      map['like1'] = like1?.toJson();
    }
    if (like2 != null) {
      map['like2'] = like2?.toJson();
    }
    if (chat != null) {
      map['chat'] = chat?.toJson();
    }
    map['status'] = status;
    map['createdDate'] = createdDate;
    map['updatedDate'] = updatedDate;
    map['isActive'] = isActive;
    // map['expirationDate'] = expirationDate;
    // map['chatDurationInHour'] = chatDurationInHour;
    map['isOppositeBusy'] = isOppositeBusy;
    if (oppositeProfile != null) {
      map['oppositeProfile'] = oppositeProfile?.toJson();
    }
    map['chatDurationInHour'] = chatDurationInHour;
    return map;
  }
}

class OppositeProfile {
  OppositeProfile({
    this.id,
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
    this.actionTrackers,
    this.profilePictureType,
    this.sharedWithUsers,
    // this.busy,
  });

  OppositeProfile.fromJson(dynamic json) {
    id = json['id'];
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
    dwellingPlace = json['dwellingPlace'] != null ? DwellingPlace.fromJson(json['dwellingPlace']) : null;
    maritalStatus = json['maritalStatus'];
    childPlanInFuture = json['childPlanInFuture'];
    numOfMembersInFamily = json['numOfMembersInFamily'];
    numOfChildrenInFamily = json['numOfChildrenInFamily'];
    birthPositionInFamily = json['birthPositionInFamily'];
    ownDwelling = json['ownDwelling'];
    if (json['knowledgeOfLanguages'] != null) {
      knowledgeOfLanguages = (json['knowledgeOfLanguages'] as List).map((v) => v.toString()).toList();
    }
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
    if (json['actionTrackers'] != null) {
      actionTrackers = [];
      json['actionTrackers'].forEach((v) {
        actionTrackers?.add(ActionTrackers.fromJson(v));
      });
    }
    profilePictureType = json['profilePictureType'];
    if (json['sharedWithUsers'] != null) {
      sharedWithUsers = [...json['sharedWithUsers']];
    }
    // busy = json['busy'];
  }

  String? id;
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
  DwellingPlace? dwellingPlace;
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
  List<ActionTrackers>? actionTrackers;
  String? profilePictureType;
  List<String>? sharedWithUsers;

  // dynamic busy;

  OppositeProfile copyWith({
    String? id,
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
    DwellingPlace? dwellingPlace,
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
    // dynamic discoverability,
    Nationality? nationality,
    List<GenderTags>? genderTags,
    List<Attachments>? attachments,
    List<ActionTrackers>? actionTrackers,
    String? profilePictureType,
    List<String>? sharedWithUsers,
    // dynamic busy,
  }) =>
      OppositeProfile(
        id: id ?? this.id,
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
        actionTrackers: actionTrackers ?? this.actionTrackers,
        profilePictureType: profilePictureType ?? this.profilePictureType,
        sharedWithUsers: sharedWithUsers ?? this.sharedWithUsers,
        // busy: busy ?? this.busy,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
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
    if (knowledgeOfLanguages != null) {
      map['knowledgeOfLanguages'] = knowledgeOfLanguages;
    }
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
    if (genderTags != null) {
      map['genderTags'] = genderTags?.map((v) => v.toJson()).toList();
    }
    if (attachments != null) {
      map['attachments'] = attachments?.map((v) => v.toJson()).toList();
    }
    if (actionTrackers != null) {
      map['actionTrackers'] = actionTrackers?.map((v) => v.toJson()).toList();
    }
    map['profilePictureType'] = profilePictureType;
    if (sharedWithUsers != null) {
      map['sharedWithUsers'] = sharedWithUsers;
    }
    // map['busy'] = busy;
    return map;
  }
}

class ActionTrackers {
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
  User? user;
  String? key;

  Attachments copyWith({
    String? id,
    num? orderNumber,
    String? fileKey,
    String? state,
    String? status,
    String? storageUrl,
    String? fileType,
    User? user,
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
}

class Nationality {
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
    localization = json['localization'];
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
}

class Location {
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
}

class DwellingPlace {
  DwellingPlace({
    this.id,
    this.name,
    this.children,
    this.localization,
  });

  DwellingPlace.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    if (json['children'] != null) {
      children = [];
      json['children'].forEach((v) {
        children?.add(Children.fromJson(v));
      });
    }
    localization = LocalizationLanguage.fromJson(json['localization']);
  }

  String? id;
  String? name;
  List<Children>? children;
  LocalizationLanguage? localization;

  DwellingPlace copyWith({
    String? id,
    String? name,
    List<Children>? children,
    LocalizationLanguage? localization,
  }) =>
      DwellingPlace(
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
    map['localization'] = localization;
    return map;
  }
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
    localization = LocalizationLanguage.fromJson(json['localization']);
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
    map['localization'] = localization;
    return map;
  }
}

class Like2 {
  Like2({
    this.id,
    // this.profile,
    // this.likedProfile,
    this.status,
    this.createdDate,
    this.updatedDate,
  });

  Like2.fromJson(dynamic json) {
    id = json['id'];
    // profile = json['profile'];
    // likedProfile = json['likedProfile'];
    status = json['status'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  String? id;

  // dynamic profile;
  // dynamic likedProfile;
  String? status;
  String? createdDate;
  String? updatedDate;

  Like2 copyWith({
    String? id,
    // dynamic profile,
    // dynamic likedProfile,
    String? status,
    String? createdDate,
    String? updatedDate,
  }) =>
      Like2(
        id: id ?? this.id,
        // profile: profile ?? this.profile,
        // likedProfile: likedProfile ?? this.likedProfile,
        status: status ?? this.status,
        createdDate: createdDate ?? this.createdDate,
        updatedDate: updatedDate ?? this.updatedDate,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    // map['profile'] = profile;
    // map['likedProfile'] = likedProfile;
    map['status'] = status;
    map['createdDate'] = createdDate;
    map['updatedDate'] = updatedDate;
    return map;
  }
}

class Like1 {
  Like1({
    this.id,
    // this.profile,
    // this.likedProfile,
    this.status,
    this.createdDate,
    this.updatedDate,
  });

  Like1.fromJson(dynamic json) {
    id = json['id'];
    // profile = json['profile'];
    // likedProfile = json['likedProfile'];
    status = json['status'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  String? id;

  // dynamic profile;
  // dynamic likedProfile;
  String? status;
  String? createdDate;
  String? updatedDate;

  Like1 copyWith({
    String? id,
    // dynamic profile,
    // dynamic likedProfile,
    String? status,
    String? createdDate,
    String? updatedDate,
  }) =>
      Like1(
        id: id ?? this.id,
        // profile: profile ?? this.profile,
        // likedProfile: likedProfile ?? this.likedProfile,
        status: status ?? this.status,
        createdDate: createdDate ?? this.createdDate,
        updatedDate: updatedDate ?? this.updatedDate,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    // map['profile'] = profile;
    // map['likedProfile'] = likedProfile;
    map['status'] = status;
    map['createdDate'] = createdDate;
    map['updatedDate'] = updatedDate;
    return map;
  }
}

class ChatModel {
  ChatModel({
    this.id,
    this.chatId,
  });

  final String? id;
  final String? chatId;

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        id: json['id'],
        chatId: json['chatId'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'chatId': chatId,
      };
}
