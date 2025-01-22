class VisibilityModel {
  VisibilityModel({
    this.id,
    this.profilePictureType,
    this.sharedWithUsers,
  });

  VisibilityModel.fromJson(dynamic json) {
    id = json['id'];
    profilePictureType = json['profilePictureType'];
    sharedWithUsers = json['sharedWithUsers'] != null ? json['sharedWithUsers'].cast<String>() : [];
  }
  String? id;
  String? profilePictureType;
  List<String>? sharedWithUsers;
  VisibilityModel copyWith({
    String? id,
    String? profilePictureType,
    List<String>? sharedWithUsers,
  }) =>
      VisibilityModel(
        id: id ?? this.id,
        profilePictureType: profilePictureType ?? this.profilePictureType,
        sharedWithUsers: sharedWithUsers ?? this.sharedWithUsers,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['profilePictureType'] = profilePictureType;
    map['sharedWithUsers'] = sharedWithUsers;
    return map;
  }
}
