import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_developer_enterkomputer/data/blocs/bottom_nav/bottom_nav_cubit.dart';
import 'package:test_flutter_developer_enterkomputer/data/blocs/user/user_data/user_data_cubit.dart';
import 'package:test_flutter_developer_enterkomputer/ui/screens/auth/login_screen.dart';
import 'package:test_flutter_developer_enterkomputer/ui/screens/home/home_screen.dart';
import 'package:test_flutter_developer_enterkomputer/ui/screens/profile/profile_screen.dart';
import 'package:test_flutter_developer_enterkomputer/utils/colors.dart';
import 'package:test_flutter_developer_enterkomputer/utils/textstyles.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldRootKey = GlobalKey<ScaffoldState>();

  /// deklarasikan bloc bottomNav
  late BottomNavCubit _bottomNavCubit;

  @override
  void initState() {
    super.initState();
    /// isikan bloc bottomNav dengan blocprovider
    _bottomNavCubit = BlocProvider.of<BottomNavCubit>(context);
  }

  @override
  void dispose() {
    /// lakukan destroy dari bloc (cubit) agar tidak membebani memori aplikasi
    _bottomNavCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// cek apakah user sedang login dengan mengisi variabel bertipe boolean
    bool isLoggedIn =
        BlocProvider.of<UserDataCubit>(context).state.user != null;

    return Scaffold(
      key: _scaffoldRootKey,
      bottomNavigationBar: BlocBuilder<BottomNavCubit, BottomNavState>( /// Membuat bottomnav dengan bloc bottomNav
        bloc: _bottomNavCubit,
        builder: (context, state) => Theme(
          data: ThemeData(
            splashFactory: InkRipple.splashFactory,
            splashColor: primaryDark.withOpacity(0.07),
            highlightColor: success.withOpacity(0.07),
          ),
          child: BottomNavigationBar(
            backgroundColor: bottomNavBg,
            selectedItemColor: primary,
            unselectedItemColor: bottomNavIconInactive,
            selectedFontSize: 13,
            unselectedFontSize: 13,
            selectedLabelStyle: overline.copyWith(fontWeight: FontWeight.w700),
            unselectedLabelStyle:
                overline.copyWith(fontWeight: FontWeight.w700),
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            onTap: (index) => _bottomNavCubit.navItemTapped(index),
            currentIndex: _bottomNavCubit.currentIndex,
            items: _bottomNavCubit.navItem /// Menu bottom nav diambil dari variabel yang telah diisi pada bottom_nav_cubit.dart
                .map(
                  (e) => BottomNavigationBarItem(
                    icon: e.icon,
                    activeIcon: e.activeIcon,
                    label: e.label,
                  ),
                )
                .toList(),
          ),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => _bottomNavCubit,
          ),
        ],
        child: BlocBuilder( /// Menampilkan halaman sesuai dengan state bottomnav yang dipilih user
          bloc: _bottomNavCubit,
          builder: (context, state) => state is BottomNavHomeLoaded
              ? HomeScreen()
              : state is BottomNavProfileLoaded
                  ? !isLoggedIn ? LoginScreen(isFromRoot: true,) : ProfileScreen() /// Jika user belum login, user akan diarahkan ke halaman login, sebaliknya user akan diarahkan ke halaman profi
                  : SizedBox.shrink(),
        ),
      ),
    );
  }
}
