import 'package:flutter/material.dart';

class Menu_Usuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(
            children: [
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, 'details', arguments: 'serie'),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: const FadeInImage(
                    placeholder: AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(
                        'https://as01.epimg.net/meristation/imagenes/2020/10/07/noticias/1602057129_447711_1602057207_noticia_normal.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Text(
                'nombreserie',
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
