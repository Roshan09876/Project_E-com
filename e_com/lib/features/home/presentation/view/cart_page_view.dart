import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartPageView extends ConsumerStatefulWidget {
  const CartPageView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartPageViewState();
}

class _CartPageViewState extends ConsumerState<CartPageView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Cart Page"),),
    );
  }
}