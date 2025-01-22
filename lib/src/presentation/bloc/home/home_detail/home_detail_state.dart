part of 'home_detail_bloc.dart';

class HomeDetailState extends Equatable {
  const HomeDetailState({
    this.apiStatus = ApiStatus.none,
    this.imageStatus = ApiStatus.none,
    this.viewStatus = ApiStatus.none,
    this.user,
    this.images = const [],
    this.message = '',
  });

  final ApiStatus apiStatus;
  final ApiStatus imageStatus;
  final ApiStatus viewStatus;
  final ProfileModel? user;
  final List<ImageModel>? images;
  final String message;

  HomeDetailState copyWith({
    ApiStatus? apiStatus,
    ApiStatus? imageStatus,
    ApiStatus? viewStatus,
    ProfileModel? user,
    List<ImageModel>? images,
    String? message,
  }) {
    return HomeDetailState(
      apiStatus: apiStatus ?? this.apiStatus,
      imageStatus: imageStatus ?? this.imageStatus,
      viewStatus: viewStatus ?? this.viewStatus,
      user: user ?? this.user,
      images: images ?? this.images,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        apiStatus,
        imageStatus,
        viewStatus,
        user,
        images,
        message,
      ];
}
