import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  final bool useContentDecoration;
  final EdgeInsetsGeometry contentPadding;

  const AppBackground({
    super.key,
    required this.child,
    this.useContentDecoration = false,
    this.contentPadding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.backgroundDecoration,
      child: useContentDecoration
          ? SafeArea(
              child: Padding(
                padding: contentPadding,
                child: Container(
                  decoration: AppTheme.contentBoxDecoration,
                  child: child,
                ),
              ),
            )
          : child,
    );
  }
} 