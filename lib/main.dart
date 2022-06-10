import 'package:flutter/material.dart';
import 'package:movie/providers/movie.dart';
import 'package:movie/providers/movie_provider.dart';
import 'package:movie/screens/screens.dart';
import 'package:movie/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

//Este widgets fue creado para mantener nuestro servicio
class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //MultiProvider  en caso que se necesite mas de uno
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesProvider(), lazy: false),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        //cuando se crea la aplicacion se monta esa ruta es la ruta inicial
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomeScreen(),
          'details': (_) => const DetailsScreen()
        },
        theme: AppTheme.ligthTheme);
  }
}
