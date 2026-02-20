import 'package:feedback_to_vfd/app/app.dart';
import 'package:feedback_to_vfd/bootstrap.dart';
import 'package:feedback_to_vfd/injection_container.dart';
import 'package:feedback_to_vfd/supabase_initialization.dart';

Future<void> main() async {
  await initializeSupabase();
  await getDependencies();

  await bootstrap(() => const App());
}
