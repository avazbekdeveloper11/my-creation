import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/core/constants/constants.dart';
import 'package:sovchilar_mobile/src/data/models/profile/profile_model.dart';
import 'package:sovchilar_mobile/src/domain/failure/failure.dart';
import 'package:sovchilar_mobile/src/domain/failure/server_error.dart';
import 'package:sovchilar_mobile/src/data/models/home/user_model.dart';

part 'user_repository_impl.dart';

abstract class UserRepository {
  const UserRepository();

  Future<Either<Failure, List<UserModel>>> getUsers({
    Map<String, dynamic>? filter,
    double? lat,
    double? long,
    int km = 0,
  });

  Future<Either<Failure, ProfileModel>> getUserDetail(String uuid);

  Future<Either<Failure, List<PlaceOfBirth>>> getPlaces();

  Future<Either<Failure, List<PlaceOfBirth>>> getParentPlaces(String parentId);

  Future<Either<Failure, List<Nationality>>> getNationalities();

  Future<Either<Failure, List<GenderTags>>> getGenderTags({bool isFilter = false});

  Future<Either<Failure, int>> createQuestionnaire(UserModel profile);

  Future<Either<Failure, bool>> editProfile({required UserModel profile});

  Future<Either<Failure, bool>> postViewedApi({required String uuid});
}
