import 'package:flutter/material.dart';
import 'dart:async';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IREPS Resilience Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      themeMode: ThemeMode.light,
      home: const ResilienceDashboard(),
    );
  }
}
class BlinkingText extends StatefulWidget {
  final String text;
  final TextStyle style;

  const BlinkingText({
    Key? key,
    required this.text,
    required this.style,
  }) : super(key: key);

  @override
  _BlinkingTextState createState() => _BlinkingTextState();
}

// Replace the entire _BlinkingTextState class with this:
class _BlinkingTextState extends State<BlinkingText> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Blink every 1 second
    );
    _animationController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: Text(
        widget.text,
        style: widget.style,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class RotatingIcon extends StatefulWidget {
  final IconData icon;
  final Color color;
  final double size;

  const RotatingIcon({
    Key? key,
    required this.icon,
    required this.color,
    required this.size,
  }) : super(key: key);

  @override
  _RotatingIconState createState() => _RotatingIconState();
}

class _RotatingIconState extends State<RotatingIcon> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Complete one rotation every 2 seconds
    );

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * 3.14159, // Full circle in radians
    ).animate(_animationController);

    // Make the animation repeat continuously
    _animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotationAnimation.value,
          child: Icon(
            widget.icon,
            size: widget.size,
            color: widget.color,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class EmailServicesDetailView extends StatelessWidget {
  const EmailServicesDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Email Services Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.email_outlined, color: Colors.blue.shade700, size: 20),
                      const SizedBox(width: 8),
                      const Text(
                        'Email Services',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    child: DataTable(
                      columnSpacing: 20,
                      dataRowHeight: 60,
                      headingRowHeight: 50,
                      columns: const [
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'S No.',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Module',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Email Type',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Last Sent',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Count',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                      rows: [
                        _buildEmailDataRow('1', 'LT', 'Tender Native', '2025-05-23', '10:45', '  25'),
                        _buildEmailDataRow('2', 'WT', 'Bidding', '2025-05-23', '10:30', '  18'),
                        _buildEmailDataRow('3', 'LS', 'Payment Confirmation', '2025-05-23', '09:15', '  42'),
                        _buildEmailDataRow('4', 'SA', 'Payment Confirmation', '2025-05-23', '09:15', '  60'),
                        _buildEmailDataRow('5', 'LA', 'Bidding', '2025-05-23', '09:15', '  90'),
                        _buildEmailDataRow('6', 'LT', 'Tender Native', '2025-05-23', '09:15', '  52'),
                        _buildEmailDataRow('7', 'WS', 'Tender Native', '2025-05-23', '09:15', '  55'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  DataRow _buildEmailDataRow(String sNo, String module, String emailType, String date, String time, String count) {
    return DataRow(
      cells: [
        DataCell(Text(sNo, style: const TextStyle(fontWeight: FontWeight.w500))),
        DataCell(Text(module, style: const TextStyle(fontWeight: FontWeight.w500))),
        DataCell(Text(emailType)),
        DataCell(
          emailType.isNotEmpty && date.isNotEmpty && time.isNotEmpty
              ? RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black, fontSize: 14),
              children: [
                TextSpan(text: '$date '),
                TextSpan(
                  text: time,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
              : const Text(''),
        ),
        DataCell(Text(count, style: const TextStyle(fontWeight: FontWeight.w500))),
      ],
    );
  }
}
class ResilienceDashboard extends StatefulWidget {
  const ResilienceDashboard({Key? key}) : super(key: key);

  @override
  _ResilienceDashboardState createState() => _ResilienceDashboardState();
}

class _ResilienceDashboardState extends State<ResilienceDashboard> {
  int _selectedIndex = 0;
  int _secondsUntilRefresh = 120;
  Timer? _refreshTimer;
  bool _isExpanded = false;
  bool _showDCServers = true;
  String _getFormattedDateTime() {
    final current = DateTime.now();
    // Use the current time but set the year to 2025
    final now = DateTime(2025, current.month, current.day, current.hour, current.minute);
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[now.month - 1]} ${now.day}, ${now.year} • ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }
  @override
  void initState() {
    super.initState();
    _startRefreshTimer();
  }
  void _startRefreshTimer() {
    _refreshTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsUntilRefresh > 0) {
          _secondsUntilRefresh--;
        } else {
          _secondsUntilRefresh = 120;
          // Add your refresh logic here
        }
      });
    });
  }
  void _showDangerAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.warning_rounded, color: Colors.red.shade600, size: 28),
              const SizedBox(width: 12),
              const Text(
                'System Alert',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: const Text(
            'Server performance has dropped below critical threshold (30%). Immediate attention required.',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Dismiss'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to server health view
                setState(() {
                  _selectedIndex = 1;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
              ),
              child: const Text('View Servers'),
            ),
          ],
        );
      },
    );
  }
  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'IREPS Resilience Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        elevation: 0,
      ),
      drawer: NavigationDrawer(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
            Navigator.pop(context);
          });
        },
        children: const [
          Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text(
              'IREPS Dashboard',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.warning_amber_outlined),
            selectedIcon: Icon(Icons.warning_amber),
            label: Text('Alerts'),
          ),
          Divider(),
          NavigationDrawerDestination(
            icon: Icon(Icons.help_outline),
            selectedIcon: Icon(Icons.help),
            label: Text('Help'),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildDashboardView(),
          _buildServerHealthView(),
          _buildTransactionsView(),
          _buildSystemIntegrationView(),
          _buildAlertsView(),
          _buildHelpView(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Overview',
          ),
          NavigationDestination(
            icon: Icon(Icons.storage_outlined),
            selectedIcon: Icon(Icons.storage),
            label: 'Servers',
          ),
          NavigationDestination(
            icon: Icon(Icons.swap_horiz_outlined),
            selectedIcon: Icon(Icons.swap_horiz),
            label: 'Transactions',
          ),
          NavigationDestination(
            icon: Icon(Icons.sync_outlined),
            selectedIcon: Icon(Icons.sync),
            label: 'Integration',
          ),
        ],
        selectedIndex: _selectedIndex < 4 ? _selectedIndex : 0,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
// Method to determine color based on performance percentage
  Color _getStatusColor(double percentage) {
    if (percentage < 30) {
      return Colors.red;           // Critical - Red
    } else if (percentage < 70) {
      return Colors.orange;        // Warning - Orange
    } else {
      return Colors.green;         // Good - Green
    }
  }

// Method to get status text based on performance
  String _getStatusText(double percentage) {
    if (percentage < 30) {
      return 'Critical';
    } else if (percentage < 70) {
      return 'Warning';
    } else {
      return 'Normal';
    }
  }

// Updated method to check if any system is in danger state
  bool _isDangerousSystemState() {
    // Define your actual metrics here - make sure these match the values in _buildStatusSummary
    double transactionHealth = 25.0;  // Example: 25%
    double integrationHealth = 100.0; // Example: 100%
    double serverHealth = 99.9;       // Example: 99.9%

    // Return true if any system is below 30%
    return transactionHealth < 30 || integrationHealth < 30 || serverHealth < 30;
  }

  Widget _buildDashboardView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDashboardHeader(),
            const SizedBox(height: 16),
            _buildStatusSummary(),
            const SizedBox(height: 24),
            _buildMetricSummaryGrids(),
            const SizedBox(height: 24),
            _buildActiveServicesSection(), // Added Active Services section
            const SizedBox(height: 24), // Added spacing
            _buildRecentActivitySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Replaced Column with just the timestamp text that will blink
        BlinkingText(
          text: 'Last updated: ${_getFormattedDateTime()}',
          style: TextStyle(
            fontSize: 14,
            color: Colors.blue[600], // Theme-matching color
            fontWeight: FontWeight.w500,
          ),
        ),
        // Changed button style
        // Replace the timer container in _buildDashboardHeader() with this:
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),  // Reduced padding
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue.shade300),
            borderRadius: BorderRadius.circular(16),  // Smaller border radius
            color: Colors.blue.shade50,
          ),
          child: Row(
            children: [
              RotatingIcon(
                icon: Icons.hourglass_bottom,
                size: 16,
                color: Colors.blue.shade700,
              ),  // Rotating hourglass icon
              const SizedBox(width: 4),  // Smaller spacing
              Text(
                '${_secondsUntilRefresh}s',  // Shorter text
                style: TextStyle(
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,  // Smaller font
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildStatusSummary() {
    // Define your actual metrics here - replace these with your real values
    double transactionHealth = 25.0;  // Example: Below 30% - should show orange
    double integrationHealth = 100.0; // Example: Above 30% - should show green
    double serverHealth = 99.9;       // Example: Above 30% - should show green

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0), // Reduced from 16.0
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'System Status',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildDangerAlertButton(),
              ],
            ),
            const SizedBox(height: 8), // Reduced from 16
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatusIndicator('Transactions', Colors.orange, '${transactionHealth.toInt()}', '', isWarning: true),
                _buildStatusIndicator('Integration', _getStatusColor(integrationHealth), '${integrationHealth.toInt()}%', ''),
                _buildStatusIndicator('Server', _getStatusColor(serverHealth), '${serverHealth}%', ''),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDangerAlertButton() {
    bool isDangerousState = _isDangerousSystemState();

    if (!isDangerousState) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red.shade600, Colors.red.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            _showDangerAlert();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.warning_rounded,
                  color: Colors.white,
                  size: 18,
                ),
                const SizedBox(width: 6),
                const Text(
                  'ALERT',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildStatusIndicator(String title, Color color, String value, String subtitle, {bool isWarning = false}) {
    return Column(
      children: [
        if (isWarning)
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.close,
              color: Colors.white,
              size: 20,
            ),
          )
        else
          Icon(
            Icons.check_circle,
            color: color,
            size: 36, // Reduced from 50
          ),
        const SizedBox(height: 4), // Reduced from 8
        Text(
          title,
          style: TextStyle(
            fontSize: 14, // Reduced from 16
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 12, // Reduced from 14
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
  Widget _buildRecentActivitySection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Activity',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildActivityItem(
              Icons.check_circle_outline,
              Colors.green,
              'Tender ID: TEN-2025-05-1243 published successfully',
              '5 minutes ago',
            ),
            const Divider(),
            _buildActivityItem(
              Icons.warning_amber_outlined,
              Colors.orange,
              'Payment processing delay detected',
              '15 minutes ago',
            ),
            const Divider(),
            _buildActivityItem(
              Icons.check_circle_outline,
              Colors.green,
              'System Integration successfully completed',
              '1 hour ago',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(IconData icon, Color color, String title, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricSummaryGrids() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Key Metrics',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.2, // Changed from 1.5 to 1.2 to provide more height
          children: [
            _buildMetricCard(
              'Tenders Published',
              'In last 15 mins',
              '4',
              Colors.blue,
              Icons.insert_drive_file_outlined,
            ),
            _buildMetricCard(
              'Tenders Opened',
              'In last 15 mins',
              '3',
              Colors.green,
              Icons.folder_open_outlined,
            ),
            _buildMetricCard(
              'Payment Transactions',
              'In last 15 mins',
              '7',
              Colors.purple,
              Icons.payment_outlined,
            ),
            _buildMetricCard(
              'Payment Transactions\n(module wise)',
              'In last 15 mins',
              '6',
              Colors.deepPurple,
              Icons.account_balance_wallet_outlined,
            ),
            _buildMetricCard(
              'Purchase Orders',
              'In last 15 mins',
              '5',
              Colors.amber,
              Icons.shopping_cart_outlined,
            ),
            _buildMetricCard(
              'UDM Transaction',
              'In last 15 mins',
              '9',
              Colors.teal,
              Icons.compare_arrows,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String timeframe, String count, Color color, IconData icon) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size:20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12, // Slightly reduced font size
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: Text(
                    timeframe,
                    style: TextStyle(
                      fontSize: 12, // Reduced font size
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  count,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "In last 1 hour",
                    style: TextStyle(
                      fontSize: 12, // Reduced font size
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "8",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "In last 12 hours",
                    style: TextStyle(
                      fontSize: 12, // Reduced font size
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "15",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildTransactionsView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Transaction'),
            const SizedBox(height: 16),
            // Payment Services Table - MOVED TO TOP
            // Payment Services Table - MOVED TO TOP
            _buildPaymentServicesTable(),
            const SizedBox(height: 16),
// E-Scroll Status Table - NEW
            // E-Scroll Status Table - NEW
            _buildEScrollStatusTable(),
            const SizedBox(height: 16),
// Double Verification Pending Table - NEW
            _buildDoubleVerificationTable(),
            const SizedBox(height: 16),
            // E-Auction Table
            _buildModuleMetricsTable(
              'E-Auction',
              Icons.gavel_outlined,
              Colors.blue,
            ),
            const SizedBox(height: 16),
            // E-Tender Table
            _buildModuleMetricsTable(
              'E-Tender',
              Icons.description_outlined,
              Colors.green,
            ),
            const SizedBox(height: 16),
            // CRIS MMIS Table
            _buildModuleMetricsTable(
              'CRIS MMIS',
              Icons.inventory_2_outlined,
              Colors.purple,
            ),
            const SizedBox(height: 16),
            // UDM Table
            _buildModuleMetricsTable(
              'UDM',
              Icons.data_usage_outlined,
              Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildModuleMetricsTable(String title, IconData icon, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon and title
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Table
            Container(
              width: double.infinity,
              child: DataTable(
                columnSpacing: 24,
                dataRowHeight: 60,
                columns: const [
                  DataColumn(
                    label: Expanded(
                      child: Text(
                          'Metric',
                          style: TextStyle(fontWeight: FontWeight.bold)
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Today',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'MTD',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
                rows: [
                  _buildDataRow('Tenders Published', '   12', '   48'),
                  _buildDataRow('Tenders Opened', '   8', '   32'),
                  _buildDataRow('Tenders Decided', '   5', '   26'),
                  _buildDataRow('Payment Transactions', '   27', '   93'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildPaymentServicesTable() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon and title
            Row(
              children: [
                Icon(Icons.payment_outlined, color: Colors.indigo, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'Payment Services',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Table
            Container(
              width: double.infinity,
              child: DataTable(
                columnSpacing: 8,
                dataRowHeight: 50,
                headingRowHeight: 45,
                dataTextStyle: const TextStyle(fontSize: 13),
                headingTextStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                columns: const [
                  DataColumn(
                    label: SizedBox(
                      width: 70,
                      child: Text(
                        'Bank',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 110,
                      child: Text(
                        'Last Success',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 110,
                      child: Text(
                        'Last Failed',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
                rows: [
                  _buildPaymentDataRow('SBI-INB', '2025-05-28', '10:45', '  2025-05-27', '14:30'),
                  _buildPaymentDataRow('SBI ePay', '2025-05-28', '10:42', '  2025-05-26', '09:15'),
                  _buildPaymentDataRow('SBI VAN', '2025-05-28', '10:38', '  2025-05-27', '16:20'),
                  _buildPaymentDataRow('SBI Lien', '2025-05-28', '10:35', '  2025-05-27', '11:45'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildPaymentDataRow(String bankName, String successDate, String successTime, String failedDate, String failedTime) {
    return DataRow(
      cells: [
        DataCell(
          SizedBox(
            width: 70,
            child: Text(
              bankName,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        DataCell(
          SizedBox(
            width: 110,
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black, fontSize: 13),
                children: [
                  TextSpan(text: '$successDate '),
                  TextSpan(
                    text: successTime,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        DataCell(
          SizedBox(
            width: 110,
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black, fontSize: 13),
                children: [
                  TextSpan(text: '$failedDate '),
                  TextSpan(
                    text: failedTime,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildEScrollStatusTable() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon and title
            Row(
              children: [
                Icon(Icons.receipt_long_outlined, color: Colors.deepPurple, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'E-Scroll Status',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Table
            Container(
              width: double.infinity,
              child: DataTable(
                columnSpacing: 20,
                dataRowHeight: 60,
                headingRowHeight: 50,
                columns: const [
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Bank',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Pending Count',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Oldest Date',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ),
                ],
                rows: [
                  _buildEScrollDataRow('SBI-INB', '         15', '2025/05/25'),
                  _buildEScrollDataRow('SBI ePay', '         10', '2025/03/25'),
                  _buildEScrollDataRow('SBI VAN', '         04', '2025/05/25'),
                  _buildEScrollDataRow('SBI Lien', '         20', '2025/05/25'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  DataRow _buildEScrollDataRow(String bankName, String pendingCount, String oldestDate) {
    return DataRow(
      cells: [
        DataCell(Text(bankName, style: const TextStyle(fontWeight: FontWeight.w500))),
        DataCell(Text(pendingCount, style: const TextStyle(fontWeight: FontWeight.w500))),
        DataCell(Text(oldestDate, style: const TextStyle(fontWeight: FontWeight.w500))),
      ],
    );
  }

  Widget _buildDoubleVerificationTable() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon and title in two lines
            Row(
              children: [
                Icon(Icons.verified_user_outlined, color: Colors.teal, size: 20),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Double Verification Pending',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '(as on ${_getFormattedDateTime().split(' • ')[0]})',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Table
            Container(
              width: double.infinity,
              child: DataTable(
                columnSpacing: 8,
                dataRowHeight: 50,
                headingRowHeight: 45,
                dataTextStyle: const TextStyle(fontSize: 13),
                headingTextStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                columns: const [
                  DataColumn(
                    label: SizedBox(
                      width: 70,
                      child: Text(
                        'Bank',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 50,
                      child: Text(
                        'Count',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 80,
                      child: Text(
                        'Retry Level',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 110,
                      child: Text(
                        'Last Retry',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
                rows: [
                  _buildDoubleVerificationDataRow('SBI-INB', '10', '200', '2025-05-28', '09:45'),
                  _buildDoubleVerificationDataRow('SBI ePay', '5', '5', '2025-05-28', '10:20'),
                  _buildDoubleVerificationDataRow('SBI VAN', '6', '10', '2025-05-28', '08:15'),
                  _buildDoubleVerificationDataRow('SBI Lien', '15', '55', '2025-05-28', '11:30'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildDoubleVerificationDataRow(String bankName, String count, String retryLevel, String date, String time) {
    return DataRow(
      cells: [
        DataCell(
          SizedBox(
            width: 70,
            child: Text(
              bankName,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        DataCell(
          SizedBox(
            width: 50,
            child: Text(
              count,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        DataCell(
          SizedBox(
            width: 80,
            child: Text(
              retryLevel,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        DataCell(
          SizedBox(
            width: 110,
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black, fontSize: 13),
                children: [
                  TextSpan(text: '$date '),
                  TextSpan(
                    text: time,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModuleCard(String title, String description, String count, Color color, IconData icon) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  count,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Last 1 hour",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "12",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Last 12 hours",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "45",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
  Widget _buildTransactionMetricsTable() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Table wrapped in Container to control width
            Container(
              width: double.infinity, // This makes it take full width
              child: DataTable(
                columnSpacing: 24,
                dataRowHeight: 60,
                // Remove the horizontal scroll and make columns flexible
                columns: const [
                  DataColumn(
                    label: Expanded(
                      child: Text(
                          'Metric',
                          style: TextStyle(fontWeight: FontWeight.bold)
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Today',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'MTD',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
                rows: [
                  _buildDataRow('Tenders Published', '   12', '   48'),
                  _buildDataRow('Tenders Opened', '   8', '   32'),
                  _buildDataRow('Tenders Decided', '   5', '   26'),
                  _buildDataRow('Payment Transactions', '   27', '   93'),
                  _buildDataRow('Issues/Receipt in UDM', '   18', '   67'),
                  _buildDataRow('Demands Generated', '   22', '   105'),
                  _buildDataRow('Purchase Orders Issued', '   15', '   156'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  DataRow _buildDataRow(String metric, String today, String mtd) {
    return DataRow(
      cells: [
        DataCell(Text(metric, style: const TextStyle(fontWeight: FontWeight.w500))),
        DataCell(Text(today)),
        DataCell(Text(mtd)),
      ],
    );
  }
  Widget _buildStatusCards() {
    return Row(
      children: [
        Expanded(
          child: _buildStatusCard(
            'SLA Compliance',
            '98.7%',
            'Up 1.2% from last month',
            Icons.timer_outlined,
            Colors.green,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatusCard(
            'Processing Time',
            '3.2h',
            'Down 0.5h from average',
            Icons.speed_outlined,
            Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusCard(String title, String value, String subtitle, IconData icon, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildSystemIntegrationView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('System Integration Health'),
            const SizedBox(height: 16),
            _buildIntegrationStatusList(),
            const SizedBox(height: 24),
            _buildServicesStatusList(), // ADD THIS NEW LINE
            const SizedBox(height: 24),
            _buildIntegrationJobsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildIntegrationStatusList() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ESB Adapter Status',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildEsbAdapterItem('IREPS', true, '2025-05-27', '10:45'),
            const Divider(),
            _buildEsbAdapterItem('MMIS', true, '2025-05-27', '10:30'),
            const Divider(),
            _buildEsbAdapterItem('UDM', true, '2025-05-27', '09:15'),
            const Divider(),
            _buildEsbAdapterItem('VIMS', true, '2025-05-27', '08:45'),
          ],
        ),
      ),
    );
  }
  Widget _buildServicesStatusList() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Services Status (Project wise)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildIntegrationItem('FOIS', true, '2025-05-27', '10:45', label: 'Last Active'),
            const Divider(),
            _buildIntegrationItem('PRS', true, '2025-05-27', '10:45', label: 'Last Active'),
            const Divider(),
            _buildIntegrationItem('IPAS', true, '2025-05-27', '10:45', label: 'Last Active'),
            const Divider(),
            _buildIntegrationItem('ICF', true, '2025-05-27', '10:45', label: 'Last Active'),
            const Divider(),
            _buildIntegrationItem('KRCL', true, '2025-05-27', '10:45', label: 'Last Active'),
            const Divider(),
            //  _buildIntegrationItem('UDM Api', true, '2025-05-27', '10:35'),
            //  const Divider(),
            //  _buildIntegrationItem('UDM Data Sync', true, '2025-05-27', '10:33'),
            //  const Divider(),
            //  _buildIntegrationItem('UDM Inventory Service', true, '2025-05-27', '10:31'),
            //  const Divider(),
            //  _buildIntegrationItem('UDM Material Service', true, '2025-05-27', '10:29'),
            //  const Divider(),
            //  _buildIntegrationItem('UDM Vendor Service', true, '2025-05-27', '10:27'),
            //  const Divider(),
            _buildUdmGroupedSection(),
            const Divider(),
            _buildIntegrationItem('WISE', true, '2025-05-27', '10:45', label: 'Last Active'),
          ],
        ),
      ),
    );
  }
  Widget _buildUdmGroupedSection() {
    return Column(
      children: [
        // Main UDM API header
        _buildIntegrationItem('UDM Api', true, '2025-05-27', '10:45', label: 'Last Active'),
        // Grouped UDM sub-services with indentation
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Column(
            children: [
              const Divider(),
              _buildUdmSubService('UDM Data Sync'),
              const Divider(),
              _buildUdmSubService('UDM Inventory Service'),
              const Divider(),
              _buildUdmSubService('UDM Material Service'),
              const Divider(),
              _buildUdmSubService('UDM Vendor Service'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUdmSubService(String serviceName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  serviceName,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    children: const [
                      TextSpan(text: 'Last Active: 2025-05-27 '),
                      TextSpan(
                        text: '10:35',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
        ],
      ),
    );
  }
  Widget _buildIntegrationItem(String system, bool isConnected, String date, String time, {String label = 'Last Sent'}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: isConnected ? Colors.green : Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  system,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    children: [
                      TextSpan(text: '$label: '),
                      TextSpan(text: '$date '),
                      TextSpan(
                        text: time,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          isConnected
              ? const Icon(Icons.check_circle, color: Colors.green, size: 20)
              : const Icon(Icons.error, color: Colors.red, size: 20),
        ],
      ),
    );
  }
  Widget _buildEsbAdapterItem(String system, bool isConnected, String date, String time, {String label = 'Last Sent'}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: isConnected ? Colors.green : Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  system,
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
                const SizedBox(height: 6),
                // Sent and Received in one line
                Row(
                  children: [
                    // Last Sent
                    Icon(Icons.north, color: Colors.blue.shade600, size: 12),
                    const SizedBox(width: 2),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                        ),
                        children: [
                          const TextSpan(text: 'Sent: '),
                          TextSpan(text: '$date '),
                          TextSpan(
                            text: time,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Last Received
                    Icon(Icons.south, color: Colors.green.shade600, size: 12),
                    const SizedBox(width: 2),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                          children: [
                            const TextSpan(text: 'Received: '),
                            TextSpan(text: '$date '),
                            TextSpan(
                              text: time,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          isConnected
              ? const Icon(Icons.check_circle, color: Colors.green, size: 20)
              : const Icon(Icons.error, color: Colors.red, size: 20),
        ],
      ),
    );
  }
  Widget _buildIntegrationJobsSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Exception',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                OutlinedButton.icon(
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry All'),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildJobItem('Safety - FOIS', 'Failed', Colors.red, '10:15'),
                _buildJobItem('Pending TMS Lot', 'Pending', Colors.orange, '11:30'),
                _buildGroupedJobSection(),
                _buildBulkDataSection(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobItem(String jobName, String status, Color statusColor, String time) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      color: Colors.grey.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 50,
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jobName,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                      children: [
                        const TextSpan(text: 'Last sent: 2025-05-27'),
                        TextSpan(
                          text: time,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Chip(
              label: Text(
                status,
                style: TextStyle(
                  color: status == 'Failed' ? Colors.white : Colors.black,
                  fontSize: 12,
                ),
              ),
              backgroundColor: statusColor.withOpacity(status == 'Failed' ? 1.0 : 0.2),
              padding: const EdgeInsets.symmetric(horizontal: 4),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildGroupedJobSection() {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      color: Colors.grey.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Main header row
            Row(
              children: [
                Container(
                  width: 8,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Online TY to IPAS',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          children: const [
                            TextSpan(text: 'Last sent: 2025-05-27 '),
                            TextSpan(
                              text: '10:15',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Chip(
                  label: const Text(
                    'Failed',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            ),

            // Sub-item
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 8.0),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PG-dtls-ipas',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            children: const [
                              TextSpan(text: 'Last sent: 2025-05-27 '),
                              TextSpan(
                                text: '10:15',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Chip(
                    label: const Text(
                      'Failed',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildBulkDataSection() {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      color: Colors.grey.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Main header row
            Row(
              children: [
                Container(
                  width: 8,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bulk data sent',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          children: const [
                            TextSpan(text: 'Last sent: 2025-05-27 '),
                            TextSpan(
                              text: '09:45',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Chip(
                  label: const Text(
                    'Alert',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            ),

            // Sub-items
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 8.0),
              child: Column(
                children: [
                  _buildBulkSubItem('Stock meter', isSuccessful: true),
                  const SizedBox(height: 8),
                  _buildBulkSubItem('Stock', isSuccessful: true),
                  const SizedBox(height: 8),
                  _buildBulkSubItem('Stock'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildBulkSubItem(String jobName, {bool isSuccessful = false}) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 40,
          decoration: BoxDecoration(
            color: isSuccessful ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                jobName,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  children: const [
                    TextSpan(text: 'Last sent: 2025-05-27 '),
                    TextSpan(
                      text: '09:45',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Chip(
          label: Text(
            isSuccessful ? 'Successful' : 'Failed',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          backgroundColor: isSuccessful ? Colors.green : Colors.red,
          padding: const EdgeInsets.symmetric(horizontal: 4),
        ),
      ],
    );
  }
  Widget _buildSubJobItem(String jobName) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      color: Colors.grey.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              width: 6,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jobName,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                      children: const [
                        TextSpan(text: 'Last sent: 2025-05-27 '),
                        TextSpan(
                          text: '09:45',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Chip(
              label: const Text(
                'Failed',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 4),
            ),
          ],
        ),
      ),
    );
  }
// Add this new method to build the server visualization section
  Widget _buildServerVisualizationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Server Health & Status',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        // Modern toggle buttons
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade100,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _showDCServers = true;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: _showDCServers
                            ? Colors.blue.shade600
                            : Colors.transparent,
                      ),
                      child: Center(
                        child: Text(
                          'Production DC Servers',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: _showDCServers
                                ? Colors.white
                                : Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _showDCServers = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: !_showDCServers
                            ? Colors.blue.shade600
                            : Colors.transparent,
                      ),
                      child: Center(
                        child: Text(
                          'Production DR Servers',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: !_showDCServers
                                ? Colors.white
                                : Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Conditionally show either DC or DR servers
        if (_showDCServers)
        // Production DC Servers Section
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildServerTypeGroup('Web Servers', Colors.green.shade100, [
                          _buildServerBox('Web Server 1', '15.02%', '4.73%', true),
                          _buildServerBox('Web Server 2', '14.62%', '4.71%', true),
                          _buildServerBox('Web Server 3', '55.66%', '2.67%', true),
                        ]),
                        const SizedBox(width: 8),
                        _buildServerTypeGroup('App Servers', Colors.green.shade100, [
                          _buildServerBox('WAS Server 1', '50.00%', '45%', true),
                          _buildSpecialServerBox('WAS Server 2', '17%', '10%', [
                            '10.30.2.116',
                            '9080 listening',

                          ], true),
                          _buildServerBox('JBoss Server 1', '28.11%', '10%', true),
                        ]),
                        const SizedBox(width: 8),
                        _buildServerTypeGroup('DB Servers', Colors.green.shade100, [
                          _buildServerBox('Database Server 1', '45.30%', '25.34%', true),
                          _buildServerBox('Database Server 2', '57.27%', '28.85%', true),
                          _buildServerBox('Database Server 3', '51.33%', '29.97%', true),
                        ]),
                        const SizedBox(width: 8),
                        _buildServerTypeGroup('Storage', Colors.green.shade100, [
                          _buildServerBox('SAN', '10%', '10%', true),
                          _buildServerBox('MSA', '11%', '11%', true),
                          _buildServerBox('Web Firm', '99.07%', '7.07%', true),
                        ]),
                        const SizedBox(width: 8),
                        _buildServerTypeGroup('Other Prod. Servers', Colors.green.shade100, [
                          _buildServerBox('UTILITY1', '1.50%', '8.63%', true),
                          _buildServerBox('Utility', '2.70%', '3.45%', true),
                          _buildServerBox('Backup Server (Win.)', '15%', '15%', true),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        else
        // Production DR Servers Section
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildServerTypeGroup('Web Servers', Colors.green.shade100, [
                          _buildUnavailableServerBox('Web Server 1'),
                          _buildUnavailableServerBox('Web Server 2'),
                          _buildUnavailableServerBox('CRL & SMS'),
                        ]),
                        const SizedBox(width: 8),
                        _buildServerTypeGroup('App Servers', Colors.green.shade100, [
                          _buildUnavailableServerBox('WAS Server 1'),
                          _buildUnavailableServerBox('WAS Server 2'),
                          _buildUnavailableServerBox('JBoss Server 1'),
                        ]),
                        const SizedBox(width: 8),
                        _buildServerTypeGroup('DB Servers', Colors.green.shade100, [
                          _buildServerBox('Database Server 1', '1.23%', '1.08%', true),
                          _buildServerBox('Database Server 2', '0.37%', '0.85%', true),
                          _buildServerBox('Database Server 3', '0.60%', '0.60%', true),
                        ]),
                        const SizedBox(width: 8),
                        _buildServerTypeGroup('Storage', Colors.green.shade100, [
                          _buildServerBox('SAN', '9%', '9%', true),
                          _buildUnavailableServerBox('Web Firm'),
                          _buildUnavailableServerBox('Service(s) Unavailable'),
                        ]),
                        const SizedBox(width: 8),
                        _buildServerTypeGroup('Other Prod. Servers', Colors.green.shade100, [
                          _buildUnavailableServerBox('Util. & Integration Sys'),
                          _buildDownServerBox('Server Down', 'Backup Server (Win.)'),
                          _buildServerBox('Backup Server (Linux)', '0.11%', '6.89%', true),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
// Helper methods for building server visualizations
  Widget _buildServerTypeGroup(String title, Color color, List<Widget> servers) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
          ...servers,
        ],
      ),
    );
  }

  Widget _buildServerBox(String name, String cpuUsage, String memoryUsage, bool isHealthy) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Server name with icon
          Row(
            children: [
              Icon(
                Icons.storage_rounded,
                color: isHealthy ? Colors.blue.shade700 : Colors.red,
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.grey.shade800,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          // CPU usage row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'CPU',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: double.parse(cpuUsage.replaceAll('%', '')) > 80
                      ? Colors.red.shade50
                      : double.parse(cpuUsage.replaceAll('%', '')) > 50
                      ? Colors.orange.shade50
                      : Colors.green.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  cpuUsage,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                    color: double.parse(cpuUsage.replaceAll('%', '')) > 80
                        ? Colors.red.shade700
                        : double.parse(cpuUsage.replaceAll('%', '')) > 50
                        ? Colors.orange.shade700
                        : Colors.green.shade700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Memory usage row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Memory',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: double.parse(memoryUsage.replaceAll('%', '')) > 80
                      ? Colors.red.shade50
                      : double.parse(memoryUsage.replaceAll('%', '')) > 50
                      ? Colors.orange.shade50
                      : Colors.green.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  memoryUsage,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                    color: double.parse(memoryUsage.replaceAll('%', '')) > 80
                        ? Colors.red.shade700
                        : double.parse(memoryUsage.replaceAll('%', '')) > 50
                        ? Colors.orange.shade700
                        : Colors.green.shade700,
                  ),
                ),
              ),
            ],
          ),
          // Indicator dot
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: isHealthy ? Colors.green : Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),

            ],
          ),
        ],
      ),
    );
  }



  Widget _buildSpecialServerBox(String name, String cpuUsage, String memoryUsage, List<String> details, bool isHealthy) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50.withOpacity(0.3),
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Server name with icon
          Row(
            children: [
              Icon(
                Icons.dns_rounded,
                color: Colors.indigo.shade700,
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.indigo.shade800,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Details section
          ...details.map((detail) => Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Text(
              detail,
              style: TextStyle(
                fontSize: 10,
                color: Colors.indigo.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          )).toList(),
          const Spacer(),
          // CPU and Memory in a row to save space
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // CPU
              Row(
                children: [
                  Text(
                    'CPU:',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: double.parse(cpuUsage.replaceAll('%', '')) > 80
                          ? Colors.red.shade50
                          : double.parse(cpuUsage.replaceAll('%', '')) > 50
                          ? Colors.orange.shade50
                          : Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      cpuUsage,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        color: double.parse(cpuUsage.replaceAll('%', '')) > 80
                            ? Colors.red.shade700
                            : double.parse(cpuUsage.replaceAll('%', '')) > 50
                            ? Colors.orange.shade700
                            : Colors.green.shade700,
                      ),
                    ),
                  ),
                ],
              ),
              // Memory
              Row(
                children: [
                  Text(
                    'Mem:',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: double.parse(memoryUsage.replaceAll('%', '')) > 80
                          ? Colors.red.shade50
                          : double.parse(memoryUsage.replaceAll('%', '')) > 50
                          ? Colors.orange.shade50
                          : Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      memoryUsage,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        color: double.parse(memoryUsage.replaceAll('%', '')) > 80
                            ? Colors.red.shade700
                            : double.parse(memoryUsage.replaceAll('%', '')) > 50
                            ? Colors.orange.shade700
                            : Colors.green.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Status indicator
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: isHealthy ? Colors.green : Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),

            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUnavailableServerBox(String name) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Server name with icon
          Row(
            children: [
              Icon(
                Icons.storage_rounded,
                color: Colors.grey.shade400,
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Centered unavailable status
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Text(
                'Service Unavailable',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange.shade800,
                ),
              ),
            ),
          ),
          const Spacer(),
          // Status indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                'Disabled',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.orange,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDownServerBox(String status, String name) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Server name with icon
          Row(
            children: [
              Icon(
                Icons.storage_rounded,
                color: Colors.red.shade300,
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Centered warning status
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  color: Colors.red,
                  size: 26,
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.red.shade800,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          // Downtime indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.access_time, color: Colors.red.shade300, size: 14),
              const SizedBox(width: 4),
              Text(
                'Down for 05:37',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.red.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }









  Widget _buildServerHealthView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Server visualization section
            _buildServerVisualizationSection(),
            const SizedBox(height: 24),
            // Add the new replication status section here
            _buildReplicationStatusSection(),
            const SizedBox(height: 24),
            // Keep the error items but remove the chart and header
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Keep only the error items
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildErrorItem('API Timeout', 'Payment Gateway', 3, '11:25 AM'),
                        _buildErrorItem('Authentication Failed', 'User Login', 2, '10:40 AM'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServerMetricsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.2,
      children: [
        _buildServerMetricCard(
          'Application Uptime',
          '99.9%',
          '30 days',
          Colors.green,
          Icons.access_time,
        ),
        _buildServerMetricCard(
          'Avg Response Time',
          '235ms',
          'Peak: 450ms',
          Colors.blue,
          Icons.speed,
        ),
        _buildServerMetricCard(
          'Error Rate',
          '0.03%',
          '24h average',
          Colors.green,
          Icons.error_outline,
        ),
        _buildServerMetricCard(
          'CPU Usage',
          '42%',
          'Peak: 65%',
          Colors.blue,
          Icons.memory,
        ),
      ],
    );
  }

  Widget _buildServerMetricCard(String title, String value, String subtitle, Color color, IconData icon) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              value,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildReplicationStatusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'System Replication Status',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        // Web Servers Replication Status
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left side - Web Servers
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Web Servers',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Web Servers Grid
                          Row(
                            children: [
                              _buildWebServerStatus('web1', '10', '2025-05-13_131601'),
                              const SizedBox(width: 10),
                              _buildWebServerStatus('web2', '10', '2025-05-13_131601'),
                              const SizedBox(width: 10),
                              _buildWebServerStatus('cpweb1', '10', '2025-05-13_131601'),
                              const SizedBox(width: 10),
                              _buildWebServerStatus('cpweb2', '10', '2025-05-13_131601'),
                            ],
                          ),

                          const SizedBox(height: 16),
                          // System Error Messages
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.red.shade200),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.error_outline, color: Colors.red.shade700, size: 16),
                                    const SizedBox(width: 8),
                                    Text(
                                      'PCPEPSIMMS (May 13 04:01:32)',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red.shade700,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.only(left: 24),
                                  child: Text(
                                    'systemd[1]: webfrm.service: Failed with result \'timeout\'.',
                                    style: TextStyle(
                                      color: Colors.red.shade800,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.red.shade200),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.error_outline, color: Colors.red.shade700, size: 16),
                                    const SizedBox(width: 8),
                                    Text(
                                      'PCPEPSDB2 (May 13 08:19:01)',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red.shade700,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.only(left: 24),
                                  child: Text(
                                    'abrt-dump-journal-core[260290]: Failed to save detect problem data in abrt database',
                                    style: TextStyle(
                                      color: Colors.red.shade800,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Database Replication - UPDATED: Now in a vertical arrangement
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.storage, color: Colors.blue.shade700, size: 18),
                    const SizedBox(width: 8),
                    const Text(
                      'Database Replication',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Thread 1
                _buildReplicationThreadItem('Thread 1', '2', 'Last applied on 13-05-2025 12:32:02'),

                const Divider(height: 16),

                // Thread 2
                _buildReplicationThreadItem('Thread 2', '2', 'Last applied on 13-05-2025 12:31:44'),

                const Divider(height: 16),

                // Thread 3
                _buildReplicationThreadItem('Thread 3', '2', ''),

                const Divider(height: 16),

                // Thread 4
                _buildReplicationThreadItem('Thread 4', '2', ''),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // PDF Replication - UPDATED: Now below Database Replication
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.picture_as_pdf, color: Colors.blue.shade700, size: 18),
                    const SizedBox(width: 8),
                    const Text(
                      'PDF Replication',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Upload Utilities
                _buildPdfReplicationItem(
                  'LEASE-UPLOAD-UTILITY',
                  'Synced',
                  'Updated on 2025-05-13',
                  Colors.green,
                ),

                const Divider(height: 16),

                _buildPdfReplicationItem(
                  'UTILITY-PDFDOCS-NEW',
                  'Synced',
                  'Updated on 2025-05-13',
                  Colors.green,
                ),

                const Divider(height: 16),

                _buildPdfReplicationItem(
                  'NDB-UPLOAD-FILES-NEW',
                  'Syncing(57%)',
                  'Updated on 2025-05-13',
                  Colors.orange,
                ),

                const Divider(height: 16),

                _buildPdfReplicationItem(
                  'WEB-UPLOAD-UTILITY',
                  'Synced',
                  'Updated on 2025-05-13',
                  Colors.green,
                ),

                const Divider(height: 16),

                _buildPdfReplicationItem(
                  'SUPPLY-UPLOAD-NEW-UTILITY',
                  'Syncing(0%)',
                  'Updated on 2025-05-13',
                  Colors.amber,
                ),

                const Divider(height: 16),

                _buildPdfReplicationItem(
                  'WORKS-UPLOAD-NEW-UTILITY',
                  'Synced',
                  'Updated on 2025-05-13',
                  Colors.green,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWebServerStatus(String name, String value, String updateTime) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.green.shade700,
                  fontSize: 11,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Updated on ${updateTime.split('_')[0].replaceAll('-', '/')}',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReplicationThreadItem(String threadName, String threadCount, String lastApplied) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Limit the width of the thread name
            Expanded(
              flex: 3,
              child: Text(
                threadName,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            const SizedBox(width: 4), // Add some spacing
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                threadCount,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.green.shade800,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        if (lastApplied.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4, right: 4),
            child: Text(
              lastApplied,
              style: TextStyle(
                fontSize: 10, // Reduced from 11
                color: Colors.grey.shade600,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1, // Enforce single line
            ),
          ),
      ],
    );
  }


  Widget _buildPdfReplicationItem(String name, String status, String updateTime, Color statusColor) {
    return Column(  // Changed from Row to Column
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Limit the width of the name
            Expanded(
              flex: 2,
              child: Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: Colors.grey.shade800,
                ),
                overflow: TextOverflow.ellipsis,  // Add ellipsis for long text
              ),
            ),
            const SizedBox(width: 8),
            // Status indicator
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: statusColor.withOpacity(0.3)),
              ),
              child: Text(
                status,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        // Timestamp on a new line
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            updateTime,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildActiveServicesSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Active Services',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildServiceItem('Email Services', true, '10:45 AM'),
            const Divider(),
            _buildServiceItem('SMS Services', true, '10:45 AM'),
            const Divider(),
            _buildServiceItem('Payment Gateway', false, '04:45 AM', isWarning: true), // 6 hours ago
            const Divider(),
            _buildServiceItem('DR data Sync', false, '10:45 PM', timePrefix: 'May 12, 2025, ', isWarning: true), // 12 hours ago
            const Divider(),
            _buildServiceItem('PKI Services', true, '10:45 AM'),
            const Divider(),
            _buildServiceItem('GST Services', true, '10:45 AM'),
            const Divider(),
            _buildServiceItem('Document Upload', true, '10:45 AM'),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem(String service, bool isActive, String time, {String timePrefix = 'May 13, 2025, ', bool isWarning = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: service == 'Email Services' ? () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EmailServicesDetailView(),
            ),
          );
        } : null,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: service == 'Email Services' ? BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.blue.shade50.withOpacity(0.3),
          ) : null,
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: isWarning ? Colors.orange : (isActive ? Colors.green : Colors.red),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          service,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: service == 'Email Services' ? Colors.blue.shade700 : null,
                          ),
                        ),
                        if (service == 'Email Services') ...[
                          const SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Colors.blue.shade700,
                          ),
                        ],
                      ],
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        children: [
                          TextSpan(text: 'Last updated: $timePrefix'),
                          TextSpan(
                            text: time,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (!isWarning)
                Icon(
                  isActive ? Icons.check_circle : Icons.error,
                  color: isActive ? Colors.green : Colors.red,
                  size: 20,
                )
              else
                Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildErrorRateSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Error/Exception Rate',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: Placeholder(
                fallbackHeight: 200,
                color: Colors.grey.withOpacity(0.3),
                child: const Center(
                  child: Text('Error Rate Chart will be displayed here'),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildErrorItem('API Timeout', 'Payment Gateway', 3, '11:25 AM'),
                _buildErrorItem('Authentication Failed', 'User Login', 2, '10:40 AM'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorItem(String error, String source, int count, String time) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      color: Colors.red.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.red),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    error,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Source: $source',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$count occurrences',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ),
                Text(
                  'First seen: $time',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertsView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Threshold Alerts & Resilience Indicators'),
            const SizedBox(height: 16),
            _buildAlertsList(),
            const SizedBox(height: 24),
            _buildSLABreachesSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertsList() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Active Alerts',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DropdownButton<String>(
                  value: 'All Alerts',
                  onChanged: (String? newValue) {},
                  items: <String>['All Alerts', 'Critical', 'Warning', 'Info']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  underline: Container(height: 0),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildAlertItem(
              'Critical',
              'Payment Transactions Drop',
              'Payment transactions decreased by 35% in the last hour',
              '12:30 PM',
            ),
            const Divider(),
            _buildAlertItem(
              'Warning',
              'Slow Response Time',
              'Average response time increased to 450ms',
              '11:15 AM',
            ),
            const Divider(),
            _buildAlertItem(
              'Info',
              'Integration Sync Completed',
              'Full data sync with Finance System completed successfully',
              '10:05 AM',
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildAlertItem(String severity, String title, String description, String time) {
    Color severityColor = severity == 'Critical'
        ? Colors.red
        : severity == 'Warning'
        ? Colors.orange
        : Colors.blue;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: severityColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text('Details'),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        foregroundColor: Colors.green,
                      ),
                      child: const Text('Acknowledge'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSLABreachesSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tender Processing SLA Breaches',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 24,
                dataRowHeight: 60,
                columns: const [
                  DataColumn(label: Text('Tender ID', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Stage', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('SLA', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Current', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                ],
                rows: [
                  _buildSLARow('TEN-2025-05-1120', 'Evaluation', '48h', '56h', Colors.red),
                  _buildSLARow('TEN-2025-05-1098', 'Approval', '24h', '30h', Colors.red),
                  _buildSLARow('TEN-2025-05-1076', 'Documentation', '72h', '70h', Colors.green),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildSLARow(String tenderId, String stage, String sla, String current, Color statusColor) {
    return DataRow(
      cells: [
        DataCell(Text(tenderId, style: const TextStyle(fontWeight: FontWeight.w500))),
        DataCell(Text(stage)),
        DataCell(Text(sla)),
        DataCell(Text(current)),
        DataCell(
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                statusColor == Colors.green ? 'Within SLA' : 'Breached',
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHelpView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Help & Documentation',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildHelpCard(
              'Understanding the Dashboard',
              'Learn how to interpret dashboard metrics and indicators',
              Icons.dashboard_outlined,
            ),
            _buildHelpCard(
              'System Integration Guide',
              'Documentation on integration points and troubleshooting',
              Icons.sync_outlined,
            ),
            _buildHelpCard(
              'Alert Management',
              'How to handle alerts and configure notification settings',
              Icons.notifications_outlined,
            ),
            _buildHelpCard(
              'Server Monitoring',
              'Best practices for monitoring server health',
              Icons.storage_outlined,
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Need Assistance?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.contact_support_outlined),
                      title: const Text('Contact Support'),
                      subtitle: const Text('Get help from our technical team'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.video_library_outlined),
                      title: const Text('Video Tutorials'),
                      subtitle: const Text('Step-by-step visual guides'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.forum_outlined),
                      title: const Text('Community Forum'),
                      subtitle: const Text('Connect with other users'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpCard(String title, String description, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: Colors.blue.withOpacity(0.1),
          child: Icon(icon, color: Colors.blue),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(description),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}