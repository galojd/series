import 'package:flutter/material.dart';

class Serie_Slider extends StatelessWidget {
  const Serie_Slider({super.key});

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
              child: Text("capitulos",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 20,
                  itemBuilder: ((context, index) => const _Capitulo_poster())))
        ],
      ),
    );
  }
}

class _Capitulo_poster extends StatelessWidget {
  const _Capitulo_poster({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              child: const FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(
                      'https://res.cloudinary.com/dlwu0vkrp/image/upload/v1672766668/lx973auyzvgpishbzym4.jpg'),
                  width: 150,
                  height: 220,
                  fit: BoxFit.cover),
            ),
          ),
          const Text(
            'batman el caballero de la noche : cap 1',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
