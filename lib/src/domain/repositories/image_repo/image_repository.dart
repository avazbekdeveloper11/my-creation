import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/services.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/core/constants/constants.dart';
import 'package:sovchilar_mobile/src/data/models/image/image_model.dart';
import 'package:sovchilar_mobile/src/domain/failure/failure.dart';
import 'package:sovchilar_mobile/src/domain/failure/server_error.dart';

part 'image_repository_impl.dart';

abstract class ImageRepository {
  const ImageRepository();

  Future<Either<Failure, List<ImageModel>>> getImageUrl({String? profileId});

  Future<Either<Failure, bool>> imageUpload({
    required File image,
    bool isVeification = false,
  });

  Future<Either<Failure, bool>> deleteImage(String id);
}
