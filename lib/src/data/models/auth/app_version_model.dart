class AppVersionModel {
  AppVersionModel({
    this.version,
    this.required,
    this.url,
    this.status,
  });

  AppVersionModel.fromJson(dynamic json) {
    version = json['version'];
    required = json['required'];
    url = json['url'];
    status = json['status'];
  }
  String? version;
  bool? required;
  String? url;
  String? status;

  AppVersionModel copyWith({
    String? version,
    bool? required,
    String? url,
    String? status,
  }) =>
      AppVersionModel(
        version: version ?? this.version,
        required: required ?? this.required,
        url: url ?? this.url,
        status: status ?? this.status,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['version'] = version;
    map['required'] = required;
    map['url'] = url;
    map['status'] = status;
    return map;
  }
}
