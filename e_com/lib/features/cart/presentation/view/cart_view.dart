import 'package:e_com/features/cart/presentation/view_model/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartView extends ConsumerStatefulWidget {
  const CartView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartViewState();
}

class _CartViewState extends ConsumerState<CartView> {
  late Map<int, int> quantityMap;

  @override
  void initState() {
    super.initState();
    quantityMap = {};
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(cartViewModelProvider.notifier).fetchUserCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartViewModelProvider);
    final cartItems = cartState.cartApiModel ?? [];

    // Initialize quantity map
    for (int i = 0; i < cartItems.length; i++) {
      quantityMap[i] = cartItems[i].quantity ?? 1;
    }

    double totalPrice = 0;
    for (int i = 0; i < cartItems.length; i++) {
      final item = cartItems[i];
      final quantity = quantityMap[i] ?? 1;
      final priceStr = item.product?.discountPrice?.isNotEmpty == true
          ? item.product!.discountPrice
          : item.product?.productPrice;
      final price = double.tryParse(priceStr?.replaceAll(",", "") ?? '0') ?? 0;
      totalPrice += price * quantity;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF1F3F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6D4C41),
        title: const Text("🛒 Your Cart", style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: cartState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : cartItems.isEmpty
              ? const Center(
                  child: Text(
                    "🛍️ Your cart is empty",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: cartItems.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 46,
                          childAspectRatio: 0.59,
                        ),
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          final product = item.product;
                          final quantity = quantityMap[index] ?? 1;
                          final imageUrl = product?.image ?? '';
                          final title = product?.title ?? 'No Title';
                          final priceStr = product?.discountPrice?.isNotEmpty == true
                              ? product!.discountPrice
                              : product?.productPrice;
                          final price = double.tryParse(priceStr?.replaceAll(",", "") ?? '0') ?? 0;
                          final total = price * quantity;

                          return Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    imageUrl,
                                    height: 100,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        const Icon(Icons.broken_image),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text("Rs. ${price.toStringAsFixed(2)}"),
                                Text(
                                  "Total: Rs. ${total.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(height: 8),

                                /// Quantity controls
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove_circle_outline),
                                      onPressed: quantity > 1
                                          ? () {
                                              setState(() {
                                                quantityMap[index] = quantity - 1;
                                              });
                                            }
                                          : null,
                                    ),
                                    Text(
                                      "$quantity",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add_circle_outline),
                                      onPressed: () {
                                        setState(() {
                                          quantityMap[index] = quantity + 1;
                                        });
                                      },
                                    ),
                                  ],
                                ),

                                /// Remove Button
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final userId = await ref
                                          .read(cartViewModelProvider.notifier)
                                          .getUserIdFromStorage();
                                      if (userId != null &&
                                          product?.id != null) {
                                        await ref
                                            .read(cartViewModelProvider.notifier)
                                            .removeCartItem(
                                              userId: userId,
                                              productId: product!.id!,
                                              context: context,
                                            );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red.shade400,
                                      padding: const EdgeInsets.symmetric(vertical: 6),
                                    ),
                                    child: const Text(
                                      "Remove",
                                      style: TextStyle(fontSize: 13 , color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    // Bottom Summary
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 10,
                            offset: const Offset(0, -2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total Price",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Rs. ${totalPrice.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
