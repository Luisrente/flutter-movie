import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/models.dart';
import 'package:movie/providers/providers.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final int movieId;

  const CastingCards(this.movieId);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
              height: 180,
              constraints: BoxConstraints(maxWidth: 150),
              child: CupertinoActivityIndicator());
        }
        final List<Cast> cast = snapshot.data!;
        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          //  color: Colors.red,
          height: 180,
          child: ListView.builder(
              itemCount: 10,
              //Para que la ubicacion sea orizontal
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, int index) => _CasCard(cast[index])),
        );
      },
    );
  }
}

class _CasCard extends StatelessWidget {
  final Cast actor;

  const _CasCard(this.actor);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: 110,
        height: 100,
        // color: Colors.green,
        child: Column(children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                  placeholder: AssetImage('asset/no-image.jpg'),
                  image: NetworkImage(actor.fullprofilePath),
                  height: 140,
                  width: 100,
                  fit: BoxFit.cover)),
          SizedBox(height: 5),
          Text(actor.name,
              maxLines: 2,
              //El textOverflow.ellipsis cuando es texto tiene mucho tamaña se colaca ...
              overflow: TextOverflow.ellipsis,
              //Para centrar el texto dentro de un Widgets Text
              textAlign: TextAlign.center)
        ]));
  }
}
