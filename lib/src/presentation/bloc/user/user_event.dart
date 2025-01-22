part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();
}

class GetChatUsersEvent extends UserEvent {
  const GetChatUsersEvent({this.isRefresh = false});

  final bool isRefresh;

  @override
  List<Object?> get props => [isRefresh];
}
