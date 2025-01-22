class ImageModel {
  ImageModel({
    this.id,
    this.url,
  });

  ImageModel.fromJson(dynamic json) {
    id = json['id'];
    url = json['url'];
  }
  String? id;
  String? url;
  ImageModel copyWith({
    String? id,
    String? url,
  }) =>
      ImageModel(
        id: id ?? this.id,
        url: url ?? this.url,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['url'] = url;
    return map;
  }
}
