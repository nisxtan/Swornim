import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swornim/pages/models/location.dart';
import 'package:swornim/pages/models/service_providers/photographer.dart';
import 'package:swornim/pages/service_providers/photographer/photographer_detail_page.dart';

class PhotographerListPage extends StatefulWidget {
  const PhotographerListPage({super.key});

  @override
  State<PhotographerListPage> createState() => _PhotographerListPageState();
}

class _PhotographerListPageState extends State<PhotographerListPage>
    with TickerProviderStateMixin {
  final List<Photographer> photographers = [
    Photographer(
      id: '1',
      name: 'John Doe',
      image: 'assets/photographer1.jpg',
      // email: 'john.doe@email.com',
      // phone: '+1234567890',
      // bio: 'Experienced wedding and event photographer.',
      hourlyRate: 500.0,
      specialties: ['Wedding Photography', 'Event Coverage', 'Portraits'],
      experience: '8 years',
      location: Location(
        name: 'Downtown',
        latitude: 40.7128,
        longitude: -74.0060,
        address: '123 Main St',
        city: 'New York',
        state: 'NY',
        country: 'USA',
      ),
    ),
    Photographer(
      id: '2',
      name: 'Jane Smith',
      image: 'assets/photographer2.jpg',
      // email: 'jane.smith@email.com',
      // phone: '+1234567891',
      // bio: 'Fashion and editorial specialist.',
      hourlyRate: 400.0,
      specialties: ['Fashion Shoots', 'Editorial', 'Product Photography'],
      experience: '6 years',
      location: Location(
        name: 'City Edge',
        latitude: 40.7589,
        longitude: -73.9851,
        address: '456 Fashion Ave',
        city: 'New York',
        state: 'NY',
        country: 'USA',
      ),
    ),
    Photographer(
      id: '3',
      name: 'Alex Johnson',
      // email: 'alex.johnson@email.com',
      // phone: '+1234567892',
      // bio: 'Nature and corporate event photographer.',
      hourlyRate: 450.0,
      image: 'assets/photographer3.jpg',
      specialties: ['Nature Photography', 'Corporate Events'],
      experience: '5 years',
      location: Location(
        name: 'Lakeside',
        latitude: 40.7829,
        longitude: -73.9654,
        address: '789 Lakeside Drive',
        city: 'New York',
        state: 'NY',
        country: 'USA',
      ),
    ),
    Photographer(
      id: '4',
      name: 'Alisson Becker',
      // email: 'alisson.becker@email.com',
      // phone: '+1234567893',
      // bio: 'Nature and corporate event photographer.',
      hourlyRate: 450.0,
      image: 'assets/photographer4.jpg',
      specialties: ['Nature Photography', 'Corporate Events'],
      experience: '7 years',
      location: Location(
        name: 'Lakeside West',
        latitude: 40.7423,
        longitude: -73.9711,
        address: '321 West Lake Ave',
        city: 'New York',
        state: 'NY',
        country: 'USA',
      ),
    ),
    Photographer(
      id: '5',
      name: 'Lio Nischu',
      // email: 'lio.nischu@email.com',
      // phone: '+1234567894',
      // bio: 'Nature and corporate event photographer.',
      hourlyRate: 450.0,
      image: 'assets/photographer5.jpg',
      specialties: ['Nature Photography', 'Corporate Events'],
      experience: '4 years',
      location: Location(
        name: 'Lakeside East',
        latitude: 40.7614,
        longitude: -73.9776,
        address: '456 East Lake Blvd',
        city: 'New York',
        state: 'NY',
        country: 'USA',
      ),
    ),
  ];

  List<Photographer> filteredPhotographers = [];
  String searchQuery = '';
  String selectedFilter = 'All';
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final FocusNode _searchFocusNode = FocusNode();

  final List<String> filterOptions = [
    'All',
    'Wedding',
    'Fashion',
    'Nature',
    'Corporate',
    'Portrait'
  ];

  @override
  void initState() {
    super.initState();
    filteredPhotographers = photographers;
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

  void filterPhotographers(String query, [String? filter]) {
    final filterValue = filter ?? selectedFilter;

    final results = photographers.where((photographer) {
      final name = photographer.name.toLowerCase();
      final location = photographer.location?.name.toLowerCase() ?? '';
      final specialties = photographer.specialties.join(' ').toLowerCase();
      final input = query.toLowerCase();

      bool matchesSearch = query.isEmpty ||
          name.contains(input) ||
          location.contains(input) ||
          specialties.contains(input);

      bool matchesFilter = filterValue == 'All' ||
          specialties.contains(filterValue.toLowerCase());

      return matchesSearch && matchesFilter;
    }).toList();

    setState(() {
      searchQuery = query;
      selectedFilter = filterValue;
      filteredPhotographers = results;
    });
  }

  void clearSearch() {
    _searchController.clear();
    _searchFocusNode.unfocus();
    filterPhotographers('', 'All');
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
                'Find Photographers',
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
                          Icons.camera_alt_rounded,
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
                                'Discover Talent',
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.3,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Find professional photographers in your area',
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
                            Icons.tune_rounded,
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
                        boxShadow: _searchFocusNode.hasFocus
                            ? [
                                BoxShadow(
                                  color: theme.colorScheme.primary.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: TextField(
                        controller: _searchController,
                        focusNode: _searchFocusNode,
                        onChanged: (value) => filterPhotographers(value),
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: 15,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search photographers, locations, specialties...',
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
                            onTap: () => filterPhotographers(searchQuery, filter),
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
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: theme.colorScheme.primary.withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ]
                                    : null,
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
                          '${filteredPhotographers.length} photographer${filteredPhotographers.length != 1 ? 's' : ''} found',
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
          filteredPhotographers.isEmpty
              ? SliverToBoxAdapter(child: _buildEmptyState(theme))
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final photographer = filteredPhotographers[index];
                      return FadeTransition(
                        opacity: _fadeAnimation,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            20,
                            index == 0 ? 20 : 10,
                            20,
                            index == filteredPhotographers.length - 1 ? 32 : 10,
                          ),
                          child: _buildPhotographerCard(photographer, theme, index),
                        ),
                      );
                    },
                    childCount: filteredPhotographers.length,
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
              Icons.camera_alt_outlined,
              size: 56,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            searchQuery.isEmpty && selectedFilter == 'All'
                ? 'No photographers available'
                : 'No matches found',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            searchQuery.isEmpty && selectedFilter == 'All'
                ? 'Check back later for available photographers in your area'
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

  Widget _buildPhotographerCard(Photographer photographer, ThemeData theme, int index) {
    return Hero(
      tag: 'photographer_${photographer.name}_$index',
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
                  builder: (context) => PhotographerDetailPage(photographer: photographer),
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
                            photographer.image,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Icon(
                                  Icons.camera_alt_rounded,
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
                              photographer.name,
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
                                    photographer.location?.name ?? 'Location not specified',
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
                                color: photographer.isAvailable
                                    ? Colors.green.withOpacity(0.1)
                                    : Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: photographer.isAvailable
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
                                      color: photographer.isAvailable ? Colors.green : Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    photographer.isAvailable ? 'Available' : 'Unavailable',
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: photographer.isAvailable
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
                          'Rs.${photographer.hourlyRate.toStringAsFixed(0)}/hr',
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
                  if (photographer.specialties.isNotEmpty) ...[
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
                            children: photographer.specialties.take(3).map((specialty) {
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
                          if (photographer.specialties.length > 3)
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                '+${photographer.specialties.length - 3} more',
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
                            builder: (context) => PhotographerDetailPage(photographer: photographer),
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
      ),
    );
  }
}