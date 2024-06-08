// screens/driver/order_details_screen.dart
import 'package:flutter/material.dart';
import 'package:gemini_test/services/api_services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../models/order.dart';

class OrderDetailsScreen extends StatefulWidget {
  final Order order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  GoogleMapController? mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _updateOrderStatus(String status) async {
    final apiService = Provider.of<ApiService>(context, listen: false);
    try {
      await apiService.updateOrderStatus(widget.order.id, status);
      Navigator.pop(context);
    } catch (e) {
      print('Error updating order status: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update order status: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Service: ${widget.order.serviceName}'),
            Text('Pickup Location: ${widget.order.pickupLocation}'),
            Text('Drop-off Location: ${widget.order.dropoffLocation}'),
            Expanded(
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(37.7749, -122.4194), // Dummy location
                  zoom: 11.0,
                ),
                markers: {
                  const Marker(
                    markerId: MarkerId('pickup'),
                    position: LatLng(37.7749, -122.4194), // Dummy location
                    infoWindow: InfoWindow(title: 'Pickup Location'),
                  ),
                  const Marker(
                    markerId: MarkerId('dropoff'),
                    position: LatLng(37.7749, -122.4194), // Dummy location
                    infoWindow: InfoWindow(title: 'Drop-off Location'),
                  ),
                },
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => _updateOrderStatus('In Progress'),
                  child: const Text('Start Delivery'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _updateOrderStatus('Completed'),
                  child: const Text('Complete Delivery'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
