part of 'image_upload_bloc.dart';

class ImageUploadState extends Equatable {
  const ImageUploadState({
    this.apiStatus = ApiStatus.none,
    this.imageUploadStatus = ApiStatus.none,
    this.images = const [],
    this.message = '',
  });

  final ApiStatus apiStatus;
  final ApiStatus imageUploadStatus;
  final List<ImageModel> images;
  final String message;

  ImageUploadState copyWith({
    ApiStatus? apiStatus,
    List<ImageModel>? images,
    ApiStatus? imageUploadStatus,
    String? message,
  }) {
    return ImageUploadState(
      apiStatus: apiStatus ?? this.apiStatus,
      imageUploadStatus: imageUploadStatus ?? this.imageUploadStatus,
      images: images ?? this.images,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        apiStatus,
        images,
        imageUploadStatus,
        message,
      ];
}
