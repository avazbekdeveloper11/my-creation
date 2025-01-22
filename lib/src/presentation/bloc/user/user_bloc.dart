import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/core/constants/api_status.dart';
import 'package:sovchilar_mobile/src/data/models/chat/chat_model.dart';
import 'package:sovchilar_mobile/src/domain/repositories/chat_repo/chat_repository.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this.chatRepository) : super(const UserState()) {
    on<GetChatUsersEvent>(_getUsersEvent);
  }

  final ChatRepository chatRepository;

  Future<void> _getUsersEvent(GetChatUsersEvent event, Emitter<UserState> emit) async {
    if (!event.isRefresh) {
      emit(state.copyWith(apiStatus: ApiStatus.loading));
    }
    if (localSource.profileId.isEmpty) {
      print('bitta request tejaldi');
      return;
    }
    final result = await chatRepository.getChatUsers();

    result.fold(
      (failure) => emit(state.copyWith(apiStatus: ApiStatus.error)),
      (users) {
        emit(
          state.copyWith(
            apiStatus: ApiStatus.success,
            usersOpened:
                users.where((element) => element.status == "OPEN" || element.status == "NOT_OPEN_YET").toList(),
            usersClosed: users.where((element) => element.status == "CLOSED").toList(),
          ),
        );
      },
    );
  }
}
