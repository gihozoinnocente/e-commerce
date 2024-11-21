import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<ProductProvider>().fetchProducts(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rwandan Art Shop'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Featured Products Carousel
            SizedBox(
              height: 200,
              child: Consumer<ProductProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  
                  if (provider.error.isNotEmpty) {
                    return Center(child: Text(provider.error));
                  }

                  final products = provider.products.take(5).toList();
                  
                  return PageView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[100],
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Image.network(
                                product.image,
                                fit: BoxFit.contain,
                                height: 150,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  product.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            
            // Categories
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Consumer<ProductProvider>(
                    builder: (context, provider, child) {
                      if (provider.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        children: provider.categories
                            .map((category) => _buildCategoryCard(category))
                            .toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to category products
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.brown[100],
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}