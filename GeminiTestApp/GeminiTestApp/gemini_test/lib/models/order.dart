class Order {
  final String id;
  final String serviceName;
  final String pickupLocation;
  final String dropoffLocation;
  final String status;

  Order({
    required this.id,
    required this.serviceName,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      serviceName: json['serviceName'],
      pickupLocation: json['pickupLocation'],
      dropoffLocation: json['dropoffLocation'],
      status: json['status'],
    );
  }
}
