import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_flutter_developer_enterkomputer/data/blocs/bottom_nav/bottom_nav_cubit.dart';
import 'package:test_flutter_developer_enterkomputer/data/blocs/movie/add_favorite_watchlist_movie/add_favorite_watchlist_movie_bloc.dart';
import 'package:test_flutter_developer_enterkomputer/data/blocs/user/user_data/user_data_cubit.dart';
import 'package:test_flutter_developer_enterkomputer/ui/screens/main_screen.dart';
import 'package:test_flutter_developer_enterkomputer/ui/screens/splash_screen.dart';
import 'package:test_flutter_developer_enterkomputer/utils/colors.dart';
import 'package:test_flutter_developer_enterkomputer/utils/constants.dart';
import 'package:test_flutter_developer_enterkomputer/utils/extensions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialisasi package get storage
  await GetStorage.init();

  /// Load file .env
  await dotenv.load(fileName: ".env");

  /// Set orientasi layar
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  /// Initialisasi package intl
  await initializeDateFormatting('id_ID', null)
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// Inisialisasi bloc (cubit)
  late BottomNavCubit _bottomNavCubit;
  late UserDataCubit _userDataCubit;

  @override
  void initState() {
    /// Memanggil fungsi dari bloc (cubit) untuk bottom nav 
    _bottomNavCubit = BottomNavCubit()..appLoaded();
    /// Memanggil fungsi dari bloc (cubit) untuk inisiasi data user
    _userDataCubit = UserDataCubit()..appStarted();
    super.initState();
  }

  @override
  void dispose() {
    /// lakukan destroy dari bloc (cubit) agar tidak membebani memori aplikasi
    _bottomNavCubit.close();
    _userDataCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        /// mendefinisikan blocprovider sebelum menggunakan bloc pada halaman aplikasi
        /// selain itu, juga dapat mendifinisikan global blocprovider agar dapat digunakan
        /// pada banyak halaman aplikasi
        BlocProvider(
          create: (context) => _bottomNavCubit,
        ),
        BlocProvider(
          create: (context) => _userDataCubit,
        ),
        BlocProvider(
          create: (context) => AddFavoriteWatchlistMovieBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Movie DB App',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        debugShowCheckedModeBanner: kDebugMode,
        home: BlocBuilder<UserDataCubit, UserDataState>(
            builder: (context, state) =>
            /// memanggil state dari bloc dan memberikan logika sesuai state
                state is UserDataInitial ? SplashScreen() : MainScreen()),
      ),
    );
  }
}

class Config {
  static final String baseUrl = kDebugMode ? BASE_URL : BASE_URL;
  static final String apiKey = kDebugMode ? API_KEY : API_KEY;
}
