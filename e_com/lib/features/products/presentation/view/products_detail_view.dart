import 'package:e_com/features/products/presentation/view_model/product_view_model.dart';
import 'package:e_com/features/cart/presentation/view_model/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsDetailView extends ConsumerStatefulWidget {
  final String id;
  const ProductsDetailView({super.key, required this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductsDetailViewState();
}

class _ProductsDetailViewState extends ConsumerState<ProductsDetailView> {
  bool isAddedToCart = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .read(productViewModelProvider.notifier)
          .fetchProductByID(id: widget.id);

      // Optional: Fetch user's cart if you want to check if item is already in cart
      await ref.read(cartViewModelProvider.notifier).fetchUserCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productViewModelProvider);
    final cartState = ref.watch(cartViewModelProvider);
    final cartViewModel = ref.read(cartViewModelProvider.notifier);
    final product = productState.productData;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F1ED),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6D4C41),
        elevation: 2,
        title: const Text(
          'Product Details',
          style: TextStyle(
            fontFamily: 'Georgia',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: productState.isLoading || product == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔸 Product Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: product.image.isNotEmpty
                        ? Image.network(
                            product.image,
                            width: double.infinity,
                            height: 240,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: double.infinity,
                            height: 240,
                            color: Colors.brown.shade100,
                            child: const Icon(
                              Icons.image_not_supported,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                  ),
                  const SizedBox(height: 16),

                  // 🔸 Product Type Badge
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.brown.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      product.productType,
                      style: const TextStyle(
                        color: Color(0xFF5D4037),
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // 🔸 Title
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3E2723),
                      fontFamily: 'Georgia',
                    ),
                  ),
                  const SizedBox(height: 12),

                  // 🔸 Pricing
                  product.discountPrice.isNotEmpty &&
                          product.discountPrice != product.productPrice
                      ? Row(
                          children: [
                            Text(
                              'Rs. ${product.discountPrice}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF6D4C41),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Rs. ${product.productPrice}',
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          'Rs. ${product.productPrice}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6D4C41),
                          ),
                        ),
                  const SizedBox(height: 18),

                  // 🔸 Description
                  const Text(
                    "Product Description",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4E342E),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 🔸 Add to Cart Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isAddedToCart
                            ? Colors.grey
                            : const Color(0xFF8D6E63),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: isAddedToCart
                          ? null
                          : () async {
                              await cartViewModel.addToCart(
                                productId: product.id,
                                quantity: 1,
                                context: context,
                              );
                              setState(() {
                                isAddedToCart = true;
                              });
                            },
                      icon: Icon(
                        isAddedToCart ? Icons.check : Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      label: Text(
                        isAddedToCart ? "Added to Cart" : "Add to Cart",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
