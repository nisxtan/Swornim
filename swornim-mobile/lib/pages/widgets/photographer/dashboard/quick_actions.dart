import 'package:flutter/material.dart';

class QuickActions extends StatelessWidget {
  final Function(String) onActionTap;

  const QuickActions({super.key, required this.onActionTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: theme.textTheme.headlineMedium,
        ),
        const SizedBox(height: 12), // Reduced from 16
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.65, // Reduced from 0.8
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.1, // Slightly adjusted for better proportions
            children: [
              _buildActionCard(
                context,
                icon: Icons.calendar_today,
                title: 'Update\nAvailability',
                color: theme.colorScheme.primary,
                onTap: () => onActionTap('Update Availability'),
              ),
              _buildActionCard(
                context,
                icon: Icons.photo_library,
                title: 'Manage\nPortfolio',
                color: const Color(0xFF7C3AED),
                onTap: () => onActionTap('Manage Portfolio'),
              ),
              _buildActionCard(
                context,
                icon: Icons.book_online,
                title: 'View\nBookings',
                color: const Color(0xFF059669),
                onTap: () => onActionTap('View Bookings'),
              ),
              _buildActionCard(
                context,
                icon: Icons.bar_chart,
                title: 'Earnings\nReport',
                color: const Color(0xFFD97706),
                onTap: () => onActionTap('Earnings Report'),
              ),
              _buildActionCard(
                context,
                icon: Icons.price_change,
                title: 'Update\nRates',
                color: theme.colorScheme.error,
                onTap: () => onActionTap('Update Rates'),
              ),
              _buildActionCard(
                context,
                icon: Icons.reviews,
                title: 'Client\nReviews',
                color: const Color(0xFF0D9488),
                onTap: () => onActionTap('Client Reviews'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(8), // Reduced padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8), // Reduced padding
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20), // Smaller icon
              ),
              const SizedBox(height: 4), // Reduced spacing
              Flexible(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 11, // Smaller font size
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}