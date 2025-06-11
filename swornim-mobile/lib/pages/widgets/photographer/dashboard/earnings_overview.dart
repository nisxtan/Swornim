import 'package:flutter/material.dart';

class EarningsOverview extends StatelessWidget {
  const EarningsOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'This Month',
          style: theme.textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context,
                icon: Icons.attach_money,
                title: 'Earnings',
                value: '\$2,450',
                color: const Color(0xFF059669),
                subtitle: '+15% from last month',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                context,
                icon: Icons.photo_camera,
                title: 'Shoots',
                value: '12',
                color: theme.colorScheme.primary,
                subtitle: '3 this week',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context,
                icon: Icons.star,
                title: 'Rating',
                value: '4.9',
                color: const Color(0xFFD97706),
                subtitle: 'Based on 45 reviews',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                context,
                icon: Icons.pending_actions,
                title: 'Pending',
                value: '5',
                color: const Color(0xFF7C3AED),
                subtitle: 'New requests',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required String subtitle,
  }) {
    final theme = Theme.of(context);
    
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const Spacer(),
                Text(
                  value,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}