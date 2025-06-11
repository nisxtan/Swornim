class Booking {
  final String id;
  final String clientId;
  final String serviceProviderId;
  final ServiceType serviceType;
  final DateTime eventDate;
  final String eventTime;
  final String eventLocation;
  final String eventType;
  final double totalAmount;
  final BookingStatus status;
  final String? specialRequests;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PaymentStatus paymentStatus;

  const Booking({
    required this.id,
    required this.clientId,
    required this.serviceProviderId,
    required this.serviceType,
    required this.eventDate,
    required this.eventTime,
    required this.eventLocation,
    required this.eventType,
    required this.totalAmount,
    required this.status,
    this.specialRequests,
    required this.createdAt,
    required this.updatedAt,
    this.paymentStatus = PaymentStatus.pending,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    try {
      return Booking(
        id: json['id']?.toString() ?? '',
        clientId: json['client_id']?.toString() ?? '',
        serviceProviderId: json['service_provider_id']?.toString() ?? '',
        serviceType: _parseServiceType(json['service_type']),
        eventDate: _parseDateTime(json['event_date']),
        eventTime: json['event_time']?.toString() ?? '',
        eventLocation: json['event_location']?.toString() ?? '',
        eventType: json['event_type']?.toString() ?? '',
        totalAmount: _parseDouble(json['total_amount']),
        status: _parseBookingStatus(json['status']),
        specialRequests: json['special_requests']?.toString(),
        createdAt: _parseDateTime(json['created_at']),
        updatedAt: _parseDateTime(json['updated_at']),
        paymentStatus: _parsePaymentStatus(json['payment_status']),
      );
    } catch (e) {
      throw FormatException('Failed to parse Booking from JSON: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client_id': clientId,
      'service_provider_id': serviceProviderId,
      'service_type': serviceType.name,
      'event_date': eventDate.toIso8601String(),
      'event_time': eventTime,
      'event_location': eventLocation,
      'event_type': eventType,
      'total_amount': totalAmount,
      'status': status.name,
      'special_requests': specialRequests,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'payment_status': paymentStatus.name,
    };
  }

  // Helper methods for safe parsing
  static ServiceType _parseServiceType(dynamic value) {
    if (value == null) return ServiceType.photography; // Default fallback
    try {
      return ServiceType.values.byName(value.toString().toLowerCase());
    } catch (e) {
      return ServiceType.photography; // Default fallback
    }
  }

  static BookingStatus _parseBookingStatus(dynamic value) {
    if (value == null) return BookingStatus.pending; // Default fallback
    try {
      return BookingStatus.values.byName(value.toString().toLowerCase());
    } catch (e) {
      return BookingStatus.pending; // Default fallback
    }
  }

  static PaymentStatus _parsePaymentStatus(dynamic value) {
    if (value == null) return PaymentStatus.pending; // Default fallback
    try {
      return PaymentStatus.values.byName(value.toString().toLowerCase());
    } catch (e) {
      return PaymentStatus.pending; // Default fallback
    }
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value == null) return DateTime.now();
    try {
      if (value is String) {
        return DateTime.parse(value);
      } else if (value is int) {
        // Handle Unix timestamp (milliseconds)
        return DateTime.fromMillisecondsSinceEpoch(value);
      }
      return DateTime.now();
    } catch (e) {
      return DateTime.now();
    }
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    try {
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.parse(value);
      return 0.0;
    } catch (e) {
      return 0.0;
    }
  }

  // Utility methods
  Booking copyWith({
    String? id,
    String? clientId,
    String? serviceProviderId,
    ServiceType? serviceType,
    DateTime? eventDate,
    String? eventTime,
    String? eventLocation,
    String? eventType,
    double? totalAmount,
    BookingStatus? status,
    String? specialRequests,
    DateTime? createdAt,
    DateTime? updatedAt,
    PaymentStatus? paymentStatus,
  }) {
    return Booking(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      serviceProviderId: serviceProviderId ?? this.serviceProviderId,
      serviceType: serviceType ?? this.serviceType,
      eventDate: eventDate ?? this.eventDate,
      eventTime: eventTime ?? this.eventTime,
      eventLocation: eventLocation ?? this.eventLocation,
      eventType: eventType ?? this.eventType,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      specialRequests: specialRequests ?? this.specialRequests,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      paymentStatus: paymentStatus ?? this.paymentStatus,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Booking &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Booking{id: $id, clientId: $clientId, serviceType: $serviceType, eventDate: $eventDate, status: $status}';
  }

  // Business logic methods
  bool get isActive => status == BookingStatus.confirmed || status == BookingStatus.inProgress;
  bool get isPending => status == BookingStatus.pending;
  bool get isCompleted => status == BookingStatus.completed;
  bool get isCancelled => status == BookingStatus.cancelled;
  bool get isPaid => paymentStatus == PaymentStatus.paid;
  bool get isUpcoming => eventDate.isAfter(DateTime.now()) && !isCancelled;
  bool get isPast => eventDate.isBefore(DateTime.now());
  
  String get formattedAmount => '\$${totalAmount.toStringAsFixed(2)}';
  String get formattedEventDate => '${eventDate.day}/${eventDate.month}/${eventDate.year}';
}

enum ServiceType { 
  photography, 
  makeup, 
  decoration, 
  venue,
  catering,     // You might want to add more service types
  music,
  planning,
}

enum BookingStatus { 
  pending, 
  confirmed, 
  completed, 
  cancelled, 
  inProgress,
  rejected,     // Good to have for declined requests
}

enum PaymentStatus { 
  pending, 
  paid, 
  refunded, 
  failed,
  partiallyPaid, // Useful for deposit scenarios
}