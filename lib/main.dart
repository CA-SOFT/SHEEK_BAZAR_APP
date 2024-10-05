import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sheek_bazar/config/themes/cubit/themes_cubit.dart';
import 'package:sheek_bazar/features/introductions_screens/splash_screen.dart';
import 'package:sheek_bazar/firebase_options.dart';
import 'package:sheek_bazar/kurdish_material.dart';
import 'package:sheek_bazar/kurdish_widget.dart';
import 'Locale/app_localization.dart';
import 'Locale/cubit/locale_cubit.dart';
import 'bloc_provider.dart';
import 'config/themes/app_themes.dart';
import 'core/utils/app_logger.dart';
import 'core/utils/cache_helper.dart';
import 'injection_container.dart' as di;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';

Future<void> createChannel(AndroidNotificationChannel channel) async {
  final FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();
  try {
    await plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  } catch (e) {
    logger.e("Failed to create notification channel: $e");
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle background message
  logger.i("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // Initialize dependency injection
  await CacheHelper.init(); // Initialize cache helper

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Set background messaging handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize Firebase Messaging without requesting explicit permissions
  await _setupFirebaseMessaging();

  // Set preferred orientations and run the app
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

Future<void> _setupFirebaseMessaging() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Retrieve APNS token (for iOS)
  String? token = await messaging.getAPNSToken();
  logger.i("APNS Token: $token");

  // Initialize Local Notifications
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('@mipmap/launcher_icon');
  const DarwinInitializationSettings darwinInitializationSettings = DarwinInitializationSettings();
  const InitializationSettings initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
    iOS: darwinInitializationSettings,
  );

  // Create Notification Channel
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'messages',
    'Messages',
    description: 'This is Flutter Firebase',
    importance: Importance.max,
  );

  await createChannel(channel); // Ensure the channel is created
  await flutterLocalNotificationsPlugin.initialize(initializationSettings); // Initialize notifications

  // Handle foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    logger.i(event.notification);

    final notification = event.notification;
    final android = event.notification?.android;

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: android.smallIcon,
          ),
        ),
      );
    }
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return blocMultiProvider(
      child: BlocBuilder<LocaleCubit, ChangeLocaleState>(
        builder: (context, state) {
          return BlocBuilder<ThemesCubit, ThemesState>(
            builder: (context, value) {
              return ScreenUtilInit(
                designSize: const Size(1080, 2400),
                builder: (_, child) {
                  return MaterialApp(
                    theme: value.mode == "dark"
                        ? darkTheme(state.locale.languageCode)
                        : appTheme(state.locale.languageCode),
                    locale: state.locale,
                    supportedLocales: const [
                      Locale("en"),
                      Locale("ar"),
                      Locale("ku"),
                    ],
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                      KurdishMaterialLocalizations.delegate,
                      KurdishWidgetLocalizations.delegate,
                    ],
                    localeResolutionCallback: (deviceLocal, supportedLocales) {
                      for (var locale in supportedLocales) {
                        if (deviceLocal != null &&
                            deviceLocal.languageCode == locale.languageCode) {
                          return deviceLocal;
                        }
                      }
                      return supportedLocales.first;
                    },
                    title: 'Sheek Bazar',
                    debugShowCheckedModeBanner: false,
                    home: const SplashScreen(),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
