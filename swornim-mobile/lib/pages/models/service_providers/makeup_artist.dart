import 'package:swornim/pages/models/service_providers/base_service_provider.dart';
import 'package:swornim/pages/models/review.dart';
import 'package:swornim/pages/models/location.dart';

class MakeupArtist extends ServiceProvider {
  final String price;
  final int totalClients;
  final String responseTime;
  final List<String> specialties;
  final List<String> portfolio;
  final List<Map<String, dynamic>> services;

  const MakeupArtist({
    required super.id,
    required super.name,
    required super.image,
    required super.description,
    required this.price,
    super.rating = 0.0,
    this.totalClients = 0,
    this.responseTime = '1hr',
    this.specialties = const [],
    this.portfolio = const [],
    this.services = const [],
    super.reviews = const [],
    super.isAvailable = true,
    super.location,
    super.contactPhone = '',
    super.contactEmail = '',
  });

  factory MakeupArtist.fromJson(Map<String, dynamic> json) {
    return MakeupArtist(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      totalClients: json['total_clients'] ?? 0,
      responseTime: json['response_time'] ?? '1hr',
      specialties: List<String>.from(json['specialties'] ?? []),
      portfolio: List<String>.from(json['portfolio'] ?? []),
      services: List<Map<String, dynamic>>.from(json['services'] ?? []),
      reviews: (json['reviews'] as List?)
          ?.map((r) => Review.fromJson(r as Map<String, dynamic>))
          .toList() ?? [],
      isAvailable: json['is_available'] ?? true,
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
      'price': price,
      'total_clients': totalClients,
      'response_time': responseTime,
      'specialties': specialties,
      'portfolio': portfolio,
      'services': services,
    });
    return baseJson;
  }
}