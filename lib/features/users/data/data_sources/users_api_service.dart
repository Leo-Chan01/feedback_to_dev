import 'package:supabase_flutter/supabase_flutter.dart';

abstract class UsersApiService {
  Future<Map<String, dynamic>> logUserIn(String accessId);
}

class UsersApiServiceImpl implements UsersApiService {
  UsersApiServiceImpl(this.client);

  final SupabaseClient client;
  @override
  Future<Map<String, dynamic>> logUserIn(String accessId) async {
    try {
      final response = await client.functions.invoke(
        'access-login',
        body: {'access_id': accessId},
      );

      if (response.data == null) {
        throw Exception('No data returned from login function');
      }

      return response.data as Map<String, dynamic>;
    } on FunctionException catch (e) {
      String message = 'Login failed';
      if (e.details is Map) {
        final details = e.details as Map<String, dynamic>;
        message =
            (details['error'] ?? details['message'] ?? e.reasonPhrase)
                as String;
      } else {
        message = e.reasonPhrase ?? 'Unknown function error';
      }
      throw Exception(message);
    } catch (e) {
      throw Exception('Unexpected error during login: $e');
    }
  }
}
