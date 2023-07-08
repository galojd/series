import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:series/models/models.dart';

import '../screens/screens.dart';
import '../services/series_services.dart';

class SerieSearchDelegate extends SearchDelegate {
  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => 'Buscar Serie';
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      //Aqui esta el boton para borrar el texto de la busqueda
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          //en esa partede null puedo enviar otros datos en este caso envio null porque lo uso para cerrar y no recibe nada
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text('buildResult');
  }

  Widget _emptycontainer() {
    return Container(
      child: Center(
        child: Icon(
          Icons.movie_creation_outlined,
          color: Colors.white30,
          size: 160,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    if (query.isEmpty) {
      return _emptycontainer();
    }
    final servicioserie = Provider.of<SeriesService>(context, listen: false);
    servicioserie.getsuggestionsByQuery(query);
    return StreamBuilder(
      stream: servicioserie.suggestionStream,
      builder: (_, AsyncSnapshot<List<Series>> snapshot) {
        if (!snapshot.hasData) return _emptycontainer();

        final serie = snapshot.data;
        return ListView.builder(
            itemCount: serie!.length,
            itemBuilder: (context, index) =>
                _Sugerencia_busqueda(serie[index]));
      },
    );
  }
}

class _Sugerencia_busqueda extends StatelessWidget {
  final Series serielista;
  const _Sugerencia_busqueda(this.serielista);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage.assetNetwork(
        placeholder: 'assets/no-image.jpg',
        image: serielista.imagen!,
        fit: BoxFit.cover,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset('assets/no-image.jpg',
              fit: BoxFit.cover, width: 50);
        },
      ),
      title: Text(serielista.nombre),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Details_Screen_Sin(lista: serielista),
          ),
        );
      },
    );
  }
}
