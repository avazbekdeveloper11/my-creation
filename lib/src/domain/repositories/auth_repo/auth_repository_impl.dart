part of 'auth_repository.dart';

final class AuthRepositoryImpl extends AuthRepository {
  const AuthRepositoryImpl({
    required this.dio,
  }) : super();

  final Dio dio;

  @override
  Future<Either<Failure, bool>> sendOtp() async {
    try {
      final Response response = await dio.get(
        '${Constants.baseUrl}${Urls.sendOtpRegister}',
        queryParameters: {'userId': localSource.userId},
      );

      return Right(response.statusCode == 200 || response.statusCode == 201);
    } on DioException catch (error, stacktrace) {
      log('DioException occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, bool>> login({required String login, required String password}) async {
    try {
      final Response response = await dio.post(
        '${Constants.baseUrl}${Urls.login}',
        data: {'username': login, 'password': password, 'rememberMe': true},
      );

      await localSource.setUser(
        accessToken: response.data['id_token'],
        phone: login,
        password: password,
        refreshToken: response.data['refresh_token'],
      );

      return Right(response.statusCode == 200 || response.statusCode == 201);
    } on DioException catch (error, stacktrace) {
      log('DioException occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, AccountModel>> getAccount() async {
    try {
      final Response response = await dio.get('${Constants.baseUrl}${Urls.account}',
          options: Options(headers: {'Authorization': 'Bearer ${localSource.accessToken}'}));
      AccountModel data = AccountModel.fromJson(response.data as Map<String, dynamic>);
      localSource.setUser(
        userId: data.id ?? '',
        gender: data.gender ?? '',
        status: data.status ?? '',
        profileId: data.profile?.id ?? '',
      );

      if (data.status == 'ACTIVATED') {
        localSource.setHasProfile(value: true);
      }

      return Right(data);
    } on DioException catch (error, stacktrace) {
      log('DioException occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, RegisterResponse>> register({
    required String login,
    required String password,
    required String date,
    required String gender,
  }) async {
    try {
      final dateFormat = DateFormat("dd-MM-yyyy");
      final birthDate = dateFormat.parse(date);
      final today = DateTime.now();

      int age = today.year - birthDate.year;
      if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }

      final response = await dio.post(
        '${Constants.baseUrl}${Urls.register}',
        data: {
          'id': null,
          'login': login,
          'gender': gender,
          'age': age,
          'password': password,
          'level': 'LEVEL_1',
          'firstName': 'string',
          'lastName': 'string',
          'activated': true,
          'langKey': 'UZ_LATIN',
          'createdBy': 'string',
          'createdDate': null,
          'lastModifiedBy': 'string',
          'lastModifiedDate': null,
          'authorities': ['string'],
        },
      );
      final RegisterResponse data = RegisterResponse.fromJson(response.data as Map<String, dynamic>);

      localSource.setUser(
        firstName: data.firstName ?? '',
        lastName: data.lastName ?? '',
        userId: data.id ?? '',
        gender: data.gender ?? '',
        password: password,
        age: age.toString(),
        phone: data.login ?? '',
      );

      return Right(data);
    } on DioException catch (error, stacktrace) {
      log('DioException occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, ConfigModel>> getConfig() async {
    try {
      final Response response = await dio.get(Constants.baseUrl + Urls.config);

      return Right(ConfigModel.fromJson(response.data as Map<String, dynamic>));
    } on DioException catch (error, stacktrace) {
      log('DioException occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, bool>> otpConfirm({required String code}) async {
    try {
      final response = await dio.get(
        '${Constants.baseUrl}${Urls.otpVerify}',
        queryParameters: {'userId': localSource.userId, 'code': code},
        options: Options(
          headers: {'Authorization': 'Bearer ${localSource.accessToken}'},
        ),
      );
      return Right(response.statusCode == 200 || response.statusCode == 201);
    } on DioException catch (error, stacktrace) {
      log('DioException occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, bool>> sendForgotOtp({required String phone}) async {
    try {
      final response = await dio.post(
        '${Constants.baseUrl}${Urls.sendOtpForgot}',
        queryParameters: {'login': phone},
      );
      return Right((response.statusCode == 200 || response.statusCode == 201));
    } on DioException catch (error, stacktrace) {
      log('DioException occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, bool>> verifyForgotOtp({
    required String phone,
    required String code,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '${Constants.baseUrl}${Urls.verifyOtpForgot}',
        data: {
          'code': code,
          'password': password,
          'login': phone.toString(),
        },
      );
      return Right(response.statusCode == 200 || response.statusCode == 201);
    } on DioException catch (error, stacktrace) {
      log('DioException occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, bool>> setDeviceId() async {
    try {
      final response = await dio.post(
        '${Constants.baseUrl}${Urls.deviceId}',
        data: {
          "deviceId": localSource.deviceId,
          "deviceName": localSource.deviceName,
          "deviceType": localSource.deviceType,
          "deviceOsVersion": localSource.deviceOsVersion,
          "firebaseToken": localSource.fcmToken,
        },
        options: Options(
          headers: {'Authorization': 'Bearer ${localSource.accessToken}'},
        ),
      );
      return Right(response.statusCode == 200 || response.statusCode == 201);
    } on DioException catch (error, stacktrace) {
      log('DioException occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, bool>> refreshToken() async {
    try {
      final response = await dio.post(
        '${Constants.baseUrl}${Urls.refreshToken}',
        data: localSource.refreshToken,
        options: Options(
          headers: {'Authorization': 'Bearer ${localSource.accessToken}'},
        ),
      );

      localSource.setUser(
        accessToken: response.data['id_token'],
        refreshToken: response.data['refresh_token'],
      );
      return Right(response.statusCode == 200 || response.statusCode == 201);
    } on DioException catch (error, stacktrace) {
      log('DioException occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, PrivacyModel>> getPrivacy() async {
    try {
      final cache = localSource.getKey(AppKeys.privacy);

      if (cache.isNotEmpty) {
        final PrivacyModel cachedData = PrivacyModel.fromJson(jsonDecode(cache));
        return Right(cachedData);
      }

      final response = await dio.get('${Constants.baseUrl}${Urls.getPrivacy}');
      final PrivacyModel data = PrivacyModel.fromJson(response.data);

      localSource.setKey(AppKeys.privacy, jsonEncode(data));
      return Right(data);
    } on DioException catch (error, stacktrace) {
      log('DioException occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }
}
