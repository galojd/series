import 'package:flutter/material.dart';

class lista_Cap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      width: double.infinity,
      height: 180,
      child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => _ListaCapitulos()),
    );
  }
}

class _ListaCapitulos extends StatelessWidget {
  const _ListaCapitulos({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      color: Colors.green,
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'capitulo',
                arguments: 'Armadura de alatreon'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(
                    'https://www.monsterhunter.com/world-iceborne/topics/alatreon/images/img07.jpg'),
                height: 140,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Text(
            'Armadura de Alatreon',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
