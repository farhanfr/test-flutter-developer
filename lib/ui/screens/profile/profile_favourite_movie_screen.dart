import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_flutter_developer_enterkomputer/data/blocs/user/watchlist_favourite_movies/watchlist_favourite_movies_bloc.dart';
import 'package:test_flutter_developer_enterkomputer/data/models/models.dart';
import 'package:test_flutter_developer_enterkomputer/ui/screens/product/product_detail_screen.dart';
import 'package:test_flutter_developer_enterkomputer/ui/widgets/empty_data_widget.dart';
import 'package:test_flutter_developer_enterkomputer/ui/widgets/widgets.dart';
import 'package:test_flutter_developer_enterkomputer/utils/extensions.dart';

class ProfileFavouriteMovieScreen extends StatefulWidget {
  const ProfileFavouriteMovieScreen({super.key});

  @override
  State<ProfileFavouriteMovieScreen> createState() =>
      _ProfileFavouriteMovieScreenState();
}

class _ProfileFavouriteMovieScreenState
    extends State<ProfileFavouriteMovieScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();

  /// deklarasi bloc (cubit) untuk dilakukan pengambilan data favorit film user
  late WatchlistFavouriteMoviesBloc _favoriteMoviesBloc;

  /// deklarasi dan inisialisasi controller untuk package pull to refresh
  RefreshController _availableMovieCtrl = RefreshController();
  /// deklarasi variabel dan inisialisasi untuk menampung halaman pada pagination
  int currentPageAvailableMovie = 1;
  /// deklarasi variabel dan inisialisasi untuk menampung list film yang favorit
  List<Movie> availableMovies = [];
  /// deklarasi variabel dan inisialisasi untuk menampung status loading
  bool _initialLoadingAvailableMovie = true;

  bool isSwitchFilter = true;

  @override
  void initState() {
    /// mengisi variabel _watchlistMoviesBloc dengan event yang digunakan pada bloc
    /// yaitu OnFavouriteMovie()
    _favoriteMoviesBloc = WatchlistFavouriteMoviesBloc()
      ..add(OnFavouriteMovie(currentPageAvailableMovie));
    super.initState();
  }

  /// fungsi yang digunakan untuk dijalankan saat terjadi refresh pada package pull to refresh
  void _onRefresh() {
    Future.delayed(const Duration(milliseconds: 2009)).then((val) {
      _availableMovieCtrl.refreshCompleted();
    });
  }

   /// fungsi yang digunakan untuk dijalankan saat terjadi loading pada package pull to refresh
   /// dilakukan penambahan halaman pada pagination dan menjalankan event OnFavouriteMovie()
  void _onLoading() {
    Future.delayed(const Duration(milliseconds: 2009)).then((val) {
      setState(() {
        currentPageAvailableMovie++;
        _favoriteMoviesBloc.add(OnFavouriteMovie(currentPageAvailableMovie));
      });
    });
  }

  @override
  void dispose() {
    /// menutup bloc agar tidak membebani memori aplikasi
    _favoriteMoviesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: BlocProvider(
        create: (context) => _favoriteMoviesBloc,
        child: BlocListener( /// fungsi yang digunakan untuk mengetahui state yang dijalankan dari bloc (WatchlistFavouriteMoviesBloc)
          bloc: _favoriteMoviesBloc,
          listener: (context, state) {
            /// Jika state success, maka dilakukan penambahan data film favorit pada list
            /// status loading di set ke false
            if (state is WatchlistFavouriteMoviesSuccess) {
              setState(() {
                availableMovies.addAll(state.movie);
                _availableMovieCtrl.loadComplete();
                _initialLoadingAvailableMovie = false;
              });
            }
            /// Jika state failure, maka dimunculkan notifikasi (snackbar) dan status loading di set ke false
            if (state is WatchlistFavouriteMoviesFailure) {
              setState(() {
                _initialLoadingAvailableMovie = false;
              });
              showSnackbar(context, message: state.message);
            }
          },
          child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text("My Favourite Movie"),
              centerTitle: true,
            ),
            body: !_initialLoadingAvailableMovie /// Jika status loading true dan
                ? availableMovies.isNotEmpty /// Jika list film favorit tidak kosong
                    ? SmartRefresher( /// tampilkan data dengan widget/component dari pull to refresh
                        enablePullDown: false,
                        enablePullUp: true,
                        controller: _availableMovieCtrl,
                        onRefresh: _onRefresh,
                        footer: CustomFooter(
                          loadStyle: LoadStyle.ShowWhenLoading,
                          height: 100,
                          builder: (context, mode) {
                            Widget body;
                            if (mode == LoadStatus.idle) {
                              body = Icon(Icons.refresh);
                            } else if (mode == LoadStatus.loading) {
                              body = CircularProgressIndicator();
                            } else if (mode == LoadStatus.canLoading) {
                              body = Icon(Icons.refresh);
                            } else {
                              body = Text("No more Data");
                            }
                            return Container(
                              height: 55,
                              child: Center(
                                child: body,
                              ),
                            );
                          },
                        ),
                        onLoading: _onLoading,
                        child: MasonryGridView.count(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 13,
                          crossAxisSpacing: 13,
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                          itemCount: availableMovies.length,
                          itemBuilder: (BuildContext context, int index) {
                            final data = availableMovies[index];
                            return CardProduct(
                              movie: data,
                              onTap: (){
                                pushScreen(context, ProductDetailScreen(movieId: data.id));
                              },
                            );
                          },
                        ),
                      )
                    : Center( /// jika list film favorit kosong maka menampilkan widget EmptyDataWidget
                        child: EmptyDataWidget(
                            title: "Favourite Empty",
                            subtitle: "Please add favourite movie first"),
                      )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ),
      ),
    );
  }
}
