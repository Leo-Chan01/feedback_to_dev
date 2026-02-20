import 'package:feedback_to_vfd/core/constants/app_constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> initializeSupabase() async {
  await Supabase.initialize(
    url: AppConstants.appUrl,
    anonKey: AppConstants.publishableKey,
  );
}
