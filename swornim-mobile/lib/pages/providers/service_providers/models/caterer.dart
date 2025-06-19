import 'package:swornim/pages/providers/service_providers/models/base_service_provider.dart';
import 'package:swornim/pages/models/review.dart';
import 'package:swornim/pages/models/location.dart';

class Caterer extends ServiceProvider {
  final List<String> cuisineTypes; // ['nepali', 'indian', 'chinese', 'continental']
  final List<String> serviceTypes; // ['buffet', 'plated', 'family_style']
  final double pricePerPerson;
  final int minGuests;
  final int maxGuests;
  final List<String> menuItems;
  final List<String> dietaryOptions; // ['vegetarian', 'vegan', 'halal', 'jain']
  final bool offersEquipment; // Tables, chairs, serving equipment
  final bool offersWaiters;
  final List<String> availableDates;
  final int experienceYears;

  const Caterer({
    required super.id,
    required super.userId,
    required super.businessName,
    required super.image,
    required super.description,
    super.rating,
    super.totalReviews,
    super.isAvailable,
    super.reviews,
    super.location,
    required super.createdAt,
    required super.updatedAt,
    this.cuisineTypes = const [],
    this.serviceTypes = const [],
    required this.pricePerPerson,
    this.minGuests = 10,
    this.maxGuests = 500,
    this.menuItems = const [],
    this.dietaryOptions = const [],
    this.offersEquipment = false,
    this.offersWaiters = false,
    this.availableDates = const [],
    this.experienceYears = 0,
  });

  @override
  Map<String, dynamic> toJson() {
    final baseJson = toBaseJson();
    baseJson.addAll({
      'type': 'caterer',
      'cuisine_types': cuisineTypes,
      'service_types': serviceTypes,
      'price_per_person': pricePerPerson,
      'min_guests': minGuests,
      'max_guests': maxGuests,
      'menu_items': menuItems,
      'dietary_options': dietaryOptions,
      'offers_equipment': offersEquipment,
      'offers_waiters': offersWaiters,
      'available_dates': availableDates,
      'experience_years': experienceYears,
    });
    return baseJson;
  }

  factory Caterer.fromJson(Map<String, dynamic> json) {
    return Caterer(
      id: json['id'],
      userId: json['user_id'],
      businessName: json['business_name'],
      image: json['image'],
      description: json['description'],
      rating: (json['rating'] ?? 0.0).toDouble(),
      totalReviews: json['total_reviews'] ?? 0,
      isAvailable: json['is_available'] ?? true,
      reviews: (json['reviews'] as List<dynamic>?)?.map((r) => Review.fromJson(r)).toList() ?? [],
      location: json['location'] != null ? Location.fromJson(json['location']) : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      cuisineTypes: List<String>.from(json['cuisine_types'] ?? []),
      serviceTypes: List<String>.from(json['service_types'] ?? []),
      pricePerPerson: (json['price_per_person'] ?? 0.0).toDouble(),
      minGuests: json['min_guests'] ?? 10,
      maxGuests: json['max_guests'] ?? 500,
      menuItems: List<String>.from(json['menu_items'] ?? []),
      dietaryOptions: List<String>.from(json['dietary_options'] ?? []),
      offersEquipment: json['offers_equipment'] ?? false,
      offersWaiters: json['offers_waiters'] ?? false,
      availableDates: List<String>.from(json['available_dates'] ?? []),
      experienceYears: json['experience_years'] ?? 0,
    );
  }

  @override
  Caterer copyWith({
    String? id,
    String? userId,
    String? businessName,
    String? image,
    String? description,
    double? rating,
    int? totalReviews,
    bool? isAvailable,
    List<Review>? reviews,
    Location? location,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? cuisineTypes,
    List<String>? serviceTypes,
    double? pricePerPerson,
    int? minGuests,
    int? maxGuests,
    List<String>? menuItems,
    List<String>? dietaryOptions,
    bool? offersEquipment,
    bool? offersWaiters,
    List<String>? availableDates,
    int? experienceYears,
  }) {
    return Caterer(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      businessName: businessName ?? this.businessName,
      image: image ?? this.image,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      totalReviews: totalReviews ?? this.totalReviews,
      isAvailable: isAvailable ?? this.isAvailable,
      reviews: reviews ?? this.reviews,
      location: location ?? this.location,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      cuisineTypes: cuisineTypes ?? this.cuisineTypes,
      serviceTypes: serviceTypes ?? this.serviceTypes,
      pricePerPerson: pricePerPerson ?? this.pricePerPerson,
      minGuests: minGuests ?? this.minGuests,
      maxGuests: maxGuests ?? this.maxGuests,
      menuItems: menuItems ?? this.menuItems,
      dietaryOptions: dietaryOptions ?? this.dietaryOptions,
      offersEquipment: offersEquipment ?? this.offersEquipment,
      offersWaiters: offersWaiters ?? this.offersWaiters,
      availableDates: availableDates ?? this.availableDates,
      experienceYears: experienceYears ?? this.experienceYears,
    );
  }
}