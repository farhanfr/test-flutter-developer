import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_flutter_developer_enterkomputer/data/blocs/movie/add_favorite_watchlist_movie/add_favorite_watchlist_movie_bloc.dart';
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

   /// deklarasi bloc (cubit) untuk dilakukan pengambilan data NowPlaying dan Popuplar film
  late FetchMovieBloc _fetchMovieNowPlayingBloc, _fetchMoviePopularBloc;

  /// ======================== Popular Movie ========================
  /// deklarasi variabel dan inisialisasi untuk menampung list film yang popular
  List<Movie> popularMovie = [];
  /// deklarasi variabel dan inisialisasi untuk menampung status loading
  bool _initialLoadingPopularMovie = true;
  /// deklarasi variabel dan inisialisasi untuk menampung status button load more
  bool visibleAddMoreInterested = true;
  /// deklarasi variabel dan inisialisasi untuk menampung halaman pada pagination
  int currentPagePopularMovie = 1;

  @override
  void initState() {
       /// mengisi variabel _fetchMovieNowPlayingBloc dengan event yang digunakan pada bloc
    /// yaitu OnNowPlayingMovie()
    _fetchMovieNowPlayingBloc = FetchMovieBloc()..add(OnNowPlayingMovie(1));
     /// mengisi variabel _fetchMoviePopularBloc dengan event yang digunakan pada bloc
    /// yaitu OnPopularMovie()
    _fetchMoviePopularBloc = FetchMovieBloc()..add(OnPopularMovie(1));
    super.initState();
  }

  @override
  void dispose() {
    /// menutup bloc agar tidak membebani memori aplikasi
    _fetchMovieNowPlayingBloc.close();
    _fetchMoviePopularBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return MultiBlocProvider(  /// mendefinisikan blocprovider sebelum menggunakan bloc pada halaman aplikasi
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
          BlocListener( /// fungsi yang digunakan untuk mengetahui state yang dijalankan dari bloc (FetchMovieBloc)
            bloc: _fetchMoviePopularBloc,
            listener: (context, state) {
              /// Jika state success, maka dilakukan penambahan data film favorit pada list => List<Movie> popularMovie
            /// status loading di set ke false
              if (state is FetchMoviePopularSuccess) {
                setState(() {
                  popularMovie.addAll(state.movie);
                  _initialLoadingPopularMovie = false;
                });
              }
                /// Jika state failure, maka dimunculkan notifikasi (snackbar) dan status loading di set ke false
              if (state is FetchMoviePopularFailure) {
                setState(() {
                  _initialLoadingPopularMovie = false;
                });
                showSnackbar(context,
                    message: "Gagal mengambil data produk", colors: danger);
              }
            },
          ),
          BlocListener<AddFavoriteWatchlistMovieBloc,
              AddFavoriteWatchlistMovieState>(
            listener: (context, state) {
              /// Jika state loading, maka dilakukan menampilkan loading
              if (state is AddFavoriteWatchlistMovieLoading) {
                LoadingDialog.show(context);
              }
                /// Jika state success, maka akan menutup loading dan menampilkan notifikasi (snackbar)
              if (state is AddFavoriteWatchlistMovieSuccess) {
                popScreen(context);
                showSnackbar(context, message: state.message, colors: success);
              }
                /// Jika state failure, maka akan menutup loading dan menampilkan notifikasi (snackbar)
              if (state is AddFavoriteWatchlistMovieFailure) {
                popScreen(context);
                print(state.message);
                showSnackbar(context, message: state.message, colors: danger);
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
                BlocBuilder( /// mempresentasikan state yang dijalankan pada FetchMovieBloc
                  bloc: _fetchMovieNowPlayingBloc,
                  builder: (context, state) {
                    /// Jika state loading, maka dilakukan menampilkan loading
                    if (state is FetchMovieNowPlayingLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    /// Jika state failure, maka dilakukan menampilkan tulisan "Something when wrong" pada halama aplikasi
                    if (state is FetchMovieNowPlayingFailure) {
                      return Center(
                        child: Text("Something when wrong"),
                      );
                    }
                    /// Jika state success, maka dilakukan menampilkan widget/component film now playing pada halaman aplikasi
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
                                /// Jika list film now playing lebih dari 6 maka hanya menampilkan 6 film, 
                                /// jika tidak, maka menampilkan semua film
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
                                              context,
                                              movie: state.movie[index]);
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
                !_initialLoadingPopularMovie // Jika variabel _initialLoadingPopularMovie bernilai false maka akan menampilkan widget/component film populer
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
                          popularMovie.isNotEmpty /// Jika list variabel popukar movie tidak kosong, maka menampilkan widget/component film populer
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
                                              context,
                                              movie: data);
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
                        child: CircularProgressIndicator(), /// Jika variabel _initialLoadingPopularMovie bernilai true, maka menampilkan widget loading
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
