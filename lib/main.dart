import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dishcord/firestore/repo/user_repo.dart';
import 'package:dishcord/log_in/auth/auth_service.dart';
import 'package:dishcord/log_in/user/user_creation_service.dart';
import 'package:dishcord/widgets/auth/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dishcord/widgets/auth/login_set.dart';
import 'package:dishcord/widgets/auth/signup_set.dart';
import 'package:dishcord/widgets/chatroom/chatroom.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(ChatApp(
  )
  );
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = "DISHCORD";
   // FirebaseCrashlytics.instance.crash();

    final authService =
    AuthService(FirebaseAuth.instance, UserCreationService(UserRepo()));
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => authService),
        ChangeNotifierProvider<LoginViewModel>(
            create: (_) => LoginViewModel(authService: authService)),
        ChangeNotifierProvider<SignUpViewModel>(
            create: (_) => SignUpViewModel(authService: authService)),
        StreamProvider(
          create: (context) => authService.authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(

          title: title,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.orange,
              inputDecorationTheme: InputDecorationTheme(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              )),
          routes: {
            "/login": (_) => new LoginPage(title: title),
          },
          home: AuthWrapper(title: title)),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  final String title;

  AuthWrapper({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return ChatRoomPage();
    }

    return LoginPage(title: title);
  }
}
