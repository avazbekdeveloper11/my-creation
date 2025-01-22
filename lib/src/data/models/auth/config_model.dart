class ConfigModel {
  ConfigModel({
    this.minio,
    this.otp,
    this.telegramBot,
    this.miniApp,
  });

  ConfigModel.fromJson(dynamic json) {
    minio = json['minio'] != null ? Minio.fromJson(json['minio']) : null;
    otp = json['otp'] != null ? Otp.fromJson(json['otp']) : null;
    telegramBot = json['telegram_bot'] != null ? TelegramBot.fromJson(json['telegram_bot']) : null;
    miniApp = json['mini_app'] != null ? MiniApp.fromJson(json['mini_app']) : null;
  }
  Minio? minio;
  Otp? otp;
  TelegramBot? telegramBot;
  MiniApp? miniApp;
  ConfigModel copyWith({
    Minio? minio,
    Otp? otp,
    TelegramBot? telegramBot,
    MiniApp? miniApp,
  }) =>
      ConfigModel(
        minio: minio ?? this.minio,
        otp: otp ?? this.otp,
        telegramBot: telegramBot ?? this.telegramBot,
        miniApp: miniApp ?? this.miniApp,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (minio != null) {
      map['minio'] = minio?.toJson();
    }
    if (otp != null) {
      map['otp'] = otp?.toJson();
    }
    if (telegramBot != null) {
      map['telegram_bot'] = telegramBot?.toJson();
    }
    if (miniApp != null) {
      map['mini_app'] = miniApp?.toJson();
    }
    return map;
  }
}

class MiniApp {
  MiniApp({
    this.authType,
  });

  MiniApp.fromJson(dynamic json) {
    authType = json['auth_type'];
  }
  String? authType;
  MiniApp copyWith({
    String? authType,
  }) =>
      MiniApp(
        authType: authType ?? this.authType,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['auth_type'] = authType;
    return map;
  }
}

class TelegramBot {
  TelegramBot({
    this.chatId,
    this.username,
    this.url,
  });

  TelegramBot.fromJson(dynamic json) {
    chatId = json['chat_id'];
    username = json['username'];
    url = json['url'];
  }
  num? chatId;
  String? username;
  String? url;
  TelegramBot copyWith({
    num? chatId,
    String? username,
    String? url,
  }) =>
      TelegramBot(
        chatId: chatId ?? this.chatId,
        username: username ?? this.username,
        url: url ?? this.url,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['chat_id'] = chatId;
    map['username'] = username;
    map['url'] = url;
    return map;
  }
}

class Otp {
  Otp({
    this.impl,
  });

  Otp.fromJson(dynamic json) {
    impl = json['impl'];
  }
  String? impl;
  Otp copyWith({
    String? impl,
  }) =>
      Otp(
        impl: impl ?? this.impl,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['impl'] = impl;
    return map;
  }
}

class Minio {
  Minio({
    this.url,
  });

  Minio.fromJson(dynamic json) {
    url = json['url'];
  }
  String? url;
  Minio copyWith({
    String? url,
  }) =>
      Minio(
        url: url ?? this.url,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    return map;
  }
}
