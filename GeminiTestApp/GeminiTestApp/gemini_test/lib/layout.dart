import 'package:flutter/material.dart';
import 'package:gemini_test/screens/client/client_home_screen.dart';
import 'package:gemini_test/screens/driver/driver_home_screen.dart';
import 'package:gemini_test/screens/service_provider/provider_home_screen.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:ionicons/ionicons.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int currentIndex = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildNavigationBar(),
      body: _buildLayoutPageView(),
    );
  }

  NavigationBar _buildNavigationBar() {
    return NavigationBar(
      height: 70,
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 0,
      onDestinationSelected: (value) {
        setState(() {
          currentIndex = value;
          pageController.jumpToPage(value);
        });
      },
      selectedIndex: currentIndex,
      indicatorColor: Colors.transparent,
      destinations: const [
        NavigationDestination(
          icon: Icon(Ionicons.search),
          label: '',
          selectedIcon: Icon(
            Ionicons.search,
            color: Colors.blueAccent,
          ),
        ),
        NavigationDestination(
          icon: Icon(
            Ionicons.location,
            size: 30,
          ),
          label: '',
          selectedIcon: Icon(
            Ionicons.location,
            size: 30,
            color: Colors.blueAccent,
          ),
        ),
        NavigationDestination(
          icon: Icon(Iconsax.home),
          label: '',
          selectedIcon: Icon(
            Iconsax.home,
            color: Colors.blueAccent,
          ),
        ),
      ],
    );
  }

  PageView _buildLayoutPageView() {
    return PageView(
      controller: pageController,
      children: <Widget>[
        ClientHomeScreen(),
        ProviderHomeScreen(
            serviceName: '', latitude: 285.65, longitude: -135.7985),
        DriverHomeScreen(),
      ],
      onPageChanged: (value) {
        setState(() {
          currentIndex = value;
        });
      },
    );
  }
}
