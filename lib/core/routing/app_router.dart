import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/registration_page.dart';
import '../../features/auth/presentation/pages/otp_verification_page.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/cart/presentation/pages/cart_page.dart';
import '../../features/cart/presentation/pages/checkout_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/orders/presentation/pages/order_confirmation_page.dart';
import '../../features/orders/presentation/pages/order_tracking_page.dart';
import '../../features/orders/presentation/pages/pickup_status_page.dart';
import '../../features/orders/presentation/pages/pickup_confirmation_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/products/presentation/pages/product_list_page.dart';

class AppRouter {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static GoRouter get router => _router;

  static final _router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/login',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final isAuthenticated = authProvider.isAuthenticated;
      
      // Auth routes that don't require redirection
      if (state.matchedLocation == '/login' || 
          state.matchedLocation == '/register' ||
          state.matchedLocation == '/otp-verification') {
        if (isAuthenticated) {
          return '/dashboard';
        }
        return null;
      }
      
      // Protected routes - redirect to login if not authenticated
      if (!isAuthenticated) {
        return '/login';
      }
      
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegistrationPage(),
      ),
      GoRoute(
        path: '/otp-verification',
        name: 'otp-verification',
        builder: (context, state) {
          final extras = state.extra as Map<String, dynamic>?;
          final email = extras?['email'] as String? ?? '';
          final isRegistration = extras?['isRegistration'] as bool? ?? false;
          return OTPVerificationPage(
            email: email,
            isRegistration: isRegistration,
          );
        },
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: '/products',
        name: 'products',
        builder: (context, state) => const ProductListPage(),
      ),
      GoRoute(
        path: '/cart',
        name: 'cart',
        builder: (context, state) => const CartPage(),
      ),
      GoRoute(
        path: '/checkout',
        name: 'checkout',
        builder: (context, state) => const CheckoutPage(),
      ),
      GoRoute(
        path: '/order-confirmation/:orderId',
        name: 'order-confirmation',
        builder: (context, state) {
          final orderId = state.pathParameters['orderId'] ?? '';
          return OrderConfirmationPage(orderId: orderId);
        },
      ),
      GoRoute(
        path: '/order-tracking/:orderId',
        name: 'order-tracking',
        builder: (context, state) {
          final orderId = state.pathParameters['orderId'] ?? '';
          return OrderTrackingPage(orderId: orderId);
        },
      ),
      GoRoute(
        path: '/pickup-status/:orderId',
        name: 'pickup-status',
        builder: (context, state) {
          final orderId = state.pathParameters['orderId'] ?? '';
          return PickupStatusPage(orderId: orderId);
        },
      ),
      GoRoute(
        path: '/pickup-confirmation/:orderId',
        name: 'pickup-confirmation',
        builder: (context, state) {
          final orderId = state.pathParameters['orderId'] ?? '';
          return PickupConfirmationPage(orderId: orderId);
        },
      ),
    ],
  );
} 