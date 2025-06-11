import 'package:swornim/pages/models/service_providers/base_service_provider.dart';
import 'package:swornim/pages/models/review.dart';
import 'package:swornim/pages/models/location.dart';

class Caterer extends ServiceProvider {
  final double pricePerPerson;
  final List<String> cuisineTypes;
  final List<String> menuItems;
  final int minGuests;
  final int maxGuests;
  final bool providesEquipment;
  final bool providesService; // Waiters, bartenders
  final List<String> dietaryOptions; // Vegan, vegetarian, gluten-free, etc.
  final bool canCustomizeMenu;

  const Caterer({
    required super.id,
    required super.name,
    required super.image,
    required super.description,
    required this.pricePerPerson,
    this.cuisineTypes = const [],
    this.menuItems = const [],
    this.minGuests = 1,
    this.maxGuests = 1000,
    this.providesEquipment = false,
    this.providesService = false,
    this.dietaryOptions = const [],
    this.canCustomizeMenu = true,
    super.rating = 0.0,
    super.totalReviews = 0,
    super.isAvailable = true,
    super.reviews = const [],
    super.location,
    super.contactPhone = '',
    super.contactEmail = '',
  });

  factory Caterer.fromJson(Map<String, dynamic> json) {
    return Caterer(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      pricePerPerson: (json['price_per_person'] ?? 0).toDouble(),
      cuisineTypes: List<String>.from(json['cuisine_types'] ?? []),
      menuItems: List<String>.from(json['menu_items'] ?? []),
      minGuests: json['min_guests'] ?? 1,
      maxGuests: json['max_guests'] ?? 1000,
      providesEquipment: json['provides_equipment'] ?? false,
      providesService: json['provides_service'] ?? false,
      dietaryOptions: List<String>.from(json['dietary_options'] ?? []),
      canCustomizeMenu: json['can_customize_menu'] ?? true,
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
      'price_per_person': pricePerPerson,
      'cuisine_types': cuisineTypes,
      'menu_items': menuItems,
      'min_guests': minGuests,
      'max_guests': maxGuests,
      'provides_equipment': providesEquipment,
      'provides_service': providesService,
      'dietary_options': dietaryOptions,
      'can_customize_menu': canCustomizeMenu,
    });
    return baseJson;
  }
}