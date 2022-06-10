import 'package:flutter/material.dart';
import 'package:movie/models/models.dart';
import 'package:movie/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);
  // El que key sirve para identificar el widgets dentro del arbol de widgets
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    print(movie.title);

    return Scaffold(
        body: CustomScrollView(slivers: [
      //los slivers no son mas que widget que tienen cierto comportamiento programado cuando se hace scroll en el contenido del padre
      _CustomAppBar(movie),
      SliverList(
          delegate: SliverChildListDelegate([
        _PosterAndTile(movie),
        _OverView(movie),
        _OverView(movie),
        _OverView(movie),
        CastingCards(movie.id)
      ]))
    ]));
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomAppBar(this.movie);
  @override
  Widget build(BuildContext context) {
    final TextTheme texttheme = Theme.of(context).textTheme;
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        //Para quitar el padding
        titlePadding: const EdgeInsets.all(0),
        title: Container(
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            color: Colors.black12,
            padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
            child: Text(movie.title, style: const TextStyle(fontSize: 16))),
        background: FadeInImage(
            placeholder: const AssetImage('asset/no-image.jpg'),
            image: NetworkImage(movie.fullBackdropPath),
            //BoxFit es para que se expanda sin perder las dimensiones
            fit: BoxFit.cover),
      ),
    );
  }
}

class _PosterAndTile extends StatelessWidget {
  final Movie movie;
  const _PosterAndTile(this.movie);
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                    placeholder: const AssetImage('asset/no-image.jpg'),
                    image: NetworkImage(movie.fullPosterImg),
                    height: 150)),
          ),
          SizedBox(width: 20),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title,
                    style: Theme.of(context).textTheme.headline5,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2),
                Text(movie.originalTitle,
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2),
                Row(children: [
                  Icon(Icons.star_outline, size: 15, color: Colors.yellow),
                  SizedBox(width: 5),
                  Text('${movie.voteAverage}'),
                ])
              ],
            ),
          )
        ]));
  }
}

class _OverView extends StatelessWidget {
  final Movie movie;

  const _OverView(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Text(
          movie.overview,
          //Para que el texto quede cuadrado
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.subtitle1,
        ));
  }
}
