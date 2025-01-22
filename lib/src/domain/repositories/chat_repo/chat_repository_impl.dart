part of 'chat_repository.dart';

final class ChatRepositoryImpl extends ChatRepository {
  const ChatRepositoryImpl({
    required this.dio,
  }) : super();

  final Dio dio;

  @override
  Future<Either<Failure, List<MatchesModel>>> getChatUsers() async {
    try {
      final Response response = await dio.get(
        '${Constants.baseUrl}${Urls.matches}',
        queryParameters: {'profileId': localSource.profileId},
        options: Options(
          headers: {'Authorization': 'Bearer ${localSource.accessToken}'},
        ),
      );

      return Right((response.data as List).map((e) => MatchesModel.fromJson(e as Map<String, dynamic>)).toList());
    } on DioException catch (error, stacktrace) {
      log('DioException occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> changeVisibility({required VisibilityModel request}) async {
    try {
      final Response response = await dio.put(
        '${Constants.baseUrl}${Urls.visibility}',
        data: request,
        options: Options(
          headers: {'Authorization': 'Bearer ${localSource.accessToken}'},
        ),
      );

      final sharedUser = ProfileModel.fromJson(response.data);
      localSource.setPhotoShow(value: sharedUser.profilePictureType == 'PUBLIC');
      localSource.setKey(AppKeys.profileCache, jsonEncode(sharedUser));

      return Right(sharedUser);
    } on DioException catch (error, stacktrace) {
      log('DioException occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }
}
