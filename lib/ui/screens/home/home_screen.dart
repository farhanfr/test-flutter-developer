import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_flutter_developer_enterkomputer/data/blocs/movie/bloc/add_favorite_watchlist_movie_bloc.dart';
import 'package:test_flutter_developer_enterkomputer/data/blocs/movie/fetch_movie/fetch_movie_bloc.dart';
import 'package:test_flutter_developer_enterkomputer/data/models/models.dart';
import 'package:test_flutter_developer_enterkomputer/ui/screens/product/widgets/bs_action_product_card.dart';
import 'package:test_flutter_developer_enterkomputer/ui/widgets/empty_data_widget.dart';
import 'package:test_flutter_developer_enterkomputer/ui/widgets/widgets.dart';
import 'package:test_flutter_developer_enterkomputer/utils/colors.dart';
import 'package:test_flutter_developer_enterkomputer/utils/extensions.dart';
import 'package:test_flutter_developer_enterkomputer/utils/textstyles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FetchMovieBloc _fetchMovieNowPlayingBloc, _fetchMoviePopularBloc;

  //Movie Popular
  List<Movie> popularMovie = [];
  bool _initialLoadingPopularMovie = true;
  bool visibleAddMoreInterested = true;
  int currentPagePopularMovie = 1;

  @override
  void initState() {
    _fetchMovieNowPlayingBloc = FetchMovieBloc()..add(OnNowPlayingMovie(1));
    _fetchMoviePopularBloc = FetchMovieBloc()..add(OnPopularMovie(1));
    super.initState();
  }

  @override
  void dispose() {
    _fetchMovieNowPlayingBloc.close();
    _fetchMoviePopularBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _fetchMovieNowPlayingBloc,
        ),
        BlocProvider(
          create: (context) => _fetchMoviePopularBloc,
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener(
            bloc: _fetchMoviePopularBloc,
            listener: (context, state) {
              if (state is FetchMoviePopularSuccess) {
                setState(() {
                  popularMovie.addAll(state.movie);
                  _initialLoadingPopularMovie = false;
                });
              }
              if (state is FetchMoviePopularFailure) {
                setState(() {
                  _initialLoadingPopularMovie = false;
                });
                showSnackbar(context,
                    message: "Gagal mengambil data produk", colors: danger);
              }
            },
          ),
          BlocListener<AddFavoriteWatchlistMovieBloc, AddFavoriteWatchlistMovieState>(
            listener: (context, state) {
              if (state is AddFavoriteWatchlistMovieLoading) {
                LoadingDialog.show(context);
              }
              if (state is AddFavoriteWatchlistMovieSuccess) {
                popScreen(context);
                showSnackbar(context,message: state.message,colors: success);
              }
              if (state is AddFavoriteWatchlistMovieFailure) {
                popScreen(context);
                print(state.message);
                 showSnackbar(context,message: state.message,colors: danger);
              }
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "MovieDB App",
              style: latoBold.copyWith(fontSize: 22),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: _screenWidth * (5 / 100),
                  ),
                  child: Text(
                    "What movie are interesting today?",
                    style: latoBold.copyWith(fontSize: 35),
                  ),
                ),
                BlocBuilder(
                  bloc: _fetchMovieNowPlayingBloc,
                  builder: (context, state) {
                    if (state is FetchMovieNowPlayingLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is FetchMovieNowPlayingFailure) {
                      return Center(
                        child: Text("Something when wrong"),
                      );
                    }
                    if (state is FetchMovieNowPlayingSuccess) {
                      return SizedBox(
                        height: 380,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: _screenWidth * (5 / 100),
                                  vertical: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Now Playing",
                                    style: latoBold.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  state.movie.length >= 10
                                      ? Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {},
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Text(
                                              "View all",
                                              textAlign: TextAlign.right,
                                              style: latoBold.copyWith(
                                                  color: primary,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13),
                                            ),
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.separated(
                                shrinkWrap: true,
                                separatorBuilder: (ctx, idx) =>
                                    SizedBox(width: 10),
                                padding: EdgeInsets.fromLTRB(
                                  _screenWidth * (5 / 100),
                                  8,
                                  _screenWidth * (5 / 100),
                                  8,
                                ),
                                itemCount: state.movie.length >= 6
                                    ? 6
                                    : state.movie.length,
                                scrollDirection: Axis.horizontal,
                                physics: ScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Container(
                                      width: 156,
                                      child: CardProduct(
                                        movie: state.movie[index],
                                        onTap: () {
                                          BottomSheetActionProductCard.show(
                                              context,movie: state.movie[index]);
                                        },
                                      ));
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return SizedBox.shrink();
                  },
                ),
                !_initialLoadingPopularMovie
                    ? Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: _screenWidth * (5 / 100),
                                vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Popular",
                                  style: latoBold.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                popularMovie.length >= 10
                                    ? Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {},
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Text(
                                            "Lihat Semua",
                                            textAlign: TextAlign.right,
                                            style: latoBold.copyWith(
                                                color: primary,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13),
                                          ),
                                        ),
                                      )
                                    : SizedBox.shrink(),
                              ],
                            ),
                          ),
                          popularMovie.isNotEmpty
                              ? Container(
                                  // height:   ,
                                  child: MasonryGridView.count(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 13,
                                    crossAxisSpacing: 13,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 6),
                                    itemCount: popularMovie.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final data = popularMovie[index];
                                      return CardProduct(
                                        movie: data,
                                        onTap: () {
                                          BottomSheetActionProductCard.show(
                                              context,movie: data);
                                        },
                                      );
                                    },
                                  ),
                                )
                              : Center(
                                  child: EmptyDataWidget(
                                      title: "Produk Tidak Tersedia",
                                      subtitle: ""),
                                ),
                          Visibility(
                            visible: popularMovie.isNotEmpty &&
                                popularMovie.length <= 20,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomButton.outlined(
                                      label: "Lihat Produk lainnya",
                                      leading: Icon(Icons.add),
                                      isUpperCase: false,
                                      onPressed: () {
                                        setState(() {
                                          currentPagePopularMovie++;
                                          _fetchMoviePopularBloc.add(
                                              OnPopularMovie(
                                                  currentPagePopularMovie));
                                        });
                                      }),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
