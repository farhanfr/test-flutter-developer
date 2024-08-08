import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_developer_enterkomputer/utils/colors.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(BottomNavInitial());

  /// deklarasi dan inisialisasi variabel untuk index bottom nav yabg dipilih
  int currentIndex = 0;

  /// fungsi untuk memanggil fungsi navItemTapped
  void appLoaded() {
    navItemTapped(currentIndex);
  }

  void navItemTapped(int index) {
    currentIndex = index;
    emit(BottomNavLoading());

    BottomNavItem currentItem = navItem[currentIndex];

    /// update state
    emit(currentItem.state);
  }

  /// deklarasi dan inisialisasi list navItem untuk isi bottom nav
  List<BottomNavItem> get navItem {
    return [
      BottomNavItem(
        icon: Icon(
          Icons.home,
          color: Colors.grey,
        ),
        activeIcon: Icon(
          Icons.home,
          color: primary,
        ),
        label: "Home",
        state: BottomNavHomeLoaded(),
      ),
      BottomNavItem(
        icon: Icon(
          Icons.person_pin_rounded,
          color: Colors.grey,
        ),
        activeIcon: Icon(
          Icons.person_pin_rounded,
          color: primary,
        ),
        label: "Profile",
        state: BottomNavProfileLoaded(),
      ),
    ];
  }
}

/// Membuat model class untuk bottom nav
class BottomNavItem {
  BottomNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.state,
    this.onTaped,
  });

  final Widget icon;
  final Widget activeIcon;
  final String label;
  final BottomNavState state;
  final VoidCallback? onTaped;
}
