import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/core/constants/constants.dart';
import 'package:sovchilar_mobile/src/data/models/profile/profile_model.dart';
import 'package:sovchilar_mobile/src/domain/failure/failure.dart';
import 'package:sovchilar_mobile/src/domain/failure/server_error.dart';

part 'profile_repository_impl.dart';

abstract class ProfileRepository {
  const ProfileRepository();

  Future<Either<Failure, ProfileModel>> getProfile({isCache = true});

  Future<Either<Failure, bool>> deleteAccount();
}
