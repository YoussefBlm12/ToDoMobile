import 'package:flutter_dotenv/flutter_dotenv.dart';


/// ENVIRONEMENT
final bool production = dotenv.env['PRODUCTION'] == 'true';
final String messageID = dotenv.env['MESSAGE_ID'] ?? 'MOBILE';

/// API
final String? port = dotenv.env['PORT'];
final String? apiUrl = dotenv.env['API_URL'];
final String? apiVersion = dotenv.env['API_VERSION'];
final String apiBase = '$apiUrl';

class Credential {

  static int? id;
  static String? username;
  static String? token;
  static int? idExploitation = 0;
  static String? status;
  static String? role;
  static String? verificationProgress;
  static String? type;
  static int? centerId;
}
