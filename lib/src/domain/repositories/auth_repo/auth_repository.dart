import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:intl/intl.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/core/constants/constants.dart';
import 'package:sovchilar_mobile/src/data/models/auth/account_model.dart';
import 'package:sovchilar_mobile/src/data/models/auth/config_model.dart';
import 'package:sovchilar_mobile/src/data/models/auth/privacy_model.dart';
import 'package:sovchilar_mobile/src/data/models/auth/register_response.dart';
import 'package:sovchilar_mobile/src/domain/failure/failure.dart';
import 'package:sovchilar_mobile/src/domain/failure/server_error.dart';

part 'auth_repository_impl.dart';

abstract class AuthRepository {
  const AuthRepository();

  Future<Either<Failure, bool>> sendOtp();

  Future<Either<Failure, bool>> login({required String login, required String password});

  Future<Either<Failure, AccountModel>> getAccount();

  Future<Either<Failure, RegisterResponse>> register({
    required String login,
    required String password,
    required String date,
    required String gender,
  });

  Future<Either<Failure, ConfigModel>> getConfig();

  Future<Either<Failure, bool>> otpConfirm({required String code});

  Future<Either<Failure, bool>> sendForgotOtp({required String phone});

  Future<Either<Failure, bool>> verifyForgotOtp({
    required String phone,
    required String code,
    required String password,
  });

  Future<Either<Failure, bool>> setDeviceId();

  Future<Either<Failure, bool>> refreshToken();

  Future<Either<Failure, PrivacyModel>> getPrivacy();
}
