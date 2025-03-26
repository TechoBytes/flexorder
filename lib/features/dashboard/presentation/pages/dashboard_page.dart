import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../features/auth/presentation/providers/auth_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  // Featured products with real images
  final List<Map<String, dynamic>> _featuredProducts = const [
    {
      'name': 'Premium Dark Chocolate',
      'price': 24.99,
      'imageUrl':
          'https://images.unsplash.com/photo-1549007994-cb92caebd54b?q=80&w=800',
    },
    {
      'name': 'Organic Rice (10kg)',
      'price': 42.50,
      'imageUrl':
          'https://images.unsplash.com/photo-1536304993881-ff6e9eefa2a6?q=80&w=800',
    },
    {
      'name': 'Arabica Coffee Beans',
      'price': 35.99,
      'imageUrl':
          'https://images.unsplash.com/photo-1447933601403-0c6688de566e?q=80&w=800',
    },
    {
      'name': 'Extra Virgin Olive Oil (5L)',
      'price': 89.99,
      'imageUrl':
          'https://images.unsplash.com/photo-1596360770107-8d263ccc6fcc?q=80&w=800',
    },
    {
      'name': 'Almond Flour (1kg)',
      'price': 29.99,
      'imageUrl':
          'https://images.unsplash.com/photo-1486297678162-eb2a19b0a32d?q=80&w=800',
    },
  ];

  // Product categories with icons and images
  final List<Map<String, dynamic>> _categories = const [
    {
      'name': 'Chocolates',
      'icon': Icons.cake,
      'imageUrl':
          'https://images.unsplash.com/photo-1549007994-cb92caebd54b?q=80&w=800',
    },
    {
      'name': 'Grains & Rice',
      'icon': Icons.grass,
      'imageUrl':
          'https://images.unsplash.com/photo-1536304993881-ff6e9eefa2a6?q=80&w=800',
    },
    {
      'name': 'Beverages',
      'icon': Icons.coffee,
      'imageUrl':
          'https://images.unsplash.com/photo-1447933601403-0c6688de566e?q=80&w=800',
    },
    {
      'name': 'Oils & Condiments',
      'icon': Icons.local_drink,
      'imageUrl':
          'https://images.unsplash.com/photo-1596360770107-8d263ccc6fcc?q=80&w=800',
    },
    {
      'name': 'Baking Supplies',
      'icon': Icons.bakery_dining,
      'imageUrl':
          'https://images.unsplash.com/photo-1486297678162-eb2a19b0a32d?q=80&w=800',
    },
    {
      'name': 'Spices',
      'icon': Icons.spa,
      'imageUrl':
          'https://images.unsplash.com/photo-1600565193348-f74bd3c7ccdf?q=80&w=800',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final userName = authProvider.userName;

    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      appBar: AppBar(
        title: Text('Welcome, ${userName.split(' ')[0]}'),
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Featured Products
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _SectionTitle('Featured Products'),
                TextButton(
                  onPressed: () => context.push('/products'),
                  child: const Text(
                    'View All',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _featuredProducts.length,
                itemBuilder: (context, index) {
                  final product = _featuredProducts[index];
                  return _ProductCard(
                    name: product['name'],
                    price: product['price'],
                    imageUrl: product['imageUrl'],
                    onTap: () => context.push('/products'),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Categories
            _SectionTitle('Categories'),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                return _CategoryCard(
                  name: category['name'],
                  icon: category['icon'],
                  onTap: () => context.push('/products'),
                );
              },
            ),
            const SizedBox(height: 24),

            // Recent Orders
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _SectionTitle('Recent Orders'),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'View All',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return _OrderCard(
                  orderId: 'ORD${1000 + index}',
                  date:
                      DateTime.now()
                          .subtract(Duration(days: index))
                          .toString()
                          .split(' ')[0],
                  status:
                      index == 0
                          ? 'Pending'
                          : (index == 1 ? 'Processing' : 'Delivered'),
                  total: 99.99 * (index + 1),
                  onTap: () {
                    if (index == 0) {
                      context.push('/order-tracking/ORD${1000 + index}');
                    } else {
                      context.push('/order-confirmation/ORD${1000 + index}');
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 0),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final String name;
  final double price;
  final String imageUrl;
  final VoidCallback onTap;

  const _ProductCard({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: AppTheme.secondaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Image.network(
                imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 120,
                    color: Colors.grey.shade800,
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.white54,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: TextStyle(color: Colors.white.withOpacity(0.7)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.name,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.secondaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 32),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final String orderId;
  final String date;
  final String status;
  final double total;
  final VoidCallback onTap;

  const _OrderCard({
    required this.orderId,
    required this.date,
    required this.status,
    required this.total,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: AppTheme.secondaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        onTap: onTap,
        title: Text(
          orderId,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Date: $date',
          style: TextStyle(color: Colors.white.withOpacity(0.7)),
        ),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '\$${total.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: _getStatusColor(status),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                status,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'processing':
        return Colors.blue;
      case 'delivered':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
