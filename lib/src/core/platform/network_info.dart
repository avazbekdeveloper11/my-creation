import 'package:flutter/cupertino.dart';

import '../connectivity/internet_connection_checker.dart';

abstract class NetworkInfo {
  const NetworkInfo();

  Future<bool> get isConnected;

  Stream<InternetConnectionStatus> get onStatusChange;
}

@immutable
class NetworkInfoImpl implements NetworkInfo {
  const NetworkInfoImpl(this.internetConnection);

  final InternetConnectionChecker internetConnection;

  @override
  Future<bool> get isConnected => internetConnection.hasConnection;

  @override
  Stream<InternetConnectionStatus> get onStatusChange =>
      internetConnection.onStatusChange;

  @override
  String toString() => 'NetworkInfoImpl($internetConnection)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NetworkInfoImpl &&
        other.internetConnection == internetConnection;
  }

  @override
  int get hashCode => internetConnection.hashCode;
}
