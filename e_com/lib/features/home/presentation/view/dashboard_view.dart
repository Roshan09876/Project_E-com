import 'package:e_com/features/products/presentation/state/product_state.dart';
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

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF8D6E63),
        automaticallyImplyLeading: false,
        elevation: 3,
        centerTitle: true,
        title: const Text(
          'HandiCrafted',
          style: TextStyle(
            fontFamily: 'Georgia',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 26,
            letterSpacing: 1.5,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting Section
            const Text(
              'Discover Unique Handcrafted Items',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5D4037),
              ),
            ),
            const SizedBox(height: 10),

            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.brown.shade100),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search for handmade products...',
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Color(0xFF8D6E63)),
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              'Featured Crafts',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4E342E),
              ),
            ),
            const SizedBox(height: 10),

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
      return const Center(child: CircularProgressIndicator(color: Color(0xFF8D6E63)));
    } else if (productState.error != null) {
      return Center(
        child: Text(
          productState.error!,
          style: const TextStyle(color: Colors.redAccent, fontSize: 16),
        ),
      );
    } else if (productState.products.isEmpty) {
      return const Center(
        child: Text(
          'No handcrafted items found.',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return GridView.builder(
      itemCount: productState.products.length,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final product = productState.products[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.brown.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                    image: product.image.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(product.image),
                            fit: BoxFit.cover,
                          )
                        : null,
                    color: const Color(0xFFFBE9E7),
                  ),
                  child: product.image.isEmpty
                      ? Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.brown.shade200,
                            size: 40,
                          ),
                        )
                      : null,
                ),

                // Product Details
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3E2723),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Rs. ${product.productPrice}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF8D6E63),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Icon(Icons.favorite_border, color: Colors.grey.shade400),
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
