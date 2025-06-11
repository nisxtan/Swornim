import 'package:flutter/material.dart';

class UpcomingShoots extends StatelessWidget {
  const UpcomingShoots({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upcoming Shoots',
          style: theme.textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (context, index) {
            return _buildShootCard(
              context,
              clientName: ['Lisa Wong', 'David Miller'][index],
              eventType: ['Wedding Photography', 'Family Portrait'][index],
              date: ['Tomorrow, 2:00 PM', 'Dec 12, 10:00 AM'][index],
              location: ['Grand Hotel', 'Central Park'][index],
              status: ['Confirmed', 'Pending Details'][index],
              statusColor: [const Color(0xFF059669), const Color(0xFFD97706)][index],
            );
          },
        ),
      ],
    );
  }

  Widget _buildShootCard(
    BuildContext context, {
    required String clientName,
    required String eventType,
    required String date,
    required String location,
    required String status,
    required Color statusColor,
  }) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  eventType,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.person,
                  size: 16,
                  color: theme.iconTheme.color,
                ),
                const SizedBox(width: 4),
                Text(
                  clientName,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: theme.iconTheme.color,
                ),
                const SizedBox(width: 4),
                Text(
                  date,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 16,
                  color: theme.iconTheme.color,
                ),
                const SizedBox(width: 4),
                Text(
                  location,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.message, size: 16),
                    label: Text('Message'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.info, size: 16),
                    label: Text('Details'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}