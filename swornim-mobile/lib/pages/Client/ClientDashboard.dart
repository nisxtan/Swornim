// pages/client/client_dashboard.dart (Updated version of UserHomePage)
import 'package:flutter/material.dart';
import 'package:swornim/pages/components/common/common/profile/profile_panel.dart';
import 'package:swornim/pages/introduction/slider.dart';
import 'package:swornim/pages/layouts/main_layout.dart';
import 'package:swornim/pages/service_providers/makeupartist/makeupartist_list_page.dart';
import 'package:swornim/pages/service_providers/photographer/photographer_list_page.dart';
import 'package:swornim/pages/service_providers/venues/venuelistpage.dart';
import 'package:swornim/pages/widgets/client/dashboard/service_grid.dart';
import 'package:swornim/pages/widgets/client/dashboard/upcoming_events.dart';
import 'package:swornim/pages/widgets/client/dashboard/welcome_section.dart';

class ClientDashboard extends StatefulWidget {
  const ClientDashboard({super.key});

  @override
  _ClientDashboardState createState() => _ClientDashboardState();
}

class _ClientDashboardState extends State<ClientDashboard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
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
        // Handle notification tap
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notifications clicked')),
        );
      },
      onProfileTap: () {
        // Handle profile tap
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: ProfilePanel()),
        );
      },
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome section
              const WelcomeSection(),
              
              const SizedBox(height: 32),

              // Carousel section
              const HomeCarousel(),
              
              const SizedBox(height: 32),

              // Services section
              ServiceGrid(onServiceTap: _handleFeatureTap),
              
              const SizedBox(height: 40),

              // Upcoming events section
              const UpcomingEvents(),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFeatureTap(String label, BuildContext context) {
    switch (label) {
      case 'Book Venue':
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const VenueListPage()),
        // );
        break;
      case 'Photographers':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PhotographerListPage()),
        );
        break;
      case 'Makeup Artists':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MakeupArtistListPage()),
        );
        break;
      case 'Decorators':
        // Navigator.push(context, MaterialPageRoute(builder: (context) => DecoratorListPage()));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Decorators feature coming soon!')),
        );
        break;
    }
  }
}