import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class Home_Screen extends StatelessWidget {
  const Home_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Series"),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.search_outlined)),
            IconButton(
                onPressed: () => Navigator.pushNamed(context, 'login',
                    arguments: 'loguearme'),
                icon: const Icon(Icons.login))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              card_swipper(),
              Text("Monster hunter world"),
              SizedBox(
                height: 40,
              ),
              Serie_Slider()
            ],
          ),
        ));
  }
}
