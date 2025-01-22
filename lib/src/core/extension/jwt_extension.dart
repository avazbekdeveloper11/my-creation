part of 'extension.dart';

extension JWTExtension on String {
  static Map<String, dynamic> decodeToken(String token) {
    final splitToken = token.split(".");
    if (splitToken.length != 3) {
      throw FormatException('Invalid token');
    }
    try {
      final payloadBase64 = splitToken[1];
      final normalizedPayload = base64.normalize(payloadBase64);
      final payloadString = utf8.decode(base64.decode(normalizedPayload));
      final decodedPayload = jsonDecode(payloadString);

      return decodedPayload;
    } catch (error) {
      throw FormatException('Invalid payload');
    }
  }
}
