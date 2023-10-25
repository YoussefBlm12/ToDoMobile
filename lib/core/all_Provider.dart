

import 'package:provider/provider.dart';
import 'package:todo/core/provider/task_provider.dart';

import '../app.dart';

class AllProvider {
  static MultiProvider providers = MultiProvider(
    providers: [
     ChangeNotifierProvider<TaskProvider>(
          create: (_) => TaskProvider()),
    ],
    child: const MyApp(),
  );
}
