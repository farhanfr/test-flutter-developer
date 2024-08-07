import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_flutter_developer_enterkomputer/data/blocs/bottom_nav/bottom_nav_cubit.dart';
import 'package:test_flutter_developer_enterkomputer/data/blocs/movie/bloc/add_favorite_watchlist_movie_bloc.dart';
import 'package:test_flutter_developer_enterkomputer/data/blocs/user/cubit/user_data_cubit.dart';
import 'package:test_flutter_developer_enterkomputer/ui/screens/main_screen.dart';
import 'package:test_flutter_developer_enterkomputer/ui/screens/splash_screen.dart';
import 'package:test_flutter_developer_enterkomputer/utils/colors.dart';
import 'package:test_flutter_developer_enterkomputer/utils/constants.dart';
import 'package:test_flutter_developer_enterkomputer/utils/extensions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await dotenv.load(fileName: ".env");
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await initializeDateFormatting('id_ID', null)
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late BottomNavCubit _bottomNavCubit;
  late UserDataCubit _userDataCubit;

  @override
  void initState() {
    _bottomNavCubit = BottomNavCubit()..appLoaded();
    _userDataCubit = UserDataCubit()..appStarted();
    super.initState();
  }

  @override
  void dispose() {
    _bottomNavCubit.close();
    _userDataCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
        home: BlocBuilder<UserDataCubit, UserDataState>(
            builder: (context, state) =>
                state is UserDataInitial ? SplashScreen() : MainScreen()),
      ),
    );
  }
}

class Config {
  static final String baseUrl = kDebugMode ? BASE_URL : BASE_URL;
  static final String apiKey = kDebugMode ? API_KEY : API_KEY;
}
