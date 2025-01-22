import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/core/constants/constants.dart';
import 'package:sovchilar_mobile/src/data/models/like/likes_model.dart';
import 'package:sovchilar_mobile/src/domain/failure/failure.dart';
import 'package:sovchilar_mobile/src/domain/failure/server_error.dart';

part 'like_repository_impl.dart';

abstract class LikeRepository {
  const LikeRepository();

  Future<Either<Failure, List<LikesModel>>> getLikes({bool isCache = true});

  Future<Either<Failure, bool>> likeUser(String? profileId);

  Future<Either<Failure, bool>> dislikeUser(String? profileId);
}
