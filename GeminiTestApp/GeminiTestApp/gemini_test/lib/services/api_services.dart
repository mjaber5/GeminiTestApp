// services/api_service.dart
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../models/service.dart';
import '../models/order.dart';
import '../utils/constants.dart';

class ApiService {
  Future<List<Service>> searchServices(
      String query, LatLng currentLocation) async {
    final url =
        '$apiUrl/services/search?query=$query&lat=${currentLocation.latitude}&lng=${currentLocation.longitude}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => Service.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load services');
      }
    } catch (e) {
      print('Error fetching services: $e');
      throw Exception('Failed to load services');
    }
  }

  Future<Order> createOrder(Order order) async {
    final url = '$apiUrl/orders';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(order),
      );
      if (response.statusCode == 201) {
        return Order.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create order');
      }
    } catch (e) {
      print('Error creating order: $e');
      throw Exception('Failed to create order');
    }
  }

  Future<List<Order>> getDriverOrders(String driverId) async {
    final url = '$apiUrl/driver/orders/$driverId';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => Order.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      print('Error fetching orders: $e');
      throw Exception('Failed to load orders');
    }
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    final url = '$apiUrl/orders/$orderId';
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'status': status}),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update order status');
      }
    } catch (e) {
      print('Error updating order status: $e');
      throw Exception('Failed to update order status');
    }
  }

  Future<Service> addService(Service service) async {
    final url = '$apiUrl/services';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(service.toJson()),
      );
      if (response.statusCode == 201) {
        return Service.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to add service');
      }
    } catch (e) {
      print('Error adding service: $e');
      throw Exception('Failed to add service');
    }
  }

  Future<Service> updateService(Service service) async {
    final url = '$apiUrl/services/${service.id}';
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(service.toJson()),
      );
      if (response.statusCode == 200) {
        return Service.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to update service');
      }
    } catch (e) {
      print('Error updating service: $e');
      throw Exception('Failed to update service');
    }
  }

  Future<List<Service>> getProviderServices(String providerId) async {
    final url = '$apiUrl/services?providerId=$providerId';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => Service.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch services');
      }
    } catch (e) {
      print('Error fetching services: $e');
      throw Exception('Failed to fetch services');
    }
  }
}
