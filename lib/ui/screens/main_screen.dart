import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_developer_enterkomputer/data/blocs/bottom_nav/bottom_nav_cubit.dart';
import 'package:test_flutter_developer_enterkomputer/data/blocs/user/cubit/user_data_cubit.dart';
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

  late BottomNavCubit _bottomNavCubit;

  @override
  void initState() {
    super.initState();
    _bottomNavCubit = BlocProvider.of<BottomNavCubit>(context);
  }

  @override
  void dispose() {
    _bottomNavCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn =
        BlocProvider.of<UserDataCubit>(context).state.user != null;

    return Scaffold(
      key: _scaffoldRootKey,
      bottomNavigationBar: BlocBuilder<BottomNavCubit, BottomNavState>(
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
            items: _bottomNavCubit.navItem
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
        child: BlocBuilder(
          bloc: _bottomNavCubit,
          builder: (context, state) => state is BottomNavHomeLoaded
              ? HomeScreen()
              : state is BottomNavProfileLoaded
                  ? !isLoggedIn ? LoginScreen(isFromRoot: true,) : ProfileScreen()
                  : SizedBox.shrink(),
        ),
      ),
    );
  }
}
