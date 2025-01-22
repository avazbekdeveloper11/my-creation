import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sovchilar_mobile/src/config/router/app_routes.dart';
import 'package:sovchilar_mobile/src/core/constants/api_status.dart';

import 'package:sovchilar_mobile/src/data/models/image/image_model.dart';
import 'package:sovchilar_mobile/src/domain/failure/failure.dart';
import 'package:sovchilar_mobile/src/domain/repositories/image_repo/image_repository.dart';

part 'image_upload_event.dart';

part 'image_upload_state.dart';

class ImageUploadBloc extends Bloc<ImageUploadEvent, ImageUploadState> {
  ImageUploadBloc(this.imageRepository) : super(const ImageUploadState()) {
    on<GetImageUrlEvent>(_getImageUrlEvent);
    on<UploadImageEvent>(_uploadImageEvent);
  }

  final ImageRepository imageRepository;

  Future<void> _getImageUrlEvent(GetImageUrlEvent event, Emitter<ImageUploadState> emit) async {
    emit(state.copyWith(imageUploadStatus: ApiStatus.loading));
    final result = await imageRepository.getImageUrl();

    result.fold(
      (error) => emit(
        state.copyWith(
          apiStatus: ApiStatus.error,
          imageUploadStatus: ApiStatus.none,
          message: (error as ServerFailure).message,
        ),
      ),
      (images) => emit(
        state.copyWith(
          images: images,
          apiStatus: ApiStatus.success,
          imageUploadStatus: ApiStatus.success,
        ),
      ),
    );
  }

  Future<void> _uploadImageEvent(UploadImageEvent event, Emitter<ImageUploadState> emit) async {
    emit(state.copyWith(imageUploadStatus: ApiStatus.loading));

    final result = await imageRepository.imageUpload(image: event.file, isVeification: event.isVerification);

    result.fold(
      (error) => emit(state.copyWith(
        imageUploadStatus: ApiStatus.error,
        message: (error as ServerFailure).message,
      )),
      (success) {
        localSource.setVerified(isVerified: true);
        emit(state.copyWith(imageUploadStatus: ApiStatus.success));
        add(GetImageUrlEvent());
      },
    );
  }
}
