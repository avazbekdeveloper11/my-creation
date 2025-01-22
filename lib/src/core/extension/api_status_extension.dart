part of 'extension.dart';

extension ApiStatusExtension on ApiStatus {
  bool get isSuccess => this == ApiStatus.success;

  bool get isError => this == ApiStatus.error;

  bool get isLoading => this == ApiStatus.loading;

  bool get isNone => this == ApiStatus.none;
}
