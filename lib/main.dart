import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:series/services/services.dart';
import 'package:series/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthService(),
        ),
        ChangeNotifierProvider(
          create: (_) => SeriesService(),
        ),
      ],
      child: MaterialApp(
          title: 'Material App',
          debugShowCheckedModeBanner: false,
          initialRoute: 'loading',
          routes: {
            'home': (_) => const Home_Screen(),
            //'details': (__) => const Details_Screen(),
            //'capitulo': (___) => Capitulo_screen(),
            'capit': (context) => SamplePlayer_screen(),
            'login': (____) => const Login(),
            'registrar': (_______) => const Registrar(),
            'home2': (________) => Home_Screen_Log(),
            'menu_usuario': (_____) => Menu_Usuario(),
            'Actualiza': (context_) => const Actualizar(),
            'cheching': (cont_) => const CheckAuthScreen(),
            'loading': (con_) => LoadingScreen()
          },
          theme: ThemeData.dark()),
    );
  }
}
