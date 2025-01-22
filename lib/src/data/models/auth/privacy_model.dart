import 'package:sovchilar_mobile/src/config/router/app_routes.dart';

class PrivacyModel {
  PrivacyModel({
    this.urls,
  });

  PrivacyModel.fromJson(dynamic json) {
    urls = json['urls'] != null ? UrlsPrivacy.fromJson(json['urls']) : null;
  }
  UrlsPrivacy? urls;
  PrivacyModel copyWith({
    UrlsPrivacy? urls,
  }) =>
      PrivacyModel(
        urls: urls ?? this.urls,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (urls != null) {
      map['urls'] = urls?.toJson();
    }
    return map;
  }
}

class UrlsPrivacy {
  UrlsPrivacy({
    this.uzlatin,
    this.uzcyril,
    this.ru,
  });

  UrlsPrivacy.fromJson(dynamic json) {
    uzlatin = json['UZ_LATIN'] != null ? UzLatin.fromJson(json['UZ_LATIN']) : null;
    uzcyril = json['UZ_CYRIL'] != null ? UzCyril.fromJson(json['UZ_CYRIL']) : null;
    ru = json['RU'] != null ? Ru.fromJson(json['RU']) : null;
  }
  UzLatin? uzlatin;
  UzCyril? uzcyril;
  Ru? ru;

  String get localizedUrl => switch (localSource.locale) {
        'ru' => ru?.url ?? '',
        'oz' => uzcyril?.url ?? '',
        'uz' => uzlatin?.url ?? '',
        _ => uzlatin?.url ?? '',
      };

  UrlsPrivacy copyWith({
    UzLatin? uzlatin,
    UzCyril? uzcyril,
    Ru? ru,
  }) =>
      UrlsPrivacy(
        uzlatin: uzlatin ?? this.uzlatin,
        uzcyril: uzcyril ?? this.uzcyril,
        ru: ru ?? this.ru,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (uzlatin != null) {
      map['UZ_LATIN'] = uzlatin?.toJson();
    }
    if (uzcyril != null) {
      map['UZ_CYRIL'] = uzcyril?.toJson();
    }
    if (ru != null) {
      map['RU'] = ru?.toJson();
    }
    return map;
  }
}

class Ru {
  Ru({
    this.id,
    this.url,
    this.language,
  });

  Ru.fromJson(dynamic json) {
    id = json['id'];
    url = json['url'];
    language = json['language'];
  }
  String? id;
  String? url;
  String? language;
  Ru copyWith({
    String? id,
    String? url,
    String? language,
  }) =>
      Ru(
        id: id ?? this.id,
        url: url ?? this.url,
        language: language ?? this.language,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['url'] = url;
    map['language'] = language;
    return map;
  }
}

class UzCyril {
  UzCyril({
    this.id,
    this.url,
    this.language,
  });

  UzCyril.fromJson(dynamic json) {
    id = json['id'];
    url = json['url'];
    language = json['language'];
  }
  String? id;
  String? url;
  String? language;
  UzCyril copyWith({
    String? id,
    String? url,
    String? language,
  }) =>
      UzCyril(
        id: id ?? this.id,
        url: url ?? this.url,
        language: language ?? this.language,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['url'] = url;
    map['language'] = language;
    return map;
  }
}

class UzLatin {
  UzLatin({
    this.id,
    this.url,
    this.language,
  });

  UzLatin.fromJson(dynamic json) {
    id = json['id'];
    url = json['url'];
    language = json['language'];
  }
  String? id;
  String? url;
  String? language;
  UzLatin copyWith({
    String? id,
    String? url,
    String? language,
  }) =>
      UzLatin(
        id: id ?? this.id,
        url: url ?? this.url,
        language: language ?? this.language,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['url'] = url;
    map['language'] = language;
    return map;
  }
}
