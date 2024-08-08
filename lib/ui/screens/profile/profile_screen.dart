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
    /// Mengambil data user dari state
    final user = BlocProvider.of<UserDataCubit>(context).state.user;
    /// Mengambil ukuran panjang layar device
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
                  user?.username ?? "-", /// Menampilkan data user dari state
                  style: latoBold.copyWith(fontSize: 25),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "ID: ${user?.id}", /// Menampilkan data user dari state
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
                    /// Menuju halaman list watchlist movie user
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
                    /// Menuju halaman list favorite movie user
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
                    /// Setelah menekan tombol logout, mengarahkan user ke menu home
                    BlocProvider.of<BottomNavCubit>(context).navItemTapped(0);
                    /// Menjalakankan fungsu untuk user melakukan logout
                    BlocProvider.of<UserDataCubit>(context).userLogout();
                  },
                )
              ],
            ),
          ),
        ));
  }
}
