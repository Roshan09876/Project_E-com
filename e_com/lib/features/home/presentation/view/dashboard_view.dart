import 'package:e_com/config/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_com/features/products/presentation/view_model/product_view_model.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productViewModelProvider.notifier).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productViewModelProvider);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F1ED),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6D4C41),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 4,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Georgia',
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🔹 Quick Access Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Quick Access",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.brown,
                  ),
                ),
                _buildQuickAccess(Icons.favorite, "Favorites", () {
                  Navigator.pushNamed(context, AppRoutes.favPageRoute);
                }),
                _buildQuickAccess(Icons.shopping_bag, "Orders", () {
                  Navigator.pushNamed(context, AppRoutes.cartPageRoute);
                }),
              ],
            ),
            Expanded(
              child: productState.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : productState.error != null
                  ? Center(
                      child: Text(
                        productState.error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    )
                  : productState.products.isEmpty
                  ? const Center(
                      child: Text(
                        'No handcrafted items available.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: productState.products.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final product = productState.products[index];
                        final hasDiscount =
                            product.discountPrice.isNotEmpty &&
                            product.discountPrice != product.productPrice;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.brown.withOpacity(0.08),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: product.image.isNotEmpty
                                    ? Image.network(
                                        product.image,
                                        height: 180,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      )
                                    : Container(
                                        height: 180,
                                        width: double.infinity,
                                        color: Colors.brown.shade100,
                                        child: const Icon(
                                          Icons.image_not_supported,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                      ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.brown.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  product.productType,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF5D4037),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                product.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF3E2723),
                                ),
                              ),
                              const SizedBox(height: 6),
                              hasDiscount
                                  ? Row(
                                      children: [
                                        Text(
                                          'Rs. ${product.discountPrice}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF6D4C41),
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          'Rs. ${product.productPrice}',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      'Rs. ${product.productPrice}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF6D4C41),
                                      ),
                                    ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.favorite_border,
                                      color: Colors.grey.shade600,
                                    ),
                                    onPressed: () {},
                                  ),
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF8D6E63),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 10,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.shopping_cart,
                                      color: Colors.white,
                                    ),
                                    label: const Text(
                                      'Add to Cart',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Quick Access Helper
  Widget _buildQuickAccess(IconData icon, String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFEFEBE9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: const Color(0xFF6D4C41), size: 28),
                const SizedBox(height: 6),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4E342E),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
