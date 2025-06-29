// widgets/client/dashboard/welcome_section.dart
import 'package:flutter/material.dart';

class WelcomeSection extends StatelessWidget {
  final String? userName;
  final String? customMessage;

  const WelcomeSection({
    super.key,
    this.userName,
    this.customMessage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primary,
            colorScheme.primary.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.3),
            offset: const Offset(0, 8),
            blurRadius: 24,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userName != null ? 'Welcome back, $userName!' : 'Welcome back!',
            style: theme.textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            customMessage ?? 'Ready to plan something unforgettable?',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 16),
          // Quick action buttons
          Row(
            children: [
              _buildQuickActionButton(
                'Book Now',
                Icons.event_available_rounded,
                () {
                  // Handle book now action
                },
                Colors.white,
                colorScheme.primary,
              ),
              const SizedBox(width: 12),
              _buildQuickActionButton(
                'My Bookings',
                Icons.bookmark_border_rounded,
                () {
                  // Handle my bookings action
                },
                Colors.transparent,
                Colors.white,
                borderColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(
    String text,
    IconData icon,
    VoidCallback onPressed,
    Color backgroundColor,
    Color textColor, {
    Color? borderColor,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: borderColor != null ? Border.all(color: borderColor) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: textColor,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}