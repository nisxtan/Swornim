import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swornim/pages/providers/service_providers/models/decorator.dart';
import 'package:swornim/pages/providers/service_providers/service_provider_factory.dart';
import 'package:swornim/pages/providers/service_providers/service_provider_manager.dart';

class DecoratorListPage extends ConsumerStatefulWidget {
  const DecoratorListPage({super.key});

  @override
  ConsumerState<DecoratorListPage> createState() => _DecoratorListPageState();
}

class _DecoratorListPageState extends ConsumerState<DecoratorListPage> {
  String _searchQuery = '';
  String _selectedSpecialization = 'All';
  String _selectedLocation = 'All';
  double _minRating = 0.0;
  bool _showFilters = false;
  
  final List<String> _specializations = [
    'All', 'wedding', 'birthday', 'corporate', 'themed', 'floral'
  ];
  
  final List<String> _locations = [
    'All', 'Kathmandu', 'Lalitpur', 'Bhaktapur', 'Pokhara', 'Chitwan'
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final decoratorsAsync = ref.watch(serviceProvidersProvider(ServiceProviderType.decorator));

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: _buildAppBar(theme),
      body: Column(
        children: [
          _buildSearchAndFilter(theme),
          if (_showFilters) _buildFilterPanel(theme),
          Expanded(
            child: decoratorsAsync.when(
              data: (providers) {
                final decorators = providers.whereType<Decorator>().toList();
                final filteredDecorators = _filterDecorators(decorators);
                
                if (filteredDecorators.isEmpty) {
                  return _buildEmptyState(theme);
                }
                
                return _buildDecoratorsList(filteredDecorators, theme);
              },
              loading: () => _buildLoadingState(),
              error: (error, stack) => _buildErrorState(error, theme),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return AppBar(
      title: Text(
        'Decorators',
        style: theme.textTheme.headlineMedium?.copyWith(
          color: const Color(0xFF1E293B),
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF475569)),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Icon(
            _showFilters ? Icons.filter_list_off : Icons.filter_list,
            color: const Color(0xFF475569),
          ),
          onPressed: () => setState(() => _showFilters = !_showFilters),
        ),
      ],
    );
  }

  Widget _buildSearchAndFilter(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Search decorators...',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF94A3B8)),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                hintStyle: GoogleFonts.inter(
                  color: const Color(0xFF94A3B8),
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildQuickFilter('Wedding', 'wedding'),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildQuickFilter('Birthday', 'birthday'),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildQuickFilter('Corporate', 'corporate'),
              ),
            ],
          ),
        ],
      ),
    );
  }

    Widget _buildQuickFilter(String label, String value) {
    final isSelected = _selectedSpecialization == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedSpecialization = value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2563EB) : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: isSelected ? Colors.white : const Color(0xFF64748B),
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterPanel(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filters',
            style: theme.textTheme.titleMedium?.copyWith(
              color: const Color(0xFF1E293B),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Specialization',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _specializations.map((spec) => _buildFilterChip(spec, true)).toList(),
          ),
          const SizedBox(height: 16),
          Text(
            'Location',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _locations.map((loc) => _buildFilterChip(loc, false)).toList(),
          ),
          const SizedBox(height: 16),
          Text(
            'Minimum Rating',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
          ),
          Slider(
            value: _minRating,
            min: 0,
            max: 5,
            divisions: 5,
            label: _minRating.toStringAsFixed(1),
            onChanged: (value) => setState(() => _minRating = value),
            activeColor: const Color(0xFF2563EB),
            inactiveColor: const Color(0xFFE2E8F0),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSpecialization) {
    final isSelected = isSpecialization ? _selectedSpecialization == label : _selectedLocation == label;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            if (isSpecialization) {
              _selectedSpecialization = label;
            } else {
              _selectedLocation = label;
            }
          });
        }
      },
      backgroundColor: const Color(0xFFF1F5F9),
      selectedColor: const Color(0xFFDBEAFE),
      labelStyle: GoogleFonts.inter(
        color: isSelected ? const Color(0xFF1E40AF) : const Color(0xFF64748B),
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? const Color(0xFF2563EB) : const Color(0xFFE2E8F0),
        ),
      ),
    );
  }

  List<Decorator> _filterDecorators(List<Decorator> decorators) {
    return decorators.where((decorator) {
      final matchesQuery = decorator.businessName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                           decorator.description.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesSpecialization = _selectedSpecialization == 'All' ||
                                   decorator.specializations.contains(_selectedSpecialization);
      // final matchesLocation = _selectedLocation == 'All' || decorator.location['city'] == _selectedLocation;
      final matchesRating = decorator.rating >= _minRating;
      
      return matchesQuery && matchesSpecialization && matchesRating; // && matchesLocation;
    }).toList();
  }

  Widget _buildDecoratorsList(List<Decorator> decorators, ThemeData theme) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: decorators.length,
      itemBuilder: (context, index) {
        final decorator = decorators[index];
        return _buildDecoratorCard(decorator, theme);
      },
    );
  }

  Widget _buildDecoratorCard(Decorator decorator, ThemeData theme) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      elevation: 0,
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => DecoratorDetailPage(decorator: decorator), // This will be created later
          //   ),
          // );
           ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Decorator detail page coming soon!')),
           );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    // backgroundImage: NetworkImage(decorator.profileImageUrl),
                    backgroundColor: Colors.grey.shade200,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          decorator.businessName,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Specializes in: ${decorator.specializations.join(', ')}",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                decorator.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF475569),
                ),
              ),
              const SizedBox(height: 16),
              const Divider(color: Color(0xFFE2E8F0)),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoChip(Icons.star, '${decorator.rating} (${decorator.totalReviews} reviews)', const Color(0xFFF59E0B)),
                  _buildInfoChip(Icons.location_on, 'Kathmandu', const Color(0xFF4F46E5)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: decorator.isAvailable ? const Color(0xFFECFDF5) : const Color(0xFFFEF2F2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      decorator.isAvailable ? 'Available' : 'Unavailable',
                      style: GoogleFonts.inter(
                        color: decorator.isAvailable ? const Color(0xFF059669) : const Color(0xFFDC2626),
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF475569),
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search_off, size: 80, color: Color(0xFFCBD5E1)),
          const SizedBox(height: 20),
          Text(
            'No Decorators Found',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: const Color(0xFF475569),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filters.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: const Color(0xFF64748B),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildErrorState(Object error, ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 80, color: Color(0xFFEF4444)),
          const SizedBox(height: 20),
          Text(
            'Something went wrong',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: const Color(0xFF475569),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'We couldn\'t load decorators at the moment.\nPlease try again later.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: const Color(0xFF64748B),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
