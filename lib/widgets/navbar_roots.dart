import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_health_app/screen/home_screen.dart';
import 'package:medical_health_app/screen/messages_screen.dart';
import 'package:medical_health_app/screen/schedule_screen.dart'; // You'll need to create this
import 'package:medical_health_app/screen/settings_screen.dart';

class NavbarRoots extends StatefulWidget {
  const NavbarRoots({super.key});

  @override
  State<NavbarRoots> createState() => _NavbarRootsState();
}

class _NavbarRootsState extends State<NavbarRoots> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _animationController;

  // Create screens
  late final List<Widget> _pages = [
    HomeScreen(),
    MessagesScreen(),
    ScheduleScreen(), // You'll need to create this screen
    SettingsScreen(),
  ];

  // Page titles
  final List<String> _titles = ["Home", "Messages", "Schedule", "Settings"];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _animationController.forward(from: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0.05, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
              child: child,
            ),
          );
        },
        child: _pages[_selectedIndex],
      ),

      // Custom Bottom Navigation Bar
      bottomNavigationBar: Container(
        height: 85,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: Offset(0, -5)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(4, (index) {
            return _buildNavItem(
              index: index,
              icon: _getIconForIndex(index),
              label: _titles[index],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildNavItem({required int index, required IconData icon, required String label}) {
    final isSelected = _selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => _onItemTapped(index),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon with animation
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                padding: EdgeInsets.all(isSelected ? 8 : 0),
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xFF7165D6).withOpacity(0.1) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: isSelected ? Color(0xFF7165D6) : Colors.grey.shade400,
                  size: isSelected ? 28 : 24,
                ),
              ),

              SizedBox(height: 4),

              // Label with animation
              AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: isSelected ? 12 : 11,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? Color(0xFF7165D6) : Colors.grey.shade500,
                  letterSpacing: 0.3,
                ),
                child: Text(label),
              ),

              // Active indicator
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                margin: EdgeInsets.only(top: 4),
                height: 3,
                width: isSelected ? 20 : 0,
                decoration: BoxDecoration(
                  color: Color(0xFF7165D6),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return CupertinoIcons.house_fill;
      case 1:
        return CupertinoIcons.chat_bubble_text_fill;
      case 2:
        return Icons.calendar_month;
      case 3:
        return Icons.settings;
      default:
        return CupertinoIcons.house_fill;
    }
  }
}
