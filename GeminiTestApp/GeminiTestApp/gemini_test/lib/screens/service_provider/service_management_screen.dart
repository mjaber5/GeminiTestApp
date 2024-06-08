// screens/service_provider/service_management_screen.dart
import 'package:flutter/material.dart';
import 'package:gemini_test/services/api_services.dart';
import 'package:provider/provider.dart';
import '../../models/service.dart';

class ServiceManagementScreen extends StatefulWidget {
  @override
  _ServiceManagementScreenState createState() =>
      _ServiceManagementScreenState();
}

class _ServiceManagementScreenState extends State<ServiceManagementScreen> {
  List<Service> services = [];

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  void _loadServices() async {
    try {
      final apiService = Provider.of<ApiService>(context, listen: false);
      var fetchedServices = await apiService.getProviderServices('providerId');
      setState(() {
        services = fetchedServices;
      });
    } catch (e) {
      print('Failed to load services: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage My Services'),
      ),
      body: ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(services[index].name),
            subtitle: Text('Price: ${services[index].price}'),
            onTap: () => null,
          );
        },
      ),
    );
  }
}
