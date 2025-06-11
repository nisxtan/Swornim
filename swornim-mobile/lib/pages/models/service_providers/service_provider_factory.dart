// File: lib/pages/models/service_providers/service_provider_factory.dart
import 'package:swornim/pages/models/service_providers/decorator.dart';
import 'package:swornim/pages/models/service_providers/service_providers.dart';

enum ServiceProviderType {
  makeupArtist,
  photographer,
  venue,
  caterer,
  decorator,
}

class ServiceProviderFactory {
  static ServiceProvider? fromJson(
    Map<String, dynamic> json, 
    ServiceProviderType type
  ) {
    try {
      switch (type) {
        case ServiceProviderType.makeupArtist:
          return MakeupArtist.fromJson(json);
        case ServiceProviderType.photographer:
          return Photographer.fromJson(json);
        case ServiceProviderType.venue:
          return Venue.fromJson(json);
        case ServiceProviderType.caterer:
          return Caterer.fromJson(json);
        case ServiceProviderType.decorator:
          return Decorator.fromJson(json);
      }
    } catch (e) {
      print('Error creating service provider: $e');
      return null;
    }
  }

  static ServiceProviderType? getTypeFromString(String typeString) {
    switch (typeString.toLowerCase()) {
      case 'makeup_artist':
      case 'makeupartist':
        return ServiceProviderType.makeupArtist;
      case 'photographer':
        return ServiceProviderType.photographer;
      case 'venue':
        return ServiceProviderType.venue;
      case 'caterer':
        return ServiceProviderType.caterer;
      case 'decorator':
        return ServiceProviderType.decorator;
      default:
        return null;
    }
  }

  static String getTypeString(ServiceProviderType type) {
    switch (type) {
      case ServiceProviderType.makeupArtist:
        return 'makeup_artist';
      case ServiceProviderType.photographer:
        return 'photographer';
      case ServiceProviderType.venue:
        return 'venue';
      case ServiceProviderType.caterer:
        return 'caterer';
      case ServiceProviderType.decorator:
        return 'decorator';
    }
  }
}

