import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_developer_enterkomputer/data/blocs/bottom_nav/bottom_nav_cubit.dart';
import 'package:test_flutter_developer_enterkomputer/data/blocs/user/cubit/user_data_cubit.dart';
import 'package:test_flutter_developer_enterkomputer/ui/screens/profile/profile_favourite_movie_screen.dart';
import 'package:test_flutter_developer_enterkomputer/ui/screens/profile/profile_watchlist_movie_screen.dart';
import 'package:test_flutter_developer_enterkomputer/utils/colors.dart';
import 'package:test_flutter_developer_enterkomputer/utils/extensions.dart';
import 'package:test_flutter_developer_enterkomputer/utils/textstyles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<UserDataCubit>(context).state.user;
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "My Profile",
            style: latoBold,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: _screenWidth * (5 / 100)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  user?.username ?? "-",
                  style: latoBold.copyWith(fontSize: 25),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "ID: ${user?.id}",
                  style: latoRegular.copyWith(fontSize: 15),
                ),
                Divider(
                  color: gray2,
                ),
                Text(
                  "Menu",
                  style: latoBold,
                ),
                ListTile(
                  title: Text(
                    "Watchinglist Movie",
                    style: latoRegular,
                  ),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    pushScreen(context, ProfileWatchlistMovieScreen());
                  },
                ),
                ListTile(
                  title: Text(
                    "Favourite Movie",
                    style: latoRegular,
                  ),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    pushScreen(context, ProfileFavouriteMovieScreen());
                  },
                ),
                ListTile(
                  title: Text(
                    "Logout",
                    style: latoRegular,
                  ),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    BlocProvider.of<BottomNavCubit>(context).navItemTapped(0);
                    BlocProvider.of<UserDataCubit>(context).userLogout();
                  },
                )
              ],
            ),
          ),
        ));
  }
}
