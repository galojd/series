import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:series/Search/Search_delegate_log.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';

class Home_Screen_Log extends StatefulWidget {
  @override
  State<Home_Screen_Log> createState() => _Home_Screen_LogState();
}

class _Home_Screen_LogState extends State<Home_Screen_Log> {
  @override
  Widget build(BuildContext context) {
    final servicioserie = Provider.of<SeriesService>(context, listen: false);
    final authservice = Provider.of<AuthService>(context, listen: false);
    final FlutterSecureStorage storage = FlutterSecureStorage();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Series"),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () => showSearch(
                    context: context, delegate: SerieSearchDelegate_log()),
                icon: const Icon(Icons.search_outlined)),
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
              onSelected: (value) async {
                if (value == 10) {
                  String usuarioId = await storage.read(key: 'userid') ??
                      'no hay no exite'; // Obtén el ID de usuario correspondiente
                  await servicioserie.ListandoUsuarioSerie(usuarioId);
                  Navigator.pushNamed(context, 'Actualiza');
                } else {
                  String usuarioId = await storage.read(key: 'userid') ??
                      'no hay no exite'; // Obtén el ID de usuario correspondiente
                  await servicioserie.ListandoUsuarioSerie(usuarioId);
                  Navigator.pushNamed(context, 'menu_usuario');
                }
              },
            ),
            IconButton(
                onPressed: () {
                  authservice.logout();
                  Navigator.pushReplacementNamed(context, 'loading');
                },
                icon: const Icon(Icons.logout)),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              card_swipper(lista: servicioserie.serie),
              //Text("Monster hunter world"),
              SizedBox(
                height: 40,
              ),
              Serie_Slider(listacapitulo: servicioserie.capitulo)
            ],
          ),
        ));
  }
}
