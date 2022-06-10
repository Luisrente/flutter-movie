import 'package:flutter/material.dart';
import 'package:movie/models/models.dart';

class MovieSlader extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final Function onNextPge;

  const MovieSlader(
      {Key? key, required this.movies, this.title, required this.onNextPge})
      : super(key: key);

  @override
  State<MovieSlader> createState() => _MovieSladerState();
}

class _MovieSladerState extends State<MovieSlader> {
  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      //print(scrollController.position.pixels);
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        widget.onNextPge();
      }
      print(scrollController.position.maxScrollExtent);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      // color: Colors.red,
      // el child va ser una column por que se necesita colocar widget una abajo del otro
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (this.widget.title != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(this.widget.title!,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          SizedBox(height: 5.0),
          Expanded(
            child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.movies.length,
                itemBuilder: (_, int index) => _MoviePoster(
                    widget.movies[index],
                    '${widget.title}-${index}-${widget.movies[index].id}')),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;
  final String heroId;

  const _MoviePoster(this.movie, this.heroId);

  @override
  Widget build(BuildContext context) {
    //Expanded toma todo el tamaño disponible del padre

    movie.heroId = heroId;

    return Container(
        height: 130,
        width: 130,
        // color: Colors.green,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          //GestureDetecor me sirve para disparar el metodo
          GestureDetector(
            //La navegacion
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                    placeholder: AssetImage('asset/no-image.jpg'),
                    image: NetworkImage(movie.fullPosterImg),
                    width: 130,
                    height: 190,
                    fit: BoxFit.cover),
              ),
            ),
          ),

          const SizedBox(height: 5),
          Text(movie.title,
              //maxLines para dividir el texto en dos lineas
              maxLines: 2,
              //overflow para mostrar unica mente el texto con espacio disponible
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center)
        ]));
  }
}
