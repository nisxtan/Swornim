import 'package:swornim/pages/models/service_providers/base_service_provider.dart';
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

  const Venue({
    required super.id,
    required super.name,
    required super.image,
    required super.description,
    required this.address,
    required this.capacity,
    required this.pricePerHour,
    required this.venueType,
    this.amenities = const [],
    this.images = const [],
    this.gallery = const [],
    this.services = const [],
    super.rating = 0.0,
    super.totalReviews = 0,
    super.isAvailable = true,
    super.reviews = const [],
    super.location,
    required super.contactPhone,
    required super.contactEmail,
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
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
    });
    return baseJson;
  }
}