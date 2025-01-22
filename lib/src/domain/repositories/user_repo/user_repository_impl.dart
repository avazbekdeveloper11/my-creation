part of 'user_repository.dart';

final class UserRepositoryImpl extends UserRepository {
  const UserRepositoryImpl({
    required this.dio,
  }) : super();

  final Dio dio;

  @override
  Future<Either<Failure, List<UserModel>>> getUsers({
    Map<String, dynamic>? filter,
    double? lat,
    double? long,
    int km = 0,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {
        'page': 0,
        'size': 1000,
      };
      if (filter != {} && filter != null) {
        queryParams.addAll(filter);
      }

      if (km == 0) {
        lat = 0;
        long = 0;
      }

      final String profileCache = localSource.getKey(AppKeys.profileCache);
      if (profileCache.isNotEmpty && lat == 0 && long == 0) {
        final ProfileModel profile = ProfileModel.fromJson(jsonDecode(profileCache) as Map<String, dynamic>);
        lat = (profile.location?.lat ?? 0).toDouble();
        long = (profile.location?.lon ?? 0).toDouble();
      }

      final Response response = await dio.get(
        '${Constants.baseUrl}${Urls.profilesNear}/${lat == 0.0 ? 0 : lat}/${long == 0.0 ? 0 : long}/${lat == null || lat == 0.0 && km == 0 || long == null || long == 0.0 ? 0 : km}',
        queryParameters: queryParams,
        options: Options(
          headers: {'Authorization': 'Bearer ${localSource.accessToken}'},
        ),
      );

      final userList = (response.data as List).map((e) => UserModel.fromJson(e as Map<String, dynamic>)).toList();
      final userListJson = jsonEncode(userList.map((user) => user.toJson()).toList());
      await localSource.setKey(AppKeys.homeCache, userListJson);

      return Right(userList);
    } on DioException catch (error, stacktrace) {
      log('DioException occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> getUserDetail(String uuid) async {
    try {
      final Response response = await dio.get(
        '${Constants.baseUrl}${Urls.profilesById}$uuid',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${localSource.accessToken}',
          },
        ),
      );
      return Right(ProfileModel.fromJson(response.data as Map<String, dynamic>));
    } on DioException catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } on Exception catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, List<PlaceOfBirth>>> getPlaces() async {
    try {
      final String cachedData = localSource.getKey(AppKeys.placeCache);
      if (cachedData.isNotEmpty) {
        final cachedList =
            (jsonDecode(cachedData) as List).map((e) => PlaceOfBirth.fromJson(e as Map<String, dynamic>)).toList();
        return Right(cachedList);
      }

      final Response response = await dio.get(
        '${Constants.baseUrl}${Urls.placeParent}',
        queryParameters: {'page': 0, 'size': 1000, 'parentId': '9420aa7c-507a-4a99-a840-6a112e5d2a70'},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${localSource.accessToken}',
          },
        ),
      );
      final places = (response.data as List).map((e) => PlaceOfBirth.fromJson(e as Map<String, dynamic>)).toList();
      localSource.setKey(AppKeys.placeCache, jsonEncode(places.map((e) => e.toJson()).toList()));
      return Right(places);
    } on DioException catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } on Exception catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, List<PlaceOfBirth>>> getParentPlaces(String parentId) async {
    try {
      final String cachedData = localSource.getKey(AppKeys.parentPlaceCache + parentId);
      if (cachedData.isNotEmpty) {
        final cachedList =
            (jsonDecode(cachedData) as List).map((e) => PlaceOfBirth.fromJson(e as Map<String, dynamic>)).toList();

        return Right(cachedList);
      }

      final Response response = await dio.get(
        '${Constants.baseUrl}${Urls.placeParent}',
        queryParameters: {'parentId': parentId, 'page': 0, 'size': 1000},
        options: Options(
          headers: {
            'Authorization': 'Bearer ${localSource.accessToken}',
          },
        ),
      );

      final places = (response.data as List).map((e) => PlaceOfBirth.fromJson(e as Map<String, dynamic>)).toList();
      localSource.setKey(AppKeys.parentPlaceCache + parentId, jsonEncode(places.map((e) => e.toJson()).toList()));

      return Right(places);
    } on DioException catch (error, stacktrace) {
      log('DioException occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } on Exception catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, List<Nationality>>> getNationalities() async {
    try {
      final String cachedData = localSource.getKey(AppKeys.nationalityCache);
      if (cachedData.isNotEmpty) {
        final cachedList =
            (jsonDecode(cachedData) as List).map((e) => Nationality.fromJson(e as Map<String, dynamic>)).toList();
        return Right(cachedList);
      }

      final Response response = await dio.get(
        '${Constants.baseUrl}${Urls.nationalities}',
        queryParameters: {'page': 0, 'size': 1000},
        options: Options(
          headers: {'Authorization': 'Bearer ${localSource.accessToken}'},
        ),
      );

      final userList = (response.data as List).map((e) => Nationality.fromJson(e as Map<String, dynamic>)).toList();
      final userListJson = jsonEncode(userList.map((user) => user.toJson()).toList());
      await localSource.setKey(AppKeys.nationalityCache, userListJson);

      return Right(userList);
    } on DioException catch (error, stacktrace) {
      log('DioException occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, List<GenderTags>>> getGenderTags({bool isFilter = false}) async {
    try {
      final String cachedData = localSource.getKey(
          '${AppKeys.genderCache}${isFilter ? localSource.gender.toUpperCase() == 'FEMALE' ? 'MALE' : 'FEMALE' : localSource.gender.toUpperCase()}');
      if (cachedData.isNotEmpty) {
        final cachedList =
            (jsonDecode(cachedData) as List).map((e) => GenderTags.fromJson(e as Map<String, dynamic>)).toList();
        return Right(cachedList);
      }

      final Response response = await dio.get(
        '${Constants.baseUrl}${Urls.genderTags}${isFilter ? localSource.gender.toUpperCase() == 'FEMALE' ? 'MALE' : 'FEMALE' : localSource.gender.toUpperCase()}',
        queryParameters: {'page': 0, 'size': 1000},
        options: Options(
          headers: {'Authorization': 'Bearer ${localSource.accessToken}'},
        ),
      );

      final userList = (response.data as List).map((e) => GenderTags.fromJson(e as Map<String, dynamic>)).toList();
      final userListJson = jsonEncode(userList.map((user) => user.toJson()).toList());
      await localSource.setKey(
          '${AppKeys.genderCache}${isFilter ? localSource.gender.toUpperCase() == 'FEMALE' ? 'MALE' : 'FEMALE' : localSource.gender.toUpperCase()}',
          userListJson);

      return Right(userList);
    } on DioException catch (error, stacktrace) {
      log('DioException occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, int>> createQuestionnaire(UserModel profile) async {
    try {
      final Response response = await dio.post(
        '${Constants.baseUrl}${Urls.createQuestionnaire}',
        options: Options(
          headers: {'Authorization': 'Bearer ${localSource.accessToken}'},
        ),
        data: {
          'id': null,
          'name': profile.name,
          'user': {'id': localSource.userId},
          'height': profile.height ?? 0,
          'weight': profile.weight ?? 0,
          'education': profile.education,
          'profession': profile.profession,
          'workPlace': profile.workPlace,
          'isHealthy': profile.isHealthy,
          'healthIssues': profile.healthIssues,
          'dateOfBirth': profile.dateOfBirth,
          'placeOfBirth': {'id': profile.placeOfBirth?.id, 'name': profile.placeOfBirth?.name, 'children': []},
          'dwellingPlace': {'id': profile.dwellingPlace?.id, 'name': profile.dwellingPlace?.name, 'children': []},
          'maritalStatus': profile.maritalStatus,
          'childPlanInFuture': profile.childPlanInFuture,
          'numOfMembersInFamily': profile.numOfMembersInFamily?.toInt() ?? 0,
          'numOfChildrenInFamily': profile.numOfChildrenInFamily?.toInt() ?? 0,
          'birthPositionInFamily': profile.birthPositionInFamily?.toInt() ?? 0,
          'ownDwelling': profile.ownDwelling,
          'knowledgeOfLanguages': profile.knowledgeOfLanguages,
          'skills': profile.skills,
          'bio': profile.bio,
          'requirements': profile.requirements,
          'profileState': profile.profileState,
          'location': null,
          'discoverability': null,
          'nationality': {'id': profile.nationality?.id},
          'genderTags': profile.genderTags?.map((e) => e.toJson()).toList(),
          'attachments': profile.attachments,
          'profilePictureType': profile.profilePictureType,
          'sharedWithUsers': profile.sharedWithUsers,
          'status': 'ACTIVE',
        },
      );
      await localSource.setProfileId(profileId: response.data['id']);
      return Right(response.data['photoLimit']);
    } on DioException catch (error, stacktrace) {
      log('DioException occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withDioError(error: error).failure);
    } catch (error, stacktrace) {
      log('Exception occurred: $error stacktrace: $stacktrace');
      return Left(ServerError.withError(message: error.toString()).failure);
    }
  }

  @override
  Future<Either<Failure, bool>> editProfile({required UserModel profile}) async {
    try {
      final Response response = await dio.put(
        '${Constants.baseUrl}${Urls.editProfile}${localSource.profileId}',
        options: Options(
          headers: {'Authorization': 'Bearer ${localSource.accessToken}'},
        ),
        data: {
          'id': localSource.profileId,
          'name': profile.name,
          'user': {'id': localSource.userId},
          'height': profile.height ?? 0,
          'weight': profile.weight ?? 0,
          'education': profile.education,
          'profession': profile.profession,
          'workPlace': profile.workPlace,
          'isHealthy': profile.isHealthy,
          'healthIssues': profile.healthIssues,
          'dateOfBirth': profile.dateOfBirth,
          'placeOfBirth': {'id': profile.placeOfBirth?.id, 'name': profile.placeOfBirth?.name, 'children': []},
          'dwellingPlace': {'id': profile.dwellingPlace?.id, 'name': profile.dwellingPlace?.name, 'children': []},
          'maritalStatus': profile.maritalStatus,
          'childPlanInFuture': profile.childPlanInFuture,
          'numOfMembersInFamily': profile.numOfMembersInFamily?.toInt() ?? 0,
          'numOfChildrenInFamily': profile.numOfChildrenInFamily?.toInt() ?? 0,
          'birthPositionInFamily': profile.birthPositionInFamily?.toInt() ?? 0,
          'ownDwelling': profile.ownDwelling,
          'knowledgeOfLanguages': profile.knowledgeOfLanguages,
          'skills': profile.skills,
          'bio': profile.bio,
          'requirements': profile.requirements,
          'profileState': profile.profileState,
          'location': null,
          'discoverability': null,
          'nationality': {'id': profile.nationality?.id},
          'genderTags': profile.genderTags?.map((e) => e.toJson()).toList(),
          'attachments': profile.attachments,
          'profilePictureType': profile.profilePictureType,
          'sharedWithUsers': profile.sharedWithUsers,
          'status': 'ACTIVE'
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
  Future<Either<Failure, bool>> postViewedApi({required String uuid}) async {
    try {
      final Response response = await dio.post(
        '${Constants.baseUrl}${Urls.profiles}/$uuid/viewed',
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
