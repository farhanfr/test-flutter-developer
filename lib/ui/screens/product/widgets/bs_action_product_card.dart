import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_developer_enterkomputer/data/blocs/movie/bloc/add_favorite_watchlist_movie_bloc.dart';
import 'package:test_flutter_developer_enterkomputer/data/models/models.dart';
import 'package:test_flutter_developer_enterkomputer/ui/screens/product/product_download_image_screen.dart';
import 'package:test_flutter_developer_enterkomputer/utils/extensions.dart';
import 'package:test_flutter_developer_enterkomputer/utils/textstyles.dart';

class BottomSheetActionProductCard {
  const BottomSheetActionProductCard();

  static Future show(BuildContext context, {required Movie movie}) async {
    double _screenWidth = MediaQuery.of(context).size.width;
    await showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: _screenWidth * (15 / 100),
                  height: 7,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(7.5 / 2),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Menu Product",
                  style: latoBold,
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                    title: Text(
                      "See Detail",
                      style: latoRegular,
                    ),
                    onTap: () {}),
                ListTile(
                    title: Text(
                      "Add to watchlist",
                      style: latoRegular,
                    ),
                    onTap: () {
                      context
                          .read<AddFavoriteWatchlistMovieBloc>()
                          .add(OnAddWatchlist(movie.id));
                          popScreen(context);
                    }),
                ListTile(
                    title: Text(
                      "Add to favorite",
                      style: latoRegular,
                    ),
                    onTap: () {
                      context
                          .read<AddFavoriteWatchlistMovieBloc>()
                          .add(OnAddFavorite(movie.id));
                          popScreen(context);
                    }),
                ListTile(
                    title: Text(
                      "Download image movie",
                      style: latoRegular,
                    ),
                    onTap: () {
                     pushScreen(context, ProductDownloadImageScreen(pathImage: movie.posterPath,));
                    })
              ],
            ),
          );
        });
    return;
  }
}
