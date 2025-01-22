part of 'image_repository.dart';

final class ImageRepositoryImpl extends ImageRepository {
  const ImageRepositoryImpl({
    required this.dio,
  }) : super();

  final Dio dio;

  @override
  Future<Either<Failure, List<ImageModel>>> getImageUrl({String? profileId}) async {
    try {
      final Response response = await dio.get(
        '${Constants.baseUrl}${Urls.getImage}${profileId ?? localSource.profileId}/image',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${localSource.accessToken}',
            'Content-Type': 'application/json',
          },
        ),
      );

      return Right((response.data as List).map((e) => ImageModel.fromJson(e as Map<String, dynamic>)).toList());
    } on DioException catch (error, stacktrace) {
      log('DioException occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, bool>> imageUpload({required File image, bool isVeification = false}) async {
    try {
      final Response responseUrl = await dio.post(
        '${Constants.baseUrl}${isVeification ? Urls.verificationImgUrl : Urls.createUrl}',
        queryParameters: {
          'profileId': localSource.profileId,
        },
        options: Options(
          headers: {'Authorization': 'Bearer ${localSource.accessToken}'},
        ),
      );
      final String url = responseUrl.data['url'];
      final Uint8List imageByte = await image.readAsBytes();

      final Response response = await dio.put(
        url,
        data: imageByte,
        options: Options(headers: {'Content-Type': 'image/png'}),
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
  Future<Either<Failure, bool>> deleteImage(String id) async {
    try {
      final Response response = await dio.delete(
        '${Constants.baseUrl}${Urls.deleteImage}/$id',
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
}
