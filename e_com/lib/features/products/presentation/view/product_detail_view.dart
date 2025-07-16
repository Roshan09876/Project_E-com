import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_com/features/products/presentation/view_model/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailView extends ConsumerStatefulWidget {
  final String id;
  const ProductDetailView({super.key, required this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductDetailViewState();
}

class _ProductDetailViewState extends ConsumerState<ProductDetailView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .read(productViewModelProvider.notifier)
          .fetchProductByID(id: widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productViewModelProvider);
    final product = state.singleProduct;

    return Scaffold(
      appBar: AppBar(title: const Text("Product Detail")),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : product == null
          ? const Center(child: Text("Product not found"))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 📸 Image Carousel
                  if (product.image != null && product.image!.isNotEmpty)
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 300,
                        viewportFraction: 1.0,
                        enlargeCenterPage: false,
                        autoPlay: true,
                      ),
                      items: product.image!.map((img) {
                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(img),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                  const SizedBox(height: 16),

                  /// 📝 Name and Price
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name ?? "",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Rs. ${product.price}",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),

                        /// 📂 Category and Subcategory
                        Row(
                          children: [
                            Chip(
                              label: Text(product.category ?? ""),
                              backgroundColor: Colors.blue.shade50,
                            ),
                            const SizedBox(width: 8),
                            Chip(
                              label: Text(product.subCategory ?? ""),
                              backgroundColor: Colors.orange.shade50,
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        /// 📐 Sizes
                        if (product.sizes != null && product.sizes!.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Available Sizes:",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                children: product.sizes!
                                    .map((size) => Chip(label: Text(size)))
                                    .toList(),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),

                        /// 📄 Description
                        const Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product.description ?? "No description provided.",
                          style: const TextStyle(fontSize: 14, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                        ),
                        onPressed: () {},
                        child: Text(
                          "Add to Cart",
                          style: TextStyle(color: Colors.white),
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
