import 'package:feedback_to_vfd/app/app.dart';
import 'package:feedback_to_vfd/bootstrap.dart';
import 'package:feedback_to_vfd/supabase_initialization.dart';

Future<void> main() async {
  await initializeSupabase();

  await bootstrap(() => const App());
}
