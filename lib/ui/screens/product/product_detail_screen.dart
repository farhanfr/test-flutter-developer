import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_developer_enterkomputer/data/blocs/movie/fetch_movie_detail/fetch_movie_detail_cubit.dart';
import 'package:test_flutter_developer_enterkomputer/data/blocs/movie/fetch_movie_similar/fetch_movie_similar_cubit.dart';
import 'package:test_flutter_developer_enterkomputer/ui/screens/product/widgets/bs_action_product_card.dart';
import 'package:test_flutter_developer_enterkomputer/ui/widgets/widgets.dart';
import 'package:test_flutter_developer_enterkomputer/utils/colors.dart';
import 'package:test_flutter_developer_enterkomputer/utils/constants.dart';
import 'package:test_flutter_developer_enterkomputer/utils/textstyles.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.movieId});

  final int movieId;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late FetchMovieDetailCubit _fetchMovieDetailCubit;
  late FetchMovieSimilarCubit _fetchMovieSimilarCubit;

  @override
  void initState() {
    _fetchMovieDetailCubit = FetchMovieDetailCubit()
      ..load(movieId: widget.movieId);
    _fetchMovieSimilarCubit = FetchMovieSimilarCubit()
      ..load(movieId: widget.movieId);
    super.initState();
  }

  @override
  void dispose() {
    _fetchMovieDetailCubit.close();
    _fetchMovieSimilarCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _fetchMovieDetailCubit,
        ),
        BlocProvider(
          create: (context) => _fetchMovieSimilarCubit,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("Movie Detail"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder(
                  bloc: _fetchMovieDetailCubit,
                  builder: (context, state) {
                    return state is FetchMovieDetailLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : state is FetchMovieDetailFailure
                            ? Center(
                                child: Text("something went wrong"),
                              )
                            : state is FetchMovieDetailSuccess
                                ? Container(
                                  padding: EdgeInsets.symmetric(horizontal: _screenWidth * (5/100),vertical: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(child: ImageNetworkCached(image: "$IMAGE_LINK${state.movie.posterPath}",height: 200,)),
                                            SizedBox(width: 10,),
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,

                                                children: [
                                                  Text(state.movie.title,style: latoBold.copyWith(fontSize: 25),),
                                                  SizedBox(height: 8,),
                                                  Text(state.movie.releaseDate,style: latoRegular,),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Text("Overview",style: latoBold,),
                                        Divider(),
                                        Text(state.movie.overview,style: latoRegular,)
                                      ],
                                    ),
                                  )
                                : SizedBox();
                  }),
              BlocBuilder(
                  bloc: _fetchMovieSimilarCubit,
                  builder: (context, state) {
                    return state is FetchMovieSimilarLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : state is FetchMovieSimilarFailure
                            ? Center(
                                child: Text(state.message),
                              )
                            : state is FetchMovieSimilarSuccess
                                ? SizedBox(
                                    height: 380,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  _screenWidth * (5 / 100),
                                              vertical: 16),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
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
                                                      color:
                                                          Colors.transparent,
                                                      child: InkWell(
                                                        onTap: () {},
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        child: Text(
                                                          "View all",
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: latoBold
                                                              .copyWith(
                                                                  color:
                                                                      primary,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      13),
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
                                                      BottomSheetActionProductCard
                                                          .show(context,
                                                              movie:
                                                                  state.movie[
                                                                      index]);
                                                    },
                                                  ));
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : SizedBox();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
