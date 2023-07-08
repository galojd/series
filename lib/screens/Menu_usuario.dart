import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../services/services.dart';
import '../screens/screens.dart';

//Aqui estan listados los favoritos que indico al dar siguiendo a alguna serie
class Menu_Usuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final servicioserie = Provider.of<SeriesService>(context, listen: false);
    final FlutterSecureStorage storage = FlutterSecureStorage();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: servicioserie.usuariodeserie.length,
        itemBuilder: (context, index) {
          String nombre = servicioserie.usuariodeserie[index].nombre;
          String imagen = servicioserie.usuariodeserie[index].imagen!;
          String idserie = servicioserie.usuariodeserie[index].serieId;
          return Column(
            children: [
              GestureDetector(
                onTap: () async {
                  String usuarioId = await storage.read(key: 'userid') ??
                      'no hay no exite'; // Obtén el ID de usuario correspondiente
                  await servicioserie.ListandoUsuarioSerie(usuarioId);
                  await servicioserie.Mostrardatosdeserie(idserie);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Details_Screen(
                            lista: servicioserie.serie1.first);
                      },
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  width: 300, // Ancho deseado del Container
                  height: 300, // Altura deseada del Container
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/no-image.jpg',
                      image: imagen,
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/no-image.jpg',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
              ),
              Text(
                nombre,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
            ],
          );
        },
      ),
    );
  }
}
