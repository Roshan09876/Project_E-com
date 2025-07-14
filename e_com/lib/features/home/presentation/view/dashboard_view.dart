import 'package:e_com/features/products/presentation/state/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_com/features/products/presentation/view_model/product_view_model.dart'; // Assuming this path is correct

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

    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5), 
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 2.0, 
        centerTitle: false, 
        title: const Text(
          'Trendify Store',
          style: TextStyle(
            color: Color(0xFFE53935), 
            fontWeight: FontWeight.w800, 
            fontSize: 26, 
            letterSpacing: 0.8,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: Color(0xFFE53935), size: 28), // Rounded icon, vibrant red
            onPressed: () {

            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: Color(0xFFE53935), size: 28), // Modern bag icon
            onPressed: () {

            },
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0), // Increased horizontal padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30), 
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4), 
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.search, color: Color(0xFFE53935), size: 24),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14.0), // Adjust padding
                ),
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 30), 
            const Text(
              'Trending Items', 
              style: TextStyle(
                fontWeight: FontWeight.w700, 
                fontSize: 22, 
                color: Color(0xFF2C3E50), 
              ),
            ),
            const Text(
              'Find what moves you...', 
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20), 


            Expanded(
              child: AnimatedSwitcher( 
                duration: const Duration(milliseconds: 300),
                child: _buildProductContent(productState),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductContent(ProductState productState) {
    if (productState.isLoading) {
      return const Center(key: ValueKey('loading'), child: CircularProgressIndicator(color: Color(0xFFE53935)));
    } else if (productState.error != null) {
      return Center(
        key: ValueKey('error'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline_rounded, color: Colors.redAccent, size: 40),
            const SizedBox(height: 10),
            Text(
              productState.error!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.redAccent, fontSize: 16),
            ),
          ],
        ),
      );
    } else if (productState.products.isEmpty) {
      return Center(
        key: ValueKey('no_products'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.widgets_outlined, color: Colors.grey[400], size: 50),
            const SizedBox(height: 10),
            const Text(
              'No products found. Check back later!',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      key: ValueKey('product_grid'),
      physics: const BouncingScrollPhysics(),
      itemCount: productState.products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 18, 
        mainAxisSpacing: 18, 
      ),
      itemBuilder: (context, index) {
        final product = productState.products[index];
        return Material( 
          color: Colors.white,
          borderRadius: BorderRadius.circular(20), 
          elevation: 6, 
          shadowColor: Colors.black.withOpacity(0.1), 
          child: InkWell( 
            onTap: () {
            },
            borderRadius: BorderRadius.circular(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image container
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3E0),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20), 
                      ),
                      image: product.image!.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(product.image![0]),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: product.image!.isEmpty 
                        ? Center(
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              color: Colors.orange[300],
                              size: 50,
                            ),
                          )
                        : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0), 
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name ?? "N/A",
                        maxLines: 2, 
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700, 
                          fontSize: 16,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                      const SizedBox(height: 6), 
                      Text(
                        'Rs. ${product.price}',
                        style: const TextStyle(
                          color: Color(0xFFE53935), 
                          fontWeight: FontWeight.w900, 
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Icon(
                          Icons.favorite_border_rounded, 
                          color: Colors.grey[400],
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}