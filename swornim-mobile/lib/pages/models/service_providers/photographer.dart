import 'package:swornim/pages/models/service_providers/base_service_provider.dart';
import 'package:swornim/pages/models/review.dart';
import 'package:swornim/pages/models/location.dart';

class Photographer extends ServiceProvider {
  final double hourlyRate;
  final String experience;
  final List<String> specialties;
  final List<String> portfolioImages;

  const Photographer({
    required super.id,
    required super.name,
    required super.image,
    super.description = '',
    this.hourlyRate = 0.0,
    this.experience = '',
    this.specialties = const [],
    this.portfolioImages = const [],
    super.rating = 0.0,
    super.totalReviews = 0,
    super.isAvailable = true,
    super.reviews = const [],
    super.location,
    super.contactPhone = '',
    super.contactEmail = '',
  });

  factory Photographer.fromJson(Map<String, dynamic> json) {
    return Photographer(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      hourlyRate: (json['hourly_rate'] ?? 0).toDouble(),
      experience: json['experience'] ?? '',
      specialties: List<String>.from(json['specialties'] ?? []),
      portfolioImages: List<String>.from(json['portfolio_images'] ?? []),
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
      'hourly_rate': hourlyRate,
      'experience': experience,
      'specialties': specialties,
      'portfolio_images': portfolioImages,
    });
    return baseJson;
  }
}