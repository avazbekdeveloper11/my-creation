part of 'profile_repository.dart';

final class ProfileRepositoryImpl extends ProfileRepository {
  const ProfileRepositoryImpl({
    required this.dio,
  }) : super();

  final Dio dio;

  @override
  Future<Either<Failure, ProfileModel>> getProfile({isCache = true}) async {
    try {
      if (isCache) {
        final String cachedData = localSource.getKey(AppKeys.profileCache);
        if (cachedData.isNotEmpty) {
          final ProfileModel cache = ProfileModel.fromJson(jsonDecode(cachedData) as Map<String, dynamic>);
          return Right(cache);
        }
      }

      final Response response = await dio.get(
        '${Constants.baseUrl}${Urls.profilesById}${localSource.profileId}',
        options: Options(
          headers: {'Authorization': 'Bearer ${localSource.accessToken}'},
        ),
      );
      final profile = ProfileModel.fromJson(response.data);
      localSource.setPhotoShow(value: profile.profilePictureType == 'PUBLIC');
      final profileJson = jsonEncode(profile);
      await localSource.setKey(AppKeys.profileCache, profileJson);
      return Right(profile);
    } on DioException catch (error, stacktrace) {
      log('DioException occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, bool>> deleteAccount() async {
    try {
      final Response response = await dio.delete(
        '${Constants.baseUrl}${Urls.deleteProfile}',
        options: Options(
          headers: {'Authorization': 'Bearer ${localSource.accessToken}'},
        ),
      );

      await localSource.deleteKey(AppKeys.profileCache);
      return Right(response.statusCode == 204);
    } on DioException catch (error, stacktrace) {
      log('DioException occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }
}
