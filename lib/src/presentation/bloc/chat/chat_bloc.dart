import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sovchilar_mobile/src/core/constants/api_status.dart';
import 'package:sovchilar_mobile/src/data/models/chat/visibilty_model.dart';
import 'package:sovchilar_mobile/src/data/models/profile/profile_model.dart';
import 'package:sovchilar_mobile/src/domain/repositories/chat_repo/chat_repository.dart';
import 'package:sovchilar_mobile/src/domain/repositories/like_repo/like_repository.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(this.chatRepository, this.likeRepository) : super(const ChatState()) {
    on<ShowMyImage>(_onShowMyImage);
    on<DislikeChatEvent>(_onDislikeChatEvent);
  }

  final ChatRepository chatRepository;
  final LikeRepository likeRepository;

  _onShowMyImage(ShowMyImage event, Emitter<ChatState> emit) async {
    emit(state.copyWith(imageApiStatus: ApiStatus.loading));
    final result = await chatRepository.changeVisibility(request: event.visibilityModel);

    result.fold(
      (failure) => emit(state.copyWith(imageApiStatus: ApiStatus.error)),
      (user) => emit(state.copyWith(imageApiStatus: ApiStatus.success, user: user)),
    );
  }

  Future<void> _onDislikeChatEvent(DislikeChatEvent event, Emitter<ChatState> emit) async {
    emit(state.copyWith(likeApiStatus: ApiStatus.loading));
    final result = await likeRepository.dislikeUser(event.profileId);

    result.fold(
      (failure) => emit(state.copyWith(likeApiStatus: ApiStatus.error)),
      (message) => emit(state.copyWith(likeApiStatus: ApiStatus.success)),
    );
  }
}
