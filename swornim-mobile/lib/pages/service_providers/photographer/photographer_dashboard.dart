// pages/cameraman/cameraman_dashboard.dart
import 'package:flutter/material.dart';
import 'package:swornim/pages/layouts/main_layout.dart';
import 'package:swornim/pages/widgets/photographer/dashboard/booking_requests.dart';
import 'package:swornim/pages/widgets/photographer/dashboard/earnings_overview.dart';
import 'package:swornim/pages/widgets/photographer/dashboard/portfolio_section.dart';
import 'package:swornim/pages/widgets/photographer/dashboard/quick_actions.dart';
import 'package:swornim/pages/widgets/photographer/dashboard/upcoming_shoots.dart';
import 'package:swornim/pages/widgets/photographer/dashboard/welcome_section.dart';

class PhotographerDashboard extends StatefulWidget {
  const PhotographerDashboard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PhotographerDashboardState createState() => _PhotographerDashboardState();
}

class _PhotographerDashboardState extends State<PhotographerDashboard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      showFooter: true,
      showAppBar: true,
      onNotificationTap: () {
        _handleNotificationTap();
      },
      onProfileTap: () {
        _handleProfileTap();
      },
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome section
                const WelcomeSection(),
                
                const SizedBox(height: 24),

                // Quick stats/earnings overview
                const EarningsOverview(),
                
                const SizedBox(height: 24),

                // Quick actions
                QuickActions(onActionTap: _handleQuickAction),
                
                const SizedBox(height: 32),

                // Booking requests section
                const BookingRequests(),
                
                const SizedBox(height: 32),

                // Upcoming shoots
                const UpcomingShoots(),
                
                const SizedBox(height: 32),

                // Portfolio section
                const PortfolioSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleNotificationTap() {
    // Navigate to notifications page or show notifications
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('📸 You have 3 new booking requests!'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _handleProfileTap() {
    // Navigate to profile/settings
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening cameraman profile...'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _handleQuickAction(String action) {
    switch (action) {
      case 'Update Availability':
        _showAvailabilityDialog();
        break;
      case 'Manage Portfolio':
        _navigateToPortfolioManagement();
        break;
      case 'View Bookings':
        _navigateToBookings();
        break;
      case 'Earnings Report':
        _navigateToEarnings();
        break;
      case 'Update Rates':
        _showRatesDialog();
        break;
      case 'Client Reviews':
        _navigateToReviews();
        break;
    }
  }

  void _showAvailabilityDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Availability'),
          content: const Text('Set your available dates and times for bookings.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Availability updated!')),
                );
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _showRatesDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Rates'),
          content: const Text('Modify your hourly rates and package pricing.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Rates updated successfully!')),
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToPortfolioManagement() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening portfolio management...')),
    );
    // Navigator.push(context, MaterialPageRoute(builder: (context) => PortfolioManagementPage()));
  }

  void _navigateToBookings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening bookings page...')),
    );
    // Navigator.push(context, MaterialPageRoute(builder: (context) => BookingsPage()));
  }

  void _navigateToEarnings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening earnings report...')),
    );
    // Navigator.push(context, MaterialPageRoute(builder: (context) => EarningsPage()));
  }

  void _navigateToReviews() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening client reviews...')),
    );
    // Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewsPage()));
  }
}