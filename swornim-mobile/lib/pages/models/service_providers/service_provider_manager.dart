// File: lib/pages/models/service_providers/service_provider_manager.dart
import 'package:swornim/pages/models/service_providers/decorator.dart';
import 'package:swornim/pages/models/service_providers/service_providers.dart';
import 'package:swornim/pages/models/service_providers/service_provider_factory.dart';

class ServiceProviderManager {
  static List<ServiceProvider> _allProviders = [];
  
  // Add providers
  static void addProvider(ServiceProvider provider) {
    _allProviders.add(provider);
  }
  
  static void addProviders(List<ServiceProvider> providers) {
    _allProviders.addAll(providers);
  }
  
  // Get all providers
  static List<ServiceProvider> getAllProviders() {
    return List.from(_allProviders);
  }
  
  // Get providers by type
  static List<T> getProvidersByType<T extends ServiceProvider>() {
    return _allProviders.whereType<T>().toList();
  }
  
  static List<MakeupArtist> getMakeupArtists() {
    return getProvidersByType<MakeupArtist>();
  }
  
  static List<Photographer> getPhotographers() {
    return getProvidersByType<Photographer>();
  }
  
  static List<Venue> getVenues() {
    return getProvidersByType<Venue>();
  }
  
  static List<Caterer> getCaterers() {
    return getProvidersByType<Caterer>();
  }
  
  static List<Decorator> getDecorators() {
    return getProvidersByType<Decorator>();
  }
  
  // Search and filter methods
  static List<ServiceProvider> searchByName(String query) {
    return _allProviders
        .where((provider) => 
            provider.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
  
  static List<ServiceProvider> getAvailableProviders() {
    return _allProviders.where((provider) => provider.isAvailable).toList();
  }
  
  static List<ServiceProvider> getProvidersByRating(double minRating) {
    return _allProviders
        .where((provider) => provider.rating >= minRating)
        .toList();
  }
  
  static List<ServiceProvider> getProvidersByLocation(String city) {
    return _allProviders
        .where((provider) => 
            provider.location?.city.toLowerCase() == city.toLowerCase())
        .toList();
  }
  
  // Advanced filters for specific types
  static List<Venue> getVenuesByCapacity(int minCapacity, int maxCapacity) {
    return getVenues()
        .where((venue) => 
            venue.capacity >= minCapacity && venue.capacity <= maxCapacity)
        .toList();
  }
  
  static List<Caterer> getCaterersByPriceRange(double minPrice, double maxPrice) {
    return getCaterers()
        .where((caterer) => 
            caterer.pricePerPerson >= minPrice && 
            caterer.pricePerPerson <= maxPrice)
        .toList();
  }
  
  static List<Decorator> getDecoratorsByEventType(DecorationType eventType) {
    return getDecorators()
        .where((decorator) => decorator.specializations.contains(eventType))
        .toList();
  }
  
  static List<Decorator> getDecoratorsByBudget(double budget) {
    return getDecorators()
        .where((decorator) => decorator.fitsWithinBudget(budget))
        .toList();
  }
  
  // Get provider by ID
  static ServiceProvider? getProviderById(String id) {
    try {
      return _allProviders.firstWhere((provider) => provider.id == id);
    } catch (e) {
      return null;
    }
  }
  
  // Remove provider
  static bool removeProvider(String id) {
    final index = _allProviders.indexWhere((provider) => provider.id == id);
    if (index != -1) {
      _allProviders.removeAt(index);
      return true;
    }
    return false;
  }
  
  // Update provider
  static bool updateProvider(ServiceProvider updatedProvider) {
    final index = _allProviders.indexWhere(
        (provider) => provider.id == updatedProvider.id);
    if (index != -1) {
      _allProviders[index] = updatedProvider;
      return true;
    }
    return false;
  }
  
  // Clear all providers
  static void clearAllProviders() {
    _allProviders.clear();
  }
  
  // Load from JSON list
  static void loadProvidersFromJson(List<Map<String, dynamic>> jsonList) {
    _allProviders.clear();
    for (var json in jsonList) {
      final typeString = json['type'] ?? '';
      final type = ServiceProviderFactory.getTypeFromString(typeString);
      if (type != null) {
        final provider = ServiceProviderFactory.fromJson(json, type);
        if (provider != null) {
          _allProviders.add(provider);
        }
      }
    }
  }
  
  // Convert all to JSON
  static List<Map<String, dynamic>> allProvidersToJson() {
    return _allProviders.map((provider) {
      final json = provider.toJson();
      // Add type information
      if (provider is MakeupArtist) {
        json['type'] = 'makeup_artist';
      } else if (provider is Photographer) {
        json['type'] = 'photographer';
      } else if (provider is Venue) {
        json['type'] = 'venue';
      } else if (provider is Caterer) {
        json['type'] = 'caterer';
      } else if (provider is Decorator) {
        json['type'] = 'decorator';
      }
      return json;
    }).toList();
  }
  
  // Statistics
  static Map<String, int> getProviderTypeStats() {
    return {
      'makeup_artists': getMakeupArtists().length,
      'photographers': getPhotographers().length,
      'venues': getVenues().length,
      'caterers': getCaterers().length,
      'decorators': getDecorators().length,
      'total': _allProviders.length,
    };
  }
}