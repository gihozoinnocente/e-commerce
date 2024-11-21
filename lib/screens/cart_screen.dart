import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.remove_shopping_cart),
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Clear Cart'),
                  content: const Text('Are you sure you want to clear your cart?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<CartProvider>().clear();
                        Navigator.of(ctx).pop();
                      },
                      child: const Text('Clear'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 100,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to products screen
                      // You might want to use a more sophisticated navigation method
                      Navigator.of(context).pop();
                    },
                    child: const Text('Start Shopping'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (ctx, i) {
                    final item = cart.items.values.toList()[i];
                    return Dismissible(
                      key: ValueKey(item.product.id),
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 4,
                        ),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        cart.removeItem(item.product.id);
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 4,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: ListTile(
                            leading: SizedBox(
                              width: 50,
                              height: 50,
                              child: Image.network(
                                item.product.image,
                                fit: BoxFit.contain,
                              ),
                            ),
                            title: Text(item.product.title),
                            subtitle: Text(
                              'Total: \$${(item.total).toStringAsFixed(2)}\nPrice: \$${item.product.price}',
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    cart.updateQuantity(
                                        item.product.id, item.quantity - 1);
                                  },
                                ),
                                Text(
                                  '${item.quantity}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    cart.updateQuantity(
                                        item.product.id, item.quantity + 1);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Card(
                margin: const EdgeInsets.all(15),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Amount:',
                            style: TextStyle(fontSize: 20),
                          ),
                          const Spacer(),
                          Chip(
                            label: Text(
                              '\$${cart.totalAmount.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .titleLarge
                                    ?.color,
                              ),
                            ),
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: cart.totalAmount <= 0
                              ? null
                              : () {
                                  // TODO: Implement checkout
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Checkout functionality coming soon!'),
                                    ),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: const Text('PROCEED TO CHECKOUT'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}