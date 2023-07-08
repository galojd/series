import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:series/screens/screens.dart';
import 'package:series/services/Auth_service.dart';

class CheckAuthScreen extends StatelessWidget {
  static String checkea = 'check';
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authservice = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: FutureBuilder(
        future: authservice.readtoken(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) return Text('Espere');

          Future.microtask(() {
            Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                    pageBuilder: (_, __, ___) =>
                        snapshot.data == '' ? const Login() : Home_Screen_Log(),
                    transitionDuration: const Duration(seconds: 0)));
          });

          return Container();
        },
      ),
    );
  }
}
