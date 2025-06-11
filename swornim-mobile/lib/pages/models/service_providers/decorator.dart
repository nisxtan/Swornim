import 'package:swornim/pages/models/service_providers/base_service_provider.dart';
import 'package:swornim/pages/models/review.dart';
import 'package:swornim/pages/models/location.dart';

enum DecorationType { 
  wedding, 
  birthday, 
  corporate, 
  baby_shower, 
  anniversary, 
  graduation,
  holiday,
  theme_party,
  other 
}

enum DecoratorServiceType {
  full_service, // Complete decoration service
  consultation_only, // Design consultation only
  rental_only, // Equipment/decoration rental
  setup_only, // Setup service for client's decorations
}

class Decorator extends ServiceProvider {
  final double basePrice;
  final DecoratorServiceType serviceType;
  final List<DecorationType> specializations;
  final List<String> decorationStyles; // Modern, vintage, rustic, elegant, etc.
  final List<String> portfolioImages;
  final List<String> availableItems; // Available decoration items
  final bool providesFlowers;
  final bool providesLighting;
  final bool providesFurniture;
  final bool providesLinens;
  final bool providesBackdrops;
  final int minBudget;
  final int maxBudget;
  final String setupTime; // Time required for setup
  final String cleanupIncluded; // Whether cleanup is included
  final List<String> recentProjects;

  const Decorator({
    required super.id,
    required super.name,
    required super.image,
    required super.description,
    required this.basePrice,
    this.serviceType = DecoratorServiceType.full_service,
    this.specializations = const [],
    this.decorationStyles = const [],
    this.portfolioImages = const [],
    this.availableItems = const [],
    this.providesFlowers = false,
    this.providesLighting = false,
    this.providesFurniture = false,
    this.providesLinens = false,
    this.providesBackdrops = false,
    this.minBudget = 0,
    this.maxBudget = 100000,
    this.setupTime = '4-6 hours',
    this.cleanupIncluded = 'Yes',
    this.recentProjects = const [],
    super.rating = 0.0,
    super.totalReviews = 0,
    super.isAvailable = true,
    super.reviews = const [],
    super.location,
    super.contactPhone = '',
    super.contactEmail = '',
  });

  factory Decorator.fromJson(Map<String, dynamic> json) {
    return Decorator(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      basePrice: (json['base_price'] ?? 0).toDouble(),
      serviceType: DecoratorServiceType.values.byName(
        json['service_type'] ?? 'full_service'
      ),
      specializations: (json['specializations'] as List?)
          ?.map((s) => DecorationType.values.byName(s))
          .toList() ?? [],
      decorationStyles: List<String>.from(json['decoration_styles'] ?? []),
      portfolioImages: List<String>.from(json['portfolio_images'] ?? []),
      availableItems: List<String>.from(json['available_items'] ?? []),
      providesFlowers: json['provides_flowers'] ?? false,
      providesLighting: json['provides_lighting'] ?? false,
      providesFurniture: json['provides_furniture'] ?? false,
      providesLinens: json['provides_linens'] ?? false,
      providesBackdrops: json['provides_backdrops'] ?? false,
      minBudget: json['min_budget'] ?? 0,
      maxBudget: json['max_budget'] ?? 100000,
      setupTime: json['setup_time'] ?? '4-6 hours',
      cleanupIncluded: json['cleanup_included'] ?? 'Yes',
      recentProjects: List<String>.from(json['recent_projects'] ?? []),
      rating: (json['rating'] ?? 0).toDouble(),
      totalReviews: json['total_reviews'] ?? 0,
      isAvailable: json['is_available'] ?? true,
      reviews: (json['reviews'] as List?)
          ?.map((r) => Review.fromJson(r as Map<String, dynamic>))
          .toList() ?? [],
      location: json['location'] != null
          ? Location.fromJson(json['location'])
          : null,
      contactPhone: json['contact_phone'] ?? '',
      contactEmail: json['contact_email'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final baseJson = toBaseJson();
    baseJson.addAll({
      'base_price': basePrice,
      'service_type': serviceType.name,
      'specializations': specializations.map((s) => s.name).toList(),
      'decoration_styles': decorationStyles,
      'portfolio_images': portfolioImages,
      'available_items': availableItems,
      'provides_flowers': providesFlowers,
      'provides_lighting': providesLighting,
      'provides_furniture': providesFurniture,
      'provides_linens': providesLinens,
      'provides_backdrops': providesBackdrops,
      'min_budget': minBudget,
      'max_budget': maxBudget,
      'setup_time': setupTime,
      'cleanup_included': cleanupIncluded,
      'recent_projects': recentProjects,
    });
    return baseJson;
  }

  // Helper methods
  bool canHandleEventType(DecorationType eventType) {
    return specializations.contains(eventType);
  }

  bool fitsWithinBudget(double budget) {
    return budget >= minBudget && budget <= maxBudget;
  }

  List<String> getProvidedServices() {
    List<String> services = [];
    if (providesFlowers) services.add('Flowers');
    if (providesLighting) services.add('Lighting');
    if (providesFurniture) services.add('Furniture');
    if (providesLinens) services.add('Linens');
    if (providesBackdrops) services.add('Backdrops');
    return services;
  }
}