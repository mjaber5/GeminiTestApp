import 'package:flutter/material.dart';
import 'package:gemini_test/global_storage.dart';

class DriverHomeScreen extends StatefulWidget {
  @override
  _DriverHomeScreenState createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  Map<String, dynamic> serviceData = {};

  @override
  void initState() {
    super.initState();
    serviceData = globalServiceData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Driver Home')),
      body: Card(
        child: ListTile(
          title: Text(serviceData['serviceName'] ?? 'No service name'),
          subtitle: Text(
              'Description: ${serviceData['description']} - Price: ${serviceData['price']}'),
          trailing: Text(
              'Location: (${serviceData['latitude']}, ${serviceData['longitude']})'),
        ),
      ),
    );
  }
}
