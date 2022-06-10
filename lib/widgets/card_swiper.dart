import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/models.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  const CardSwiper({Key? key, required this.movies}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //Para tomasr el 50% de la pantalla utilizamos el mediaquery
    // nos facilita la informacion des sispositivo donde esta corriendo
    //dimensiones, orientacion

    final size = MediaQuery.of(context).size;
    // Le pasamos como parametro el context
    // el context es el arbol de widgets el cual sabe como se encuentran construidos
    // sabe todo sobre los widgets que hay antes

    if (this.movies.length == 0) {
      return Container(
          width: double.infinity,
          height: size.height * 0.5,
          child: const Center(
            child: CircularProgressIndicator(),
          ));
    }

    return Container(
        width: double.infinity,
        height: size.height * 0.5,
        //color: Colors.green,
        child: Swiper(
            itemCount: movies.length,
            layout: SwiperLayout.STACK,
            itemWidth: size.width * 0.6,
            itemHeight: size.height * 0.4,
            //Builder significa que algo se va estar construyendo de manera dinamica o cuando sea necesario
            itemBuilder: (_, int index) {
              //FadeInImage es para hacer una animacion de entrada que se mire bonita
              final movie = movies[index];

              movie.heroId= 'swiper-${movie.id}';

              return GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, 'details', arguments: movie),
                //El ClipRRect me permite agregar un borderRedius
                child: Hero(
                  tag: movie.heroId!,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FadeInImage(
                        placeholder: AssetImage('asset/no-image.jpg'),
                        //placeholder:NetworkImage('https://via.placeholder.com/300x400'),
                        image: NetworkImage(movie.fullPosterImg),
                        //El fit es para adaptar el tamaño del contenedor padre
                        fit: BoxFit.cover),
                  ),
                ),
              );
            }));
  }
}
