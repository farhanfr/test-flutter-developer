import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_flutter_developer_enterkomputer/data/blocs/user/watchlist_favourite_movies/watchlist_favourite_movies_bloc.dart';
import 'package:test_flutter_developer_enterkomputer/data/models/models.dart';
import 'package:test_flutter_developer_enterkomputer/ui/widgets/empty_data_widget.dart';
import 'package:test_flutter_developer_enterkomputer/ui/widgets/widgets.dart';
import 'package:test_flutter_developer_enterkomputer/utils/extensions.dart';

class ProfileWatchlistMovieScreen extends StatefulWidget {
  const ProfileWatchlistMovieScreen({super.key});

  @override
  State<ProfileWatchlistMovieScreen> createState() =>
      _ProfileWatchlistMovieScreenState();
}

class _ProfileWatchlistMovieScreenState
    extends State<ProfileWatchlistMovieScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  late WatchlistFavouriteMoviesBloc _watchlistMoviesBloc;

  //Produk Tersedia
  RefreshController _availableMovieCtrl = RefreshController();
  int currentPageAvailableMovie = 1;
  List<Movie> availableMovies = [];
  bool _initialLoadingAvailableMovie = true;

  bool isSwitchFilter = true;

  @override
  void initState() {
    _watchlistMoviesBloc = WatchlistFavouriteMoviesBloc()
      ..add(OnWatchlistMovie(currentPageAvailableMovie));
    super.initState();
  }

  void _onRefresh() {
    Future.delayed(const Duration(milliseconds: 2009)).then((val) {
      _availableMovieCtrl.refreshCompleted();
    });
  }

  void _onLoading() {
    Future.delayed(const Duration(milliseconds: 2009)).then((val) {
      // _fetchAllProductsCubit.load(currentPage: 1);
      setState(() {
        currentPageAvailableMovie++;
        _watchlistMoviesBloc.add(OnWatchlistMovie(currentPageAvailableMovie));
      });
    });
  }

  @override
  void dispose() {
    _watchlistMoviesBloc.close();
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
        create: (context) => _watchlistMoviesBloc,
        child: BlocListener(
          bloc: _watchlistMoviesBloc,
          listener: (context, state) {
            if (state is WatchlistFavouriteMoviesSuccess) {
              setState(() {
                availableMovies.addAll(state.movie);
                _availableMovieCtrl.loadComplete();
                _initialLoadingAvailableMovie = false;
              });
            }
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
              title: Text("My Watchlist Movie"),
              centerTitle: true,
            ),
            body: !_initialLoadingAvailableMovie
                ? availableMovies.isNotEmpty
                    ? SmartRefresher(
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
                            );
                          },
                        ),
                      )
                    : Center(
                        child: EmptyDataWidget(
                            title: "Watchlist Empty",
                            subtitle: "Please add watchlist movie first"),
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
