import 'package:flutter/material.dart';
import 'package:movie/providers/movie_provider.dart';
import 'package:movie/search/search_delegate.dart';
import 'package:movie/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    final moviesPopular = Provider.of<MoviesProvider>(context);
    print(moviesProvider.onDisplayMovies);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Peliculas en Cine'),
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.search_outlined),
              onPressed: () =>
                  showSearch(context: context, delegate: MovieSearchDelegate()),
            )
          ],
        ),
        //El SingleChildScrollView permite hacer un scroll en nuestra columna
        body: SingleChildScrollView(
          //La Columnas nos permiten colocar widgets una debajo del otro
          child: Column(children: [
            //Targetas principales
            CardSwiper(movies: moviesProvider.onDisplayMovies),
            //Slider de peliculas
            MovieSlader(
                movies: moviesProvider.popularMovies,
                title: 'Populares',
                onNextPge: () => moviesProvider.getPopularMovies()),
          ]),
        ));
  }
}
