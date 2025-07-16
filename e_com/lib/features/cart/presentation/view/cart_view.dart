import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartView extends ConsumerStatefulWidget {
  const CartView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartViewState();
}

class _CartViewState extends ConsumerState<CartView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Text("This is Cart Page")
      ],),
    );
  }
}