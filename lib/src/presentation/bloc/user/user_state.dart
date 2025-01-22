part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState({
    this.apiStatus = ApiStatus.none,
    this.usersClosed = const [],
    this.usersOpened = const [],
  });

  final ApiStatus apiStatus;
  final List<MatchesModel>? usersClosed;
  final List<MatchesModel>? usersOpened;

  UserState copyWith({
    ApiStatus? apiStatus,
    List<MatchesModel>? users,
    List<MatchesModel>? usersClosed,
    List<MatchesModel>? usersOpened,
  }) {
    return UserState(
      apiStatus: apiStatus ?? this.apiStatus,
      usersClosed: usersClosed ?? this.usersClosed,
      usersOpened: usersOpened ?? this.usersOpened,
    );
  }

  @override
  List<Object?> get props => [
        apiStatus,
        usersClosed,
        usersOpened,
      ];
}
