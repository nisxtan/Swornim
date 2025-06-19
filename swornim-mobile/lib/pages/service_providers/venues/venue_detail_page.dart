// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:swornim/pages/providers/service_providers/models/venue.dart';
// import 'package:swornim/pages/service_providers/venues/service_tile.dart';
// import 'package:swornim/pages/booking/booking_venue.dart';

// class VenueDetailPage extends StatefulWidget {
//   final Venue venue;

//   const VenueDetailPage({super.key, required this.venue});

//   @override
//   State<VenueDetailPage> createState() => _VenueDetailPageState();
// }

// // -------------------
// // State Management and Animations
// // -------------------
// class _VenueDetailPageState extends State<VenueDetailPage> with TickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;
//   final ScrollController _scrollController = ScrollController();
//   bool _isScrolled = false;

//   // -------------------
//   // Lifecycle Methods
//   // -------------------
//   @override
//   void initState() {
//     // Animation and scroll controller setup
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 600),
//       vsync: this,
//     );
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
//     );
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.3),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

//     _scrollController.addListener(() {
//       if (_scrollController.offset > 100 && !_isScrolled) {
//         setState(() => _isScrolled = true);
//       } else if (_scrollController.offset <= 100 && _isScrolled) {
//         setState(() => _isScrolled = false);
//       }
//     });

//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     // Cleanup
//     _animationController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   // -------------------
//   // Main Build Method
//   // -------------------
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
    
//     return Scaffold(
//       // -------------------
//       // Custom Sliver App Bar with Hero Image
//       // -------------------
//       body: CustomScrollView(
//         controller: _scrollController,
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 320,
//             floating: false,
//             pinned: true,
//             backgroundColor: Colors.white,
//             foregroundColor: theme.colorScheme.onSurface,
//             elevation: _isScrolled ? 4 : 0,
//             shadowColor: theme.colorScheme.primary.withOpacity(0.1),
//             systemOverlayStyle: const SystemUiOverlayStyle(
//               statusBarColor: Colors.transparent,
//               statusBarIconBrightness: Brightness.light,
//             ),
//             leading: Container(
//               margin: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.9),
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 8,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: IconButton(
//                 icon: Icon(
//                   Icons.arrow_back_rounded,
//                   color: theme.colorScheme.onSurface,
//                 ),
//                 onPressed: () => Navigator.pop(context),
//               ),
//             ),
//             actions: [
//               Container(
//                 margin: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.9),
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 8,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: IconButton(
//                   icon: Icon(
//                     Icons.favorite_border_rounded,
//                     color: theme.colorScheme.primary,
//                   ),
//                   onPressed: () {
//                     // TODO: Handle favorite logic
//                   },
//                 ),
//               ),
//             ],
//             flexibleSpace: FlexibleSpaceBar(
//               background: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   // Hero Image with gradient overlay
//                   Hero(
//                     tag: 'venue_${widget.venue.name}',
//                     child: Material(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: theme.colorScheme.surface,
//                           image: DecorationImage(
//                             image: AssetImage(widget.venue.image),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
                  
//                   // Gradient Overlay
//                   Container(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           Colors.transparent,
//                           Colors.black.withOpacity(0.7),
//                         ],
//                         stops: const [0.6, 1.0],
//                       ),
//                     ),
//                   ),

//                   // Bottom Info
//                   Positioned(
//                     bottom: 20,
//                     left: 20,
//                     right: 20,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           widget.venue.name,
//                           style: theme.textTheme.headlineMedium?.copyWith(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 28,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.location_on_outlined,
//                               size: 16,
//                               color: Colors.white.withOpacity(0.9),
//                             ),
//                             const SizedBox(width: 4),
//                             Expanded(
//                               child:  Text(
//                               widget.venue.location?.name ?? 'Location not available',
//                               style: GoogleFonts.inter(
//                                 fontSize: 16,
//                                 color: Colors.white.withOpacity(0.9),
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             ),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 16,
//                                 vertical: 8,
//                               ),
//                               decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                                   colors: [
//                                     theme.colorScheme.primary,
//                                     theme.colorScheme.tertiary,
//                                   ],
//                                 ),
//                                 borderRadius: BorderRadius.circular(20),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: theme.colorScheme.primary.withOpacity(0.3),
//                                     blurRadius: 8,
//                                     offset: const Offset(0, 2),
//                                   ),
//                                 ],
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Text(
//                                     'Rs. ${widget.venue.pricePerHour}',
//                                     style: GoogleFonts.inter(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 14,
//                                     ),
//                                   ),
                                  
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),

//                   // Status Badge
//                   Positioned(
//                     top: 60,
//                     right: 20,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 12,
//                         vertical: 6,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.green,
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.green.withOpacity(0.3),
//                             blurRadius: 8,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Container(
//                             width: 8,
//                             height: 8,
//                             decoration: const BoxDecoration(
//                               color: Colors.white,
//                               shape: BoxShape.circle,
//                             ),
//                           ),
//                           const SizedBox(width: 6),
//                           Text(
//                             'Available',
//                             style: GoogleFonts.inter(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w600,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // -------------------
//           // Main Content Section
//           // -------------------
//           SliverToBoxAdapter(
//             child: FadeTransition(
//               opacity: _fadeAnimation,
//               child: SlideTransition(
//                 position: _slideAnimation,
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 24),
                    
//                     // Quick Stats
//                     _buildQuickStats(theme),
                    
//                     const SizedBox(height: 24),
                    
//                     // About Section
//                     _buildAboutSection(theme),
                    
//                     const SizedBox(height: 24),
                    
//                     // Services Section
//                     _buildServicesSection(theme),
                    
//                     const SizedBox(height: 24),
                    
//                     // Amenities Section
//                     _buildAmenitiesSection(theme),
                    
//                     const SizedBox(height: 24),
                    
//                     // Gallery Preview
//                     _buildGalleryPreview(theme),
                    
//                     const SizedBox(height: 24),
                    
//                     // Reviews Section
//                     _buildReviewsSection(theme),
                    
//                     const SizedBox(height: 32),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
      
//       // -------------------
//       // Bottom Action Bar
//       // -------------------
//       bottomNavigationBar: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: theme.colorScheme.surface,
//           borderRadius: const BorderRadius.vertical(
//             top: Radius.circular(20),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: theme.colorScheme.shadow.withOpacity(0.1),
//               blurRadius: 20,
//               offset: const Offset(0, -4),
//             ),
//           ],
//         ),
//         child: SafeArea(
//           child: Row(
//             children: [
//               Expanded(
//                 child: OutlinedButton(
//                   onPressed: () {},
//                   style: OutlinedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     side: BorderSide(
//                       color: theme.colorScheme.primary,
//                       width: 2,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: Text(
//                     'Contact',
//                     style: theme.textTheme.labelLarge?.copyWith(
//                       color: theme.colorScheme.primary,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 flex: 2,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => BookingPage(
//                           venue: widget.venue,
//                         ),
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: theme.colorScheme.primary,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: Text(
//                     'Book Now',
//                     style: theme.textTheme.labelLarge?.copyWith(
//                       color: theme.colorScheme.onPrimary,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // -------------------
//   // Stats Section Builder
//   // -------------------
//   Widget _buildQuickStats(ThemeData theme) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: theme.colorScheme.primary.withOpacity(0.08),
//             blurRadius: 20,
//             offset: const Offset(0, 4),
//           ),
//         ],
//         border: Border.all(
//           color: theme.colorScheme.secondary.withOpacity(0.2),
//           width: 1,
//         ),
//       ),
//       child: Row(
//         children: [
//           _buildStatItem(theme, '4.8', 'Rating', Icons.star_rounded, Colors.amber),
//           _buildStatDivider(theme),
//           _buildStatItem(theme, '500', 'Capacity', Icons.people_rounded, theme.colorScheme.primary),
//           _buildStatDivider(theme),
//           _buildStatItem(theme, '24/7', 'Support', Icons.support_agent_rounded, Colors.green),
//         ],
//       ),
//     );
//   }

//   // -------------------
//   // About Section Builder
//   // -------------------
//   Widget _buildAboutSection(ThemeData theme) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: theme.colorScheme.surface,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: theme.colorScheme.outline.withOpacity(0.2),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: theme.colorScheme.shadow.withOpacity(0.08),
//             blurRadius: 20,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: theme.colorScheme.primary.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(
//                   Icons.info_rounded,
//                   color: theme.colorScheme.primary,
//                   size: 20,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Text(
//                 'About',
//                 style: theme.textTheme.titleLarge?.copyWith(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           Text(
//             'This venue is perfect for weddings, conferences, and other large gatherings. It includes spacious interiors, scenic surroundings, and modern amenities to suit your needs.\n\nWith elegant architecture, state-of-the-art sound systems, and customizable lighting options, this venue provides the perfect backdrop for your special event. Our dedicated staff ensures seamless execution from setup to cleanup, allowing you to focus on creating memorable moments.',
//             style: GoogleFonts.inter(
//               fontSize: 15,
//               height: 1.6,
//               color: theme.colorScheme.onSurface.withOpacity(0.8),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // -------------------
//   // Services Section Builder
//   // -------------------
//   Widget _buildServicesSection(ThemeData theme) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: theme.colorScheme.surface,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: theme.colorScheme.outline.withOpacity(0.2),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: theme.colorScheme.shadow.withOpacity(0.08),
//             blurRadius: 20,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: theme.colorScheme.primary.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(
//                   Icons.room_service_rounded,
//                   color: theme.colorScheme.primary,
//                   size: 20,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Text(
//                 'Services Offered',
//                 style: theme.textTheme.titleLarge?.copyWith(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: widget.venue.services.map<Widget>((service) {
//               return ServiceTile(service: service.toString());
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }

//   // -------------------
//   // Amenities Section Builder
//   // -------------------
//   Widget _buildAmenitiesSection(ThemeData theme) {
//     final amenities = [
//       {'icon': Icons.wifi_rounded, 'name': 'Free Wi-Fi'},
//       {'icon': Icons.local_parking_rounded, 'name': 'Parking Space'},
//       {'icon': Icons.accessible_rounded, 'name': 'Wheelchair Access'},
//       {'icon': Icons.ac_unit_rounded, 'name': 'Air Conditioning'},
//       {'icon': Icons.security_rounded, 'name': 'Security'},
//       {'icon': Icons.restaurant_rounded, 'name': 'Catering'},
//     ];

//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: theme.colorScheme.surface,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: theme.colorScheme.outline.withOpacity(0.2),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: theme.colorScheme.shadow.withOpacity(0.08),
//             blurRadius: 20,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: theme.colorScheme.primary.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(
//                   Icons.hotel_class_rounded,
//                   color: theme.colorScheme.primary,
//                   size: 20,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Text(
//                 'Amenities',
//                 style: theme.textTheme.titleLarge?.copyWith(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           GridView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               childAspectRatio: 3,
//               crossAxisSpacing: 16,
//               mainAxisSpacing: 16,
//             ),
//             itemCount: amenities.length,
//             itemBuilder: (context, index) {
//               final amenity = amenities[index];
//               return Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 decoration: BoxDecoration(
//                   color: theme.colorScheme.background,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(
//                     color: theme.colorScheme.secondary.withOpacity(0.2),
//                     width: 1,
//                   ),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(
//                       amenity['icon'] as IconData,
//                       size: 20,
//                       color: theme.colorScheme.primary,
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: Text(
//                         amenity['name'] as String,
//                         style: GoogleFonts.inter(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: theme.colorScheme.onSurface,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   // -------------------
//   // Gallery Preview Builder
//   // -------------------
//   Widget _buildGalleryPreview(ThemeData theme) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: theme.colorScheme.surface,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: theme.colorScheme.outline.withOpacity(0.2),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: theme.colorScheme.shadow.withOpacity(0.08),
//             blurRadius: 20,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: theme.colorScheme.primary.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(
//                   Icons.photo_library_rounded,
//                   color: theme.colorScheme.primary,
//                   size: 20,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Text(
//                   'Gallery',
//                   style: theme.textTheme.titleLarge?.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   // TODO: Navigate to full gallery
//                 },
//                 child: Text(
//                   'View All',
//                   style: GoogleFonts.inter(
//                     color: theme.colorScheme.primary,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           GridView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               crossAxisSpacing: 10,
//               mainAxisSpacing: 10,
//             ),
//             itemCount: 6,
//             itemBuilder: (context, index) {
//               return Container(
//                 decoration: BoxDecoration(
//                   color: theme.colorScheme.primary.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(
//                     color: theme.colorScheme.secondary.withOpacity(0.2),
//                     width: 1,
//                   ),
//                 ),
//                 child: const Icon(
//                   Icons.image_rounded,
//                   color: Color.fromARGB(255, 162, 71, 11),
//                   size: 24,
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   // -------------------
//   // Reviews Section Builder
//   // -------------------
//   Widget _buildReviewsSection(ThemeData theme) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: theme.colorScheme.surface,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: theme.colorScheme.outline.withOpacity(0.2),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: theme.colorScheme.shadow.withOpacity(0.08),
//             blurRadius: 20,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: theme.colorScheme.primary.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(
//                   Icons.star_rounded,
//                   color: theme.colorScheme.primary,
//                   size: 20,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Text(
//                   'Reviews',
//                   style: theme.textTheme.titleLarge?.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   // TODO: Navigate to all reviews
//                 },
//                 child: Text(
//                   'See All',
//                   style: GoogleFonts.inter(
//                     color: theme.colorScheme.primary,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           _buildReviewItem(
//             theme,
//             'Emily Thompson',
//             'Perfect venue for our wedding! The staff was incredibly helpful and the space was beautiful.',
//             5,
//           ),
//           const SizedBox(height: 16),
//           _buildReviewItem(
//             theme,
//             'David Wilson',
//             'Great location and amenities. Our corporate event was a huge success thanks to this venue.',
//             4,
//           ),
//         ],
//       ),
//     );
//   }

//   // -------------------
//   // Helper Widgets
//   // -------------------
//   Widget _buildStatItem(ThemeData theme, String value, String label, IconData icon, Color color) {
//     // Individual stat item builder
//     return Expanded(
//       child: Column(
//         children: [
//           Container(
//             width: 48,
//             height: 48,
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(icon, color: color, size: 24),
//           ),
//           const SizedBox(height: 12),
//           Text(
//             value,
//             style: GoogleFonts.inter(
//               fontSize: 20,
//               fontWeight: FontWeight.w700,
//               color: theme.colorScheme.onSurface,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             label,
//             style: GoogleFonts.inter(
//               fontSize: 12,
//               color: theme.colorScheme.onSurface.withOpacity(0.6),
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatDivider(ThemeData theme) {
//     // Divider between stats
//     return Container(
//       width: 1,
//       height: 60,
//       color: theme.colorScheme.secondary.withOpacity(0.2),
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//     );
//   }

//   Widget _buildReviewItem(ThemeData theme, String name, String review, int rating) {
//     // Individual review item builder
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: theme.colorScheme.background,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: theme.colorScheme.secondary.withOpacity(0.2),
//           width: 1,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               CircleAvatar(
//                 radius: 20,
//                 backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
//                 child: Text(
//                   name[0],
//                   style: GoogleFonts.inter(
//                     fontWeight: FontWeight.w600,
//                     color: theme.colorScheme.primary,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       name,
//                       style: GoogleFonts.inter(
//                         fontWeight: FontWeight.w600,
//                         color: theme.colorScheme.onSurface,
//                       ),
//                     ),
//                     const SizedBox(height: 2),
//                     Row(
//                       children: List.generate(
//                         rating,
//                         (index) => const Icon(
//                           Icons.star_rounded,
//                           size: 14,
//                           color: Colors.amber,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Text(
//             review,
//             style: GoogleFonts.inter(
//               fontSize: 14,
//               color: theme.colorScheme.onSurface.withOpacity(0.7),
//               height: 1.4,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }