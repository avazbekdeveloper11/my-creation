// import 'dart:developer';
// import 'dart:io';
// import 'dart:isolate';
//
// import 'package:dio/dio.dart';
// import 'package:http_parser/http_parser.dart';
//
// Future<bool> uploadFileImage({required File file, required String url}) async => Isolate.run<bool>(
//       () async {
//         try {
//           RequestOptions setStreamType<T>(RequestOptions requestOptions) {
//             if (T != dynamic &&
//                 !(requestOptions.responseType == ResponseType.bytes ||
//                     requestOptions.responseType == ResponseType.stream)) {
//               if (T == String) {
//                 requestOptions.responseType = ResponseType.plain;
//               } else {
//                 requestOptions.responseType = ResponseType.json;
//               }
//             }
//             return requestOptions;
//           }
//
//           final Dio dio = Dio();
//           const extra = <String, dynamic>{};
//           final data = FormData();
//
//           final String fileName = file.path.split('/').last;
//           final String type = file.path.split('.').last;
//           data.files.add(
//             MapEntry(
//               'file',
//               MultipartFile.fromBytes(
//                 file.readAsBytesSync(),
//                 filename: fileName,
//                 contentType: MediaType(
//                   'image',
//                   type,
//                 ),
//               ),
//             ),
//           );
//           final result = await dio.fetch<Map<String, dynamic>>(
//             setStreamType<void>(
//               Options(
//                 method: 'PUT',
//                 extra: extra,
//               )
//                   .compose(
//                     dio.options,
//                     'upload',
//                     // queryParameters: {'project-id': Constants.projectId},
//                     data: data,
//                   )
//                   .copyWith(
//                     baseUrl: url,
//                   ),
//             ),
//           );
//           if (result.statusCode == 200 || result.statusCode == 201) {
//             return result.statusCode == 200 || result.statusCode == 201;
//           } else {
//             return false;
//           }
//         } on Exception catch (e, s) {
//           log('uploadFile error: $e $s');
//           return false;
//         }
//       },
//     );
