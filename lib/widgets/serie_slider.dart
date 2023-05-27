import 'package:flutter/material.dart';

import '../models/models.dart';

class Serie_Slider extends StatelessWidget {
  final List<CapituloRecord> listacapitulo;
  const Serie_Slider({super.key, required this.listacapitulo});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 330,
      //color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Text("Capitulos",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listacapitulo.length,
                  itemBuilder: ((context, index) =>
                      _Capitulo_poster(capitulo: listacapitulo[index]))))
        ],
      ),
    );
  }
}

class _Capitulo_poster extends StatelessWidget {
  final CapituloRecord capitulo;
  _Capitulo_poster({Key? key, required this.capitulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String nomcap = capitulo.nombre;
    String numcap = capitulo.numeroCapitulo.toString();
    return Container(
      width: 150,
      height: 300,
      //color: Colors.green,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'capitulo',
                arguments: 'capitulo de serie'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(capitulo.imagenurl!),
                  width: 150,
                  height: 220,
                  fit: BoxFit.cover),
            ),
          ),
          Text(
            '$nomcap :' 'capitulo $numcap',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
