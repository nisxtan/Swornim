import 'package:swornim/pages/providers/service_providers/models/base_service_provider.dart';
import 'package:swornim/pages/models/review.dart';
import 'package:swornim/pages/models/location.dart';

enum VenueType { wedding, conference, party, exhibition, other }

class Venue extends ServiceProvider {
  final String address;
  final int capacity;
  final double pricePerHour;
  final List<String> amenities;
  final List<String> images;
  final List<String> gallery;
  final List<String> services;
  final VenueType venueType;
  final String contactPhone;
  final String contactEmail;

  const Venue({
    required super.id,
    required super.userId,
    required super.businessName,
    required super.image,
    required super.description,
    required this.address,
    required this.capacity,
    required this.pricePerHour,
    required this.venueType,
    required this.contactPhone,
    required this.contactEmail,
    this.amenities = const [],
    this.images = const [],
    this.gallery = const [],
    this.services = const [],
    super.rating = 0.0,
    super.totalReviews = 0,
    super.isAvailable = true,
    super.reviews = const [],
    super.location,
    required super.createdAt,
    required super.updatedAt, 
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      businessName: json['business_name'] ?? '',
      description: json['description'] ?? '',
      address: json['address'] ?? '',
      image: json['image'] ?? '',
      capacity: json['capacity'] ?? 0,
      pricePerHour: (json['price_per_hour'] ?? 0).toDouble(),
      amenities: List<String>.from(json['amenities'] ?? []),
      images: List<String>.from(json['images'] ?? []),
      gallery: List<String>.from(json['gallery'] ?? []),
      services: List<String>.from(json['services'] ?? []),
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
      venueType: VenueType.values.byName(json['venue_type'] ?? 'other'),
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()), 
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final baseJson = toBaseJson();
    baseJson.addAll({
      'address': address,
      'capacity': capacity,
      'price_per_hour': pricePerHour,
      'amenities': amenities,
      'images': images,
      'gallery': gallery,
      'services': services,
      'venue_type': venueType.name,
      'contact_phone': contactPhone,
      'contact_email': contactEmail,
    });
    return baseJson;
  }
  
  @override
  Venue copyWith({
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
    String? address,
    int? capacity,
    double? pricePerHour,
    List<String>? amenities,
    List<String>? images,
    List<String>? gallery,
    List<String>? services,
    VenueType? venueType,
    String? contactPhone,
    String? contactEmail,
  }) {
    return Venue(
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
      address: address ?? this.address,
      capacity: capacity ?? this.capacity,
      pricePerHour: pricePerHour ?? this.pricePerHour,
      amenities: amenities ?? this.amenities,
      images: images ?? this.images,
      gallery: gallery ?? this.gallery,
      services: services ?? this.services,
      venueType: venueType ?? this.venueType,
      contactPhone: contactPhone ?? this.contactPhone,
      contactEmail: contactEmail ?? this.contactEmail, 
    );
  }
}