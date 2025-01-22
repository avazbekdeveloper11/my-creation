part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final ApiStatus apiStatus;
  final ApiStatus imageApiStatus;
  final ApiStatus likeApiStatus;
  final ProfileModel? user;

  const ChatState({
    this.apiStatus = ApiStatus.none,
    this.imageApiStatus = ApiStatus.none,
    this.likeApiStatus = ApiStatus.none,
    this.user,
  });

  ChatState copyWith({
    ApiStatus? apiStatus,
    ApiStatus? imageApiStatus,
    ApiStatus? likeApiStatus,
    ProfileModel? user,
  }) {
    return ChatState(
      apiStatus: apiStatus ?? this.apiStatus,
      imageApiStatus: imageApiStatus ?? this.imageApiStatus,
      likeApiStatus: likeApiStatus ?? this.likeApiStatus,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [apiStatus, imageApiStatus, likeApiStatus, user];
}
