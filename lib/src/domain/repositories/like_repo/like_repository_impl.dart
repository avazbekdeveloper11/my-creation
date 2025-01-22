part of 'like_repository.dart';

final class LikeRepositoryImpl extends LikeRepository {
  const LikeRepositoryImpl({
    required this.dio,
  }) : super();

  final Dio dio;

  @override
  Future<Either<Failure, List<LikesModel>>> getLikes({bool isCache = true}) async {
    try {
      // if (isCache) {
      //   final String cachedData = localSource.getKey(AppKeys.likesCache);
      //   if (cachedData.isNotEmpty) {
      //     final cachedList =
      //         (jsonDecode(cachedData) as List).map((e) => LikesModel.fromJson(e as Map<String, dynamic>)).toList();
      //     return Right(cachedList);
      //   }
      // }
      final Response response = await dio.get(
        '${Constants.baseUrl}${Urls.getLikes}',
        queryParameters: {
          'likeGettingWay': 'THEY_LIKED',
          'profileId': localSource.profileId,
        },
        options: Options(
          headers: {'Authorization': 'Bearer ${localSource.accessToken}'},
        ),
      );
      final likeList = (response.data as List).map((e) => LikesModel.fromJson(e as Map<String, dynamic>)).toList();
      final likeListJson = jsonEncode(likeList.map((user) => user.toJson()).toList());
      await localSource.setKey(AppKeys.likesCache, likeListJson);

      return Right((response.data as List).map((e) => LikesModel.fromJson(e as Map<String, dynamic>)).toList());
    } on DioException catch (error, stacktrace) {
      log('DioException occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, bool>> likeUser(String? profileId) async {
    try {
      final Response response = await dio.post(
        '${Constants.baseUrl}${Urls.likes}',
        data: {
          'id': null,
          'likedProfile': {'id': profileId ?? ''},
          'profile': {'id': localSource.profileId}
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${localSource.accessToken}',
          },
        ),
      );
      return Right(response.statusCode == 200);
    } on DioException catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } on Exception catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, bool>> dislikeUser(String? profileId) async {
    try {
      final Response response = await dio.delete(
        '${Constants.baseUrl}${Urls.likeRemove}',
        data: {
          'id': null,
          'likedProfile': {'id': profileId ?? ''},
          'profile': {'id': localSource.profileId}
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${localSource.accessToken}',
          },
        ),
      );
      return Right(response.statusCode == 200);
    } on DioException catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } on Exception catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }
}
