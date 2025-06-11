import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swornim/pages/models/location.dart';
import 'package:swornim/pages/models/review.dart';
import 'package:swornim/pages/service_providers/makeupartist/makeupartist_detail_page.dart';
import 'package:swornim/pages/models/service_providers/makeup_artist.dart';

class MakeupArtistListPage extends StatefulWidget {
  const MakeupArtistListPage({super.key});

  @override
  State<MakeupArtistListPage> createState() => _MakeupArtistListPageState();
}

class _MakeupArtistListPageState extends State<MakeupArtistListPage>
    with TickerProviderStateMixin {
  // Update the makeup artists list initialization
  final List<MakeupArtist> makeupArtists = [
    MakeupArtist(
      id: '1',
      name: 'Sophia Anderson',
      image: 'assets/makeup_artist1.jpg',
      location: Location(
        name: 'New York',
        address: 'New York, NY',
        latitude: 40.7128,
        longitude: -74.0060,
        city: 'New York',
        state: 'NY',
        country: 'USA',
      ),
      price: '\$150/hr',
      description: 'Experienced bridal and evening makeup artist specializing in glamorous looks.',
      rating: 4.8,
      totalClients: 120,
      responseTime: '1hr',
      specialties: ['Bridal Makeup', 'Evening Glam', 'Natural Look'],
      portfolio: ['assets/makeup_artist1.jpg'],
      services: [
        {
          'name': 'Bridal Makeup',
          'duration': '2 hrs',
          'price': '\$300'
        },
        {
          'name': 'Evening Makeup',
          'duration': '1.5 hrs',
          'price': '\$200'
        }
      ],
      reviews: [
        Review(
          id: 'r1',
          bookingId: 'b1',
          clientId: '1',
          serviceProviderId: '1',
          rating: 5,
          comment: 'Amazing work! Very professional and talented.',
          createdAt: DateTime.now(),
        )
      ],
      isAvailable: true,
    ),
    MakeupArtist(
      id: '2',
      name: 'Emma Thompson',
      image: 'assets/makeup_artist2.jpg',
      location: Location(
        name: 'Los Angeles',
        address: 'Los Angeles, CA',
        latitude: 34.0522,
        longitude: -118.2437,
        city: 'Los Angeles',
        state: 'CA',
        country: 'USA',
      ),
      price: '\$120/hr',
      description: 'Fashion and editorial makeup expert with extensive photoshoot experience.',
      rating: 4.6,
      totalClients: 95,
      responseTime: '2hrs',
      specialties: ['Editorial Makeup', 'Fashion Shows', 'Photoshoot Makeup'],
      portfolio: ['assets/makeup_artist2.jpg'],
      services: [
        {
          'name': 'Editorial Makeup',
          'duration': '3 hrs',
          'price': '\$360'
        },
        {
          'name': 'Photoshoot Makeup',
          'duration': '2 hrs',
          'price': '\$240'
        }
      ],
      reviews: [
        Review(
          id: 'r2',
          bookingId: 'b2',
          clientId: '2',
          serviceProviderId: '2',
          rating: 4,
          comment: 'Great experience, very creative and attentive.',
          createdAt: DateTime.now(),
        )
      ],
      isAvailable: true,
    ),
    MakeupArtist(
      id: '3',
      name: 'Michael Chen',
      image: 'assets/makeup_artist3.jpg',
      location: Location(
        name: 'Chicago',
        address: 'Chicago, IL',
        latitude: 41.8781,
        longitude: -87.6298,
        city: 'Chicago',
        state: 'IL',
        country: 'USA',
      ),
      price: '\$180/hr',
      description: 'Specialized in special effects and theatrical makeup for film and stage.',
      rating: 4.9,
      totalClients: 80,
      responseTime: '30min',
      specialties: ['Special Effects', 'Film Makeup', 'Theater Makeup'],
      portfolio: ['assets/makeup_artist3.jpg'],
      services: [
        {
          'name': 'Special Effects Makeup',
          'duration': '4 hrs',
          'price': '\$720'
        },
        {
          'name': 'Theater Makeup',
          'duration': '3 hrs',
          'price': '\$540'
        }
      ],
      reviews: [
        Review(
          id: 'r3',
          bookingId: 'b3',
          clientId: '1',
          serviceProviderId: '3',
          rating: 5,
          comment: 'Incredible skills, brought my character to life!',
          createdAt: DateTime.now(),
        )
      ],
      isAvailable: false,
    ),
    MakeupArtist(
      id: '4',
      name: 'Priya Patel',
      image: 'assets/makeup_artist4.jpg',
      location: Location(
        name: 'Houston',
        address: 'Houston, TX',
        latitude: 29.7604,
        longitude: -95.3698,
        city: 'Houston',
        state: 'TX',
        country: 'USA',
      ),
      price: '\$140/hr',
      description: 'Expert in traditional and cultural makeup for special ceremonies and events.',
      rating: 4.7,
      totalClients: 110,
      responseTime: '1hr',
      specialties: ['Traditional Makeup', 'Cultural Events', 'Ceremonial Look'],
      portfolio: ['assets/makeup_artist4.jpg'],
      services: [
        {
          'name': 'Traditional Makeup',
          'duration': '2.5 hrs',
          'price': '\$350'
        },
        {
          'name': 'Cultural Event Makeup',
          'duration': '3 hrs',
          'price': '\$420'
        }
      ],
      reviews: [
        Review(
          id: 'r4',
          bookingId: 'b4',
          clientId: '4',
          serviceProviderId: '4',
          rating: 5,
          comment: 'Fabulous job, very respectful of cultural details.',
          createdAt: DateTime.now(),
        )
      ],
      isAvailable: true,
    ),
    MakeupArtist(
      id: '5',
      name: 'Isabella Martinez',
      image: 'assets/makeup_artist5.jpg',
      location: Location(
        name: 'Miami',
        address: 'Miami, FL',
        latitude: 25.7617,
        longitude: -80.1918,
        city: 'Miami',
        state: 'FL',
        country: 'USA',
      ),
      price: '\$160/hr',
      description: 'Specializing in airbrush and HD makeup for lasting, flawless looks.',
      rating: 4.8,
      totalClients: 130,
      responseTime: '45min',
      specialties: ['Airbrush Makeup', 'HD Makeup', 'Long-wear Makeup'],
      portfolio: ['assets/makeup_artist5.jpg'],
      services: [
        {
          'name': 'Airbrush Makeup',
          'duration': '2 hrs',
          'price': '\$320'
        },
        {
          'name': 'HD Makeup',
          'duration': '1.5 hrs',
          'price': '\$240'
        }
      ],
      reviews: [
        Review(
          id: 'r5',
          bookingId: 'b5',
          clientId: '5',
          serviceProviderId: '5',
          rating: 5,
          comment: 'Makeup lasted all day and night, highly recommend!',
          createdAt: DateTime.now(),
        )
      ],
      isAvailable: true,
    ),
  ];

  List<MakeupArtist> filteredMakeupArtists = [];
  String searchQuery = '';
  String selectedFilter = 'All';
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final FocusNode _searchFocusNode = FocusNode();

  final List<String> filterOptions = [
    'All',
    'Bridal',
    'Editorial',
    'Natural',
    'Special Effects',
    'Traditional',
    'Airbrush'
  ];

  @override
  void initState() {
    super.initState();
    filteredMakeupArtists = makeupArtists;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void filterMakeupArtists(String query, [String? filter]) {
    final filterValue = filter ?? selectedFilter;
    
    final results = makeupArtists.where((artist) {
      final specialties = artist.specialties.join(' ').toLowerCase();
      final services = artist.services.map((s) => s['name']).join(' ').toLowerCase();
      final input = query.toLowerCase();

      bool matchesSearch = query.isEmpty ||
          specialties.contains(input) ||
          services.contains(input);

      bool matchesFilter = filterValue == 'All' ||
          specialties.contains(filterValue.toLowerCase()) ||
          services.contains(filterValue.toLowerCase());

      return matchesSearch && matchesFilter;
    }).toList();

    setState(() {
      searchQuery = query;
      selectedFilter = filterValue;
      filteredMakeupArtists = results;
    });
  }

  void clearSearch() {
    _searchController.clear();
    _searchFocusNode.unfocus();
    filterMakeupArtists('', 'All');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: CustomScrollView(
        slivers: [
          // Professional App Bar with theme colors
          SliverAppBar(
            expandedHeight: 160,
            floating: false,
            pinned: true,
            backgroundColor: Colors.white,
            foregroundColor: theme.colorScheme.onSurface,
            elevation: 0,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
            ),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              title: Text(
                'Find Makeup Artists',
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white,
                      theme.colorScheme.background,
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // Professional geometric elements using theme colors
                    Positioned(
                      right: -40,
                      top: 30,
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.colorScheme.primary.withOpacity(0.08),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 15,
                      top: 55,
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          Icons.brush_rounded,
                          color: theme.colorScheme.primary,
                          size: 32,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 80,
                      top: 90,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      theme.colorScheme.primary.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Professional Search and Filter Section
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withOpacity(0.08),
                      blurRadius: 32,
                      offset: const Offset(0, 12),
                      spreadRadius: -4,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  border: Border.all(
                    color: theme.colorScheme.secondary.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Beauty Experts',
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.3,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Find professional makeup artists for your special occasions',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            Icons.palette_rounded,
                            color: theme.colorScheme.primary,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Enhanced Search Bar with theme colors
                    Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.background,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: _searchFocusNode.hasFocus 
                              ? theme.colorScheme.primary
                              : theme.colorScheme.secondary.withOpacity(0.3),
                          width: _searchFocusNode.hasFocus ? 2 : 1,
                        ),
                        boxShadow: _searchFocusNode.hasFocus ? [
                          BoxShadow(
                            color: theme.colorScheme.primary.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ] : null,
                      ),
                      child: TextField(
                        controller: _searchController,
                        focusNode: _searchFocusNode,
                        onChanged: (value) => filterMakeupArtists(value),
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: 15,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search makeup artists, specializations, services...',
                          hintStyle: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.5),
                            fontSize: 15,
                          ),
                          prefixIcon: Container(
                            margin: const EdgeInsets.only(left: 18, right: 14),
                            child: Icon(
                              Icons.search_rounded,
                              color: theme.colorScheme.primary,
                              size: 22,
                            ),
                          ),
                          suffixIcon: searchQuery.isNotEmpty
                              ? IconButton(
                                  icon: Icon(
                                    Icons.close_rounded,
                                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                                    size: 20,
                                  ),
                                  onPressed: clearSearch,
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 18,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Enhanced Filter Chips with theme colors
                    SizedBox(
                      height: 38,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: filterOptions.length,
                        separatorBuilder: (context, index) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final filter = filterOptions[index];
                          final isSelected = selectedFilter == filter;
                          
                          return GestureDetector(
                            onTap: () => filterMakeupArtists(searchQuery, filter),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 9,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected 
                                    ? theme.colorScheme.primary
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(19),
                                border: Border.all(
                                  color: isSelected 
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.secondary.withOpacity(0.4),
                                  width: 1.5,
                                ),
                                boxShadow: isSelected ? [
                                  BoxShadow(
                                    color: theme.colorScheme.primary.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ] : null,
                              ),
                              child: Text(
                                filter,
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: isSelected 
                                      ? Colors.white
                                      : theme.colorScheme.onSurface.withOpacity(0.7),
                                  fontWeight: isSelected 
                                      ? FontWeight.w600 
                                      : FontWeight.w500,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    
                    if (searchQuery.isNotEmpty || selectedFilter != 'All') ...[
                      const SizedBox(height: 18),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: theme.colorScheme.primary.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          '${filteredMakeupArtists.length} makeup artist${filteredMakeupArtists.length != 1 ? 's' : ''} found',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),

          // Results Section
          filteredMakeupArtists.isEmpty
              ? SliverToBoxAdapter(child: _buildEmptyState(theme))
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final artist = filteredMakeupArtists[index];
                      return FadeTransition(
                        opacity: _fadeAnimation,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            20,
                            index == 0 ? 20 : 10,
                            20,
                            index == filteredMakeupArtists.length - 1 ? 32 : 10,
                          ),
                          child: _buildMakeupArtistCard(artist, theme, index),
                        ),
                      );
                    },
                    childCount: filteredMakeupArtists.length,
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Icon(
              Icons.brush_outlined,
              size: 56,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            searchQuery.isEmpty && selectedFilter == 'All'
                ? 'No makeup artists available'
                : 'No matches found',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            searchQuery.isEmpty && selectedFilter == 'All'
                ? 'Check back later for available makeup artists in your area'
                : 'Try adjusting your search terms or filters',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          if (searchQuery.isNotEmpty || selectedFilter != 'All') ...[
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: clearSearch,
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: const Text('Reset Filters'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 2,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // Update the _buildMakeupArtistCard method
 
// Updated Makeup Artist Card (Consistent with Photographer Card)
Widget _buildMakeupArtistCard(MakeupArtist artist, ThemeData theme, int index) {
  return Hero(
    tag: 'makeup_artist_${artist.name}_$index',
    child: Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              theme.colorScheme.background.withOpacity(0.3),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 6),
              spreadRadius: -2,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: theme.colorScheme.secondary.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MakeupArtistDetailPage(makeupArtist: artist),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main Info Section - Better layout for name
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Image
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: theme.colorScheme.secondary.withOpacity(0.3),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.primary.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.asset(
                          artist.image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Icon(
                                Icons.brush_rounded,
                                color: theme.colorScheme.primary,
                                size: 28,
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Name and Details - Fixed layout
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name with proper overflow handling
                          Text(
                            artist.name,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.3,
                              height: 1.2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),

                          // Location with icon
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 16,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(width: 4),
                            Expanded(
                                  child: Text(
                                    artist.location?.name ?? 'Location not specified',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Status badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: artist.isAvailable
                                  ? Colors.green.withOpacity(0.1)
                                  : Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: artist.isAvailable
                                    ? Colors.green.withOpacity(0.3)
                                    : Colors.red.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: artist.isAvailable ? Colors.green : Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  artist.isAvailable ? 'Available' : 'Unavailable',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: artist.isAvailable
                                        ? Colors.green.shade700
                                        : Colors.red.shade700,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Price badge - positioned separately
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            theme.colorScheme.primary,
                            theme.colorScheme.tertiary,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.primary.withOpacity(0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        artist.price,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),

                // Specialties Section
                if (artist.specialties.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.background,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: theme.colorScheme.secondary.withOpacity(0.25),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Specialties',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 6,
                          children: artist.specialties.take(3).map((specialty) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: theme.colorScheme.secondary.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                specialty,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurface,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        if (artist.specialties.length > 3)
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              '+${artist.specialties.length - 3} more',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 16),

                // Action Button
                SizedBox(
                  width: double.infinity,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MakeupArtistDetailPage(makeupArtist: artist),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                      elevation: 2,
                      shadowColor: theme.colorScheme.primary.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'View Profile',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
    );
  }
}