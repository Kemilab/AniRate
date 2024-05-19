import 'package:ani_rate/pages/splash.dart';
import 'package:ani_rate/providers/anime_provider.dart';
import 'package:ani_rate/translations/codegen_loader.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(EasyLocalization(
    path: 'assets/translations',
    supportedLocales: [Locale('en'), Locale('hr')],
    fallbackLocale: Locale('en'),
    assetLoader: CodegenLoader(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AnimeProvider()
        ..loadCachedAnime()
        ..fetchAnime(),
      child: MaterialApp(
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        theme: ThemeData(
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
