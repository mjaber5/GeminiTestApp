import 'package:flutter/material.dart';
import 'package:gemini_test/global_storage.dart';
import 'package:gemini_test/screens/driver/driver_home_screen.dart';

class ProviderHomeScreen extends StatefulWidget {
  final String serviceName;
  final double latitude;
  final double longitude;

  ProviderHomeScreen({
    required this.serviceName,
    required this.latitude,
    required this.longitude,
  });

  @override
  _ProviderHomeScreenState createState() => _ProviderHomeScreenState();
}

class _ProviderHomeScreenState extends State<ProviderHomeScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void _sendServiceToDriver() {
    globalServiceData = {
      'serviceName': widget.serviceName,
      'latitude': widget.latitude,
      'longitude': widget.longitude,
      'description': _descriptionController.text,
      'price': _priceController.text,
    };
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DriverHomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Provider Home')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Service Name: ${widget.serviceName}'),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _sendServiceToDriver,
                child: const Text('Send to Driver'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
