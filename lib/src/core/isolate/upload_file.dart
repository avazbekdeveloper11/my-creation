// import 'dart:io';
// import 'dart:isolate';
//
// import 'package:dio/dio.dart';
// import 'package:http_parser/http_parser.dart';
//
// Future<bool> uploadFile(File file, {required String url}) async {
//   return Isolate.run<bool>(
//     () async {
//       try {
//         RequestOptions setStreamType<T>(RequestOptions requestOptions) {
//           if (T != dynamic &&
//               !(requestOptions.responseType == ResponseType.bytes ||
//                   requestOptions.responseType == ResponseType.stream)) {
//             if (T == String) {
//               requestOptions.responseType = ResponseType.plain;
//             } else {
//               requestOptions.responseType = ResponseType.json;
//             }
//           }
//           return requestOptions;
//         }
//
//         Dio dio = Dio();
//         const extra = <String, dynamic>{};
//         final queryParameters = <String, dynamic>{};
//         final data = FormData();
//
//         String fileName = file.path.split('/').lastOrNull ?? '';
//         String type = file.path.split('.').lastOrNull ?? '';
//         data.files.add(
//           MapEntry(
//             'file',
//             MultipartFile.fromBytes(
//               file.readAsBytesSync(),
//               filename: fileName,
//               contentType: MediaType(
//                 type == 'jpg' || type == 'png' ? 'image' : 'document',
//                 type,
//               ),
//             ),
//           ),
//         );
//         final result = await dio.fetch<Map<String, dynamic>>(
//           setStreamType<void>(
//             Options(
//               method: 'PUT',
//               extra: extra,
//             )
//                 .compose(
//                   dio.options,
//                   '',
//                   queryParameters: queryParameters,
//                   data: data,
//                 )
//                 .copyWith(
//                   baseUrl: url,
//                 ),
//           ),
//         );
//         if (result.statusCode == 200 || result.statusCode == 201) {
//           return (result.statusCode == 200 || result.statusCode == 201);
//         } else {
//           return false;
//         }
//       } catch (error) {
//         return false;
//       }
//     },
//   );
// }
