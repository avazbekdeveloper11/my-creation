part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();
}

class ShowMyImage extends ChatEvent {
  const ShowMyImage(this.visibilityModel);

  final VisibilityModel visibilityModel;

  @override
  List<Object?> get props => [visibilityModel];
}

class DislikeChatEvent extends ChatEvent {
  final String? profileId;

  const DislikeChatEvent(this.profileId);

  @override
  List<Object?> get props => [profileId];
}
