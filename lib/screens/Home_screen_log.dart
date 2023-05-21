import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class Home_Screen_Log extends StatelessWidget {
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
                onPressed: () => Navigator.pushNamed(context, 'menu_usuario',
                    arguments: 'usuario'),
                icon: const Icon(Icons.system_security_update_good_sharp)),
            PopupMenuButton(
              icon: Icon(Icons.arrow_downward),
              tooltip: 'menu',
              itemBuilder: (context) {
                return const [
                  PopupMenuItem<int>(
                    value: 10,
                    child: Text('Actualizar datos'),
                  ),
                  PopupMenuItem<int>(
                    value: 20,
                    child: Text('Favoritos'),
                  ),
                ];
              },
              onSelected: (value) {
                if (value == 10) {
                  Navigator.pushNamed(context, 'Actualiza');
                } else {
                  Navigator.pushNamed(context, 'menu_usuario');
                }
              },
            )
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
