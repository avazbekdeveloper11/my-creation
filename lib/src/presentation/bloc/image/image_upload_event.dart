part of 'image_upload_bloc.dart';

sealed class ImageUploadEvent extends Equatable {
  const ImageUploadEvent();
}

class GetImageUrlEvent extends ImageUploadEvent {
  const GetImageUrlEvent();

  @override
  List<Object?> get props => [];
}

class UploadImageEvent extends ImageUploadEvent {
  const UploadImageEvent({
    required this.file,
    this.isVerification = false,
  });

  final File file;
  final bool isVerification;

  @override
  List<Object?> get props => [file, isVerification];
}
