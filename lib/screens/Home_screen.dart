import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Search/Search_delegate.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';

class Home_Screen extends StatelessWidget {
  const Home_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final servicioserie = Provider.of<SeriesService>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Series"),
          elevation: 0,
          actions: [
            IconButton(
                //aqui conectare el boton de busqueda con un Search_delegate
                onPressed: () => showSearch(
                    context: context, delegate: SerieSearchDelegate()),
                icon: const Icon(Icons.search_outlined)),
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
              card_swipper_sin(lista: servicioserie.serie),
              //Text("Monster hunter world"),
              SizedBox(
                height: 40,
              ),
              Serie_Slider_sin(listacapitulo: servicioserie.capitulo)
            ],
          ),
        ));
  }
}
