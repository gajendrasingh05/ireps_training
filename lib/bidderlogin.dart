import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart'; // Added this import for SchedulerBinding

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IREPS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0), // Blue shade 800
          primary: const Color(0xFF1565C0), // Blue shade 800
          secondary: const Color(0xFF1976D2), // Slightly lighter blue
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const NotificationWrapper(child: HomePage()),
    );
  }
}

// New class that wraps the HomePage and shows the notification dialog
class NotificationWrapper extends StatefulWidget {
  final Widget child;

  const NotificationWrapper({super.key, required this.child});

  @override
  State<NotificationWrapper> createState() => _NotificationWrapperState();
}

class _NotificationWrapperState extends State<NotificationWrapper> {
  @override
  void initState() {
    super.initState();
    // Show dialog after the first frame is rendered
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _showNotificationDialog();
    });
  }

  void _showNotificationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Reduced border radius for more square appearance
          ),
          elevation: 4, // Reduced elevation
          backgroundColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(20), // Simplified padding
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with title and close icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Note',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    // Cross icon in the top right
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.close,
                        size: 20,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Note content with bullet points
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(4), // Smaller border radius
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Column(
                    children: [
                      // First note item with bullet aligned to middle of text
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center, // Changed to center alignment
                        children: [
                          Icon(
                            Icons.circle,
                            size: 7,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Please note that you cannot submit bids through IREPS App',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Second note item with bullet aligned to middle of text
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center, // Changed to center alignment
                        children: [
                          Icon(
                            Icons.circle,
                            size: 7,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'For Bidding and other features please visit www.ireps.gov.in',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Button
                SizedBox(
                  width: 100,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4), // More square button
                      ),
                      elevation: 1, // Reduced elevation
                    ),
                    child: const Text(
                      'Okay',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Changed default value to "Select" instead of "Goods and Services"
  String selectedWorkArea = 'Select';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> workAreas = [
    'Select',  // Added this as the first option
    'Goods and Services',
    'Works',
    'Earning & Leasing',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[100],

      // Add drawer with the ImprovedSidebar content
      drawer: const SidebarDrawer(),

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            // Open drawer when menu icon is clicked
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: const Text(
          'IREPS',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Login info with Work Area in a more compact layout
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Last Login: 25/02/25 10:57:36',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                // Work Area Dropdown (more compact)
                PopupMenuButton<String>(
                  onSelected: (String value) {
                    setState(() {
                      selectedWorkArea = value;
                    });
                  },
                  offset: const Offset(0, 28),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: BorderSide(color: Colors.grey[400]!),
                  ),
                  // Add this property to change the background color to white
                  color: Colors.white,
                  itemBuilder: (BuildContext context) {
                    return workAreas.map((String area) {
                      return PopupMenuItem<String>(
                        value: area,
                        child: Text(
                          area,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[800],
                            fontWeight: selectedWorkArea == area
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      );
                    }).toList();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.grey[400]!),
                    ),
                    child: Row(
                      children: [
                        Text(
                          selectedWorkArea,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[800],
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.grey[600],
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Quick Links Header (more compact)
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
            child: Text(
              'My Quick Links',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),

          // Quick Links Grid with original icon colors
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(8),
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.85,
              shrinkWrap: true,
              children: [
                _buildQuickLinkCard(
                  title: 'Pending Bills',
                  icon: Icons.pending_actions,
                  color: const Color(0xFFD68000), // Original darker amber
                ),
                _buildQuickLinkCard(
                  title: 'Closed Bills',
                  icon: Icons.inventory_2,
                  color: const Color(0xFF00796B), // Original darker teal
                ),
                _buildQuickLinkCard(
                  title: 'Payments',
                  icon: Icons.payments,
                  color: const Color(0xFF0D47A1), // Original darker blue
                ),
                _buildQuickLinkCard(
                  title: 'Live Tenders',
                  icon: Icons.gavel,
                  color: const Color(0xFF6A1B9A), // Original darker purple
                ),
                _buildQuickLinkCard(
                  title: 'Closed Tenders',
                  icon: Icons.rule_folder,
                  color: const Color(0xFFC62828), // Original darker red
                ),
                _buildQuickLinkCard(
                  title: 'Reverse Auction',
                  icon: Icons.swap_vert,
                  color: const Color(0xFFE65100), // Original darker orange
                ),
                _buildQuickLinkCard(
                  title: 'View Contracts',
                  icon: Icons.description,
                  color: const Color(0xFF283593), // Original darker indigo
                ),
              ],
            ),
          ),

          // Info note (more compact)
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.fromLTRB(8, 0, 8, 30),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD), // Light blue background
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: const Color(0xFFBBDEFB)),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: const Color(0xFF1565C0), size: 16), // Blue shade 800
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'You may also change Work Area from top right corner.',
                    style: TextStyle(
                      fontSize: 12,
                      color: const Color(0xFF1565C0), // Blue shade 800
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickLinkCard({
    required String title,
    required IconData icon,
    required Color color,
  }) {
    return InkWell(
      onTap: () {
        // No navigation, just handle tap if needed
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Create a separate class for the sidebar that will be used as a drawer
class SidebarDrawer extends StatelessWidget {
  const SidebarDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // Modified sidebar to fit the drawer pattern with blue shade 800 theme
    return Drawer(
      width: 280,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Enhanced User Profile Section with blue shade 800
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF1976D2), // Slightly lighter blue for sidebar header
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 45,
                      color: Color(0xFF1565C0), // Blue shade 800
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'TEST IIIB 2014',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'tb1.testbidder@gmail.com',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // Updated Verified User badge
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2), // Light transparent white background
                      border: Border.all(color: Colors.white.withOpacity(0.4), width: 1), // Subtle white border
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.verified_user,
                          size: 14,
                          color: Colors.white, // White icon
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Vendor User',
                          style: TextStyle(
                            color: Colors.white, // White text
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Optimized menu items with compact spacing
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Home Section - Changed to UserHome with home icon
                    _buildNavItem(context, 'UserHome', Icons.home, isTopLevel: true),

                    // Payment and Tenders Section with optimized spacing
                    _buildSectionHeader('Payment and Tenders'),
                    _buildNavItem(context, 'My Payments', Icons.account_balance_wallet),
                    _buildNavItem(context, 'My Live Tender', Icons.event_available),
                    _buildNavItem(context, 'My Closed Tenders', Icons.assignment_turned_in),
                    _buildNavItem(context, 'My Reverse Auction', Icons.gavel),

                    // Bill Tracking Section with optimized spacing
                    _buildSectionHeader('Bill Tracking'),
                    _buildNavItem(context, 'My Pending Bills', Icons.pending_actions),
                    _buildNavItem(context, 'My Closed Bills', Icons.task_alt),

                    // View Contracts Section with optimized spacing
                    _buildSectionHeader('View Contracts'),
                    _buildNavItem(context, 'My PO/RNote/RChallan', Icons.file_copy),

                    // My Account Section with optimized spacing
                    _buildSectionHeader('My Account'),
                    _buildNavItem(context, 'Change PIN', Icons.pin),
                    _buildNavItem(context, 'Logout', Icons.logout, onTap: () {
                      // Close drawer and handle logout
                      Navigator.pop(context);
                      // Add logout logic here
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: const Color(0xFF1565C0).withOpacity(0.8), // Blue shade 800 for section headers
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 2),
          Divider(color: const Color(0xFF1565C0).withOpacity(0.2), thickness: 1), // Blue shade 800 for dividers
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String title, IconData icon,
      {bool isTopLevel = false, VoidCallback? onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap ?? () {
          // Close the drawer when item is tapped
          Navigator.pop(context);
          // Add navigation logic here
        },
        splashColor: const Color(0xFF1565C0).withOpacity(0.1), // Blue shade 800 for splash
        highlightColor: const Color(0xFF1565C0).withOpacity(0.05), // Blue shade 800 for highlight
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Icon(
                icon,
                color: isTopLevel ? const Color(0xFF1565C0) : Colors.grey.shade700, // Blue shade 800 for top level icon
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: isTopLevel ? const Color(0xFF1565C0) : Colors.grey.shade800, // Blue shade 800 for top level text
                    fontSize: 14,
                    fontWeight: isTopLevel ? FontWeight.w600 : FontWeight.normal,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (isTopLevel)
                Icon(
                  Icons.arrow_forward_ios,
                  color: const Color(0xFF64B5F6).withOpacity(0.5), // Lighter blue for arrow
                  size: 14,
                ),
            ],
          ),
        ),
      ),
    );
  }
}