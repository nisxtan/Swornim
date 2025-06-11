// widgets/client/dashboard/service_grid.dart
import 'package:flutter/material.dart';

class ServiceGrid extends StatelessWidget {
  final Function(String, BuildContext) onServiceTap;

  const ServiceGrid({
    super.key,
    required this.onServiceTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        // Services section header
        Row(
          children: [
            Text(
              'Our Services',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: () {
                // Handle view all services
              },
              icon: const Icon(Icons.arrow_forward_rounded, size: 16),
              label: const Text('View All'),
            ),
          ],
        ),
        
        const SizedBox(height: 16),

        // Services grid
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.2,
          children: [
            _buildServiceCard(
              Icons.location_city_rounded,
              'Book Venue',
              'Find perfect venues',
              colorScheme.primary,
              context,
            ),
            _buildServiceCard(
              Icons.camera_alt_rounded,
              'Photographers',
              'Professional photography',
              colorScheme.tertiary,
              context,
            ),
            _buildServiceCard(
              Icons.brush_rounded,
              'Makeup Artists',
              'Beauty professionals',
              const Color(0xFFE91E63),
              context,
            ),
            _buildServiceCard(
              Icons.auto_awesome_rounded,
              'Decorators',
              'Event decoration',
              const Color(0xFFFF9800),
              context,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceCard(
    IconData icon,
    String title,
    String subtitle,
    Color accentColor,
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outline.withOpacity(0.1),
        ),
      ),
      child: InkWell(
        onTap: () => onServiceTap(title, context),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: accentColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}