import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final isWholesaler = authProvider.userType == 'wholesaler';

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.bottomNavBarColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          // Different navigation options based on user type
          if (isWholesaler) {
            switch (index) {
              case 0:
                context.go('/dashboard');
                break;
              case 1:
                context.go('/inventory-management');
                break;
              case 2:
                context.go('/delivery-management');
                break;
              case 3:
                context.go('/profile');
                break;
            }
          } else {
            // For retailers
            switch (index) {
              case 0:
                context.go('/dashboard');
                break;
              case 1:
                context.go('/products');
                break;
              case 2:
                context.go('/cart');
                break;
              case 3:
                context.go('/profile');
                break;
            }
          }
        },
        items: isWholesaler ? _wholesalerNavItems : _retailerNavItems,
      ),
    );
  }

  // Navigation items for retailers
  static const List<BottomNavigationBarItem> _retailerNavItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.dashboard),
      label: 'Dashboard',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Products',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      label: 'Cart',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  // Navigation items for wholesalers
  static const List<BottomNavigationBarItem> _wholesalerNavItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.dashboard),
      label: 'Dashboard',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.inventory),
      label: 'Inventory',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.local_shipping),
      label: 'Deliveries',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];
} 