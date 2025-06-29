// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:swornim/pages/providers/service_providers/models/makeup_artist.dart';

// class MakeupArtistDetailPage extends StatefulWidget {
//   final MakeupArtist makeupArtist;

//   const MakeupArtistDetailPage({super.key, required this.makeupArtist});

//   @override
//   State<MakeupArtistDetailPage> createState() => _MakeupArtistDetailPageState();
// }

// // -------------------
// // State Management and Animations
// // -------------------
// class _MakeupArtistDetailPageState extends State<MakeupArtistDetailPage> with TickerProviderStateMixin {
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
//                   // Hero Image
//                   Hero(
//                     tag: 'makeup_artist_${widget.makeupArtist.name}',
//                     child: Image.asset(
//                       widget.makeupArtist.image,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) {
//                         return Container(
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                               colors: [
//                                 theme.colorScheme.primary.withOpacity(0.3),
//                                 theme.colorScheme.secondary.withOpacity(0.3),
//                               ],
//                             ),
//                           ),
//                           child: Icon(
//                             Icons.brush_rounded,
//                             size: 80,
//                             color: theme.colorScheme.primary,
//                           ),
//                         );
//                       },
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
//                           Colors.transparent,
//                           Colors.black.withOpacity(0.6),
//                           Colors.black.withOpacity(0.8),
//                         ],
//                         stops: const [0.0, 0.3, 0.7, 1.0],
//                       ),
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
//                   // Bottom Info
//                   Positioned(
//                     bottom: 20,
//                     left: 20,
//                     right: 20,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           widget.makeupArtist.name,
//                           style: GoogleFonts.playfairDisplay(
//                             fontSize: 28,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.white,
//                             letterSpacing: -0.5,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.location_on_rounded,
//                               size: 18,
//                               color: Colors.white.withOpacity(0.9),
//                             ),
//                             const SizedBox(width: 6),
//                             Text(
//                               widget.makeupArtist.location?.name ?? 'Location not specified',
//                               style: GoogleFonts.inter(
//                                 fontSize: 16,
//                                 color: Colors.white.withOpacity(0.9),
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             const Spacer(),
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
//                               child: Text(
//                                 widget.makeupArtist.price,
//                                 style: GoogleFonts.inter(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w700,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
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
                    
//                     // Specialties Section
//                     _buildSpecialtiesSection(theme),
                    
//                     const SizedBox(height: 24),
                    
//                     // Portfolio Preview
//                     _buildPortfolioPreview(theme),
                    
//                     const SizedBox(height: 24),
                    
//                     // Services Section
//                     _buildServicesSection(theme),
                    
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
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 20,
//               offset: const Offset(0, -4),
//             ),
//           ],
//         ),
//         child: SafeArea(
//           child: Row(
//             children: [
//               // Contact Button
//               Expanded(
//                 child: OutlinedButton.icon(
//                   onPressed: () {
//                     // TODO: Handle contact logic
//                   },
//                   icon: Icon(
//                     Icons.message_rounded,
//                     size: 18,
//                     color: theme.colorScheme.primary,
//                   ),
//                   label: Text(
//                     'Contact',
//                     style: GoogleFonts.inter(
//                       fontWeight: FontWeight.w600,
//                       color: theme.colorScheme.primary,
//                     ),
//                   ),
//                   style: OutlinedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     side: BorderSide(
//                       color: theme.colorScheme.primary,
//                       width: 2,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                   ),
//                 ),
//               ),
              
//               const SizedBox(width: 16),
              
//               // Book Session Button
//               Expanded(
//                 flex: 2,
//                 child: ElevatedButton.icon(
//                   onPressed: () {
//                     // TODO: Handle booking logic
//                   },
//                   icon: const Icon(Icons.brush_rounded, size: 18),
//                   label: Text(
//                     'Book Session',
//                     style: GoogleFonts.inter(
//                       fontWeight: FontWeight.w700,
//                       fontSize: 16,
//                     ),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: theme.colorScheme.primary,
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     elevation: 4,
//                     shadowColor: theme.colorScheme.primary.withOpacity(0.3),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
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
//           _buildStatItem(theme, widget.makeupArtist.rating.toString(), 'Rating', 
//               Icons.star_rounded, Colors.amber),
//           _buildStatDivider(theme),
//           _buildStatItem(theme, '${widget.makeupArtist.totalClients}+', 'Clients', 
//               Icons.face_rounded, theme.colorScheme.primary),
//           _buildStatDivider(theme),
//           _buildStatItem(theme, widget.makeupArtist.responseTime, 'Response', 
//               Icons.schedule_rounded, Colors.green),
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
//                   Icons.person_rounded,
//                   color: theme.colorScheme.primary,
//                   size: 20,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Text(
//                 'About',
//                 style: GoogleFonts.playfairDisplay(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w700,
//                   color: theme.colorScheme.onSurface,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           Text(
//             'A passionate makeup artist with over 6 years of experience in enhancing natural beauty and creating stunning transformations. Specializing in bridal makeup, editorial looks, and special occasion styling, I bring creativity, precision, and artistry to every client.\n\nMy approach focuses on understanding each client\'s unique features and personal style, ensuring they feel confident and radiant. I use only high-quality, professional products and stay updated with the latest trends and techniques in the beauty industry.',
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
//   // Specialties Section Builder
//   // -------------------
//   Widget _buildSpecialtiesSection(ThemeData theme) {
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
//                   Icons.palette_rounded,
//                   color: theme.colorScheme.primary,
//                   size: 20,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Text(
//                 'Specialties',
//                 style: GoogleFonts.playfairDisplay(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w700,
//                   color: theme.colorScheme.onSurface,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           Wrap(
//             spacing: 10,
//             runSpacing: 10,
//             children: widget.makeupArtist.specialties.map((specialty) {
//               return Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 12,
//                 ),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       theme.colorScheme.primary.withOpacity(0.1),
//                       theme.colorScheme.secondary.withOpacity(0.1),
//                     ],
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(
//                     color: theme.colorScheme.primary.withOpacity(0.2),
//                     width: 1,
//                   ),
//                 ),
//                 child: Text(
//                   specialty,
//                   style: GoogleFonts.inter(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: theme.colorScheme.primary,
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }

//   // -------------------
//   // Portfolio Preview Builder
//   // -------------------
//   Widget _buildPortfolioPreview(ThemeData theme) {
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
//                   'Portfolio',
//                   style: GoogleFonts.playfairDisplay(
//                     fontSize: 22,
//                     fontWeight: FontWeight.w700,
//                     color: theme.colorScheme.onSurface,
//                   ),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   // TODO: Navigate to full portfolio
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
//           SizedBox(
//             height: 120,
//             child: ListView.separated(
//               scrollDirection: Axis.horizontal,
//               itemCount: widget.makeupArtist.portfolio.length,
//               separatorBuilder: (context, index) => const SizedBox(width: 12),
//               itemBuilder: (context, index) {
//                 return Container(
//                   width: 120,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(
//                       color: theme.colorScheme.secondary.withOpacity(0.2),
//                       width: 1,
//                     ),
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: Image.network(
//                       widget.makeupArtist.portfolio[index],
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) {
//                         return Icon(
//                           Icons.brush_rounded,
//                           color: theme.colorScheme.primary,
//                           size: 32,
//                         );
//                       },
//                     ),
//                   ),
//                 );
//               },
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
//                   Icons.brush_outlined,
//                   color: theme.colorScheme.primary,
//                   size: 20,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Text(
//                 'Services',
//                 style: GoogleFonts.playfairDisplay(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w700,
//                   color: theme.colorScheme.onSurface,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//             ...widget.makeupArtist.services.map((service) => 
//             _buildServiceItem(theme, Map<String, String>.from(service))),
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
//                   color: Colors.amber,
//                   size: 20,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Text(
//                   'Reviews',
//                   style: GoogleFonts.playfairDisplay(
//                     fontSize: 22,
//                     fontWeight: FontWeight.w700,
//                     color: theme.colorScheme.onSurface,
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
//           ...widget.makeupArtist.reviews.take(3).map((review) => 
//             _buildReviewItem(
//               theme,
//                 review.clientId, // or use another field for name if available
//                 review.comment,
//                 review.rating.toInt(),
//             )),
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
//   }Widget _buildServiceItem(ThemeData theme, Map<String, String> service) {
//     // Individual service item builder
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: theme.colorScheme.background,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: theme.colorScheme.secondary.withOpacity(0.2),
//           width: 1,
//         ),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 48,
//             height: 48,
//             decoration: BoxDecoration(
//               color: theme.colorScheme.primary.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(
//               Icons.brush_rounded,
//               color: theme.colorScheme.primary,
//               size: 24,
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   service['name']!,
//                   style: GoogleFonts.inter(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 16,
//                     color: theme.colorScheme.onSurface,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.schedule_rounded,
//                       size: 14,
//                       color: theme.colorScheme.onSurface.withOpacity(0.6),
//                     ),
//                     const SizedBox(width: 4),
//                     Text(
//                       service['duration']!,
//                       style: GoogleFonts.inter(
//                         fontSize: 12,
//                         color: theme.colorScheme.onSurface.withOpacity(0.6),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Text(
//             service['price']!,
//             style: GoogleFonts.inter(
//               fontWeight: FontWeight.w700,
//               fontSize: 16,
//               color: theme.colorScheme.primary,
//             ),
//           ),
//         ],
//       ),
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