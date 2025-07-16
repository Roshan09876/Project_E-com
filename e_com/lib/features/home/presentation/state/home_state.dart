
import 'package:e_com/features/cart/presentation/view/cart_view.dart';
import 'package:e_com/features/home/presentation/view/dashboard_view.dart';
import 'package:e_com/features/home/presentation/view/profile_view.dart';
import 'package:flutter/material.dart';
class HomeState {
  final List<Widget> lstWidget;
  final int index;

  HomeState({required this.index, required this.lstWidget});

  factory HomeState.initial() {
    return HomeState(index: 0, lstWidget: [
      const DashboardView(),
      const ProfileView(),
      const CartView(),
    ]);
  }

  HomeState copyWith({int? index}) {
    return HomeState(index: index ?? this.index, lstWidget: lstWidget);
  }
}