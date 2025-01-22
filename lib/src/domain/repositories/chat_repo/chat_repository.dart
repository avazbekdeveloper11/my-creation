import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/core/constants/constants.dart';
import 'package:sovchilar_mobile/src/data/models/chat/chat_model.dart';
import 'package:sovchilar_mobile/src/data/models/chat/visibilty_model.dart';
import 'package:sovchilar_mobile/src/data/models/profile/profile_model.dart';
import 'package:sovchilar_mobile/src/domain/failure/failure.dart';
import 'package:sovchilar_mobile/src/domain/failure/server_error.dart';

part 'chat_repository_impl.dart';

abstract class ChatRepository {
  const ChatRepository();

  Future<Either<Failure, List<MatchesModel>>> getChatUsers();

  Future<Either<Failure, ProfileModel>> changeVisibility({required VisibilityModel request});
}
