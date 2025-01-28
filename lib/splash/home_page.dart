import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class CustomCornerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;
    final radius = 12.0;
    final smallRadius = 4.0; // Small radius for the previously sharp corners

    // Start from top-left with a small curve
    path.moveTo(smallRadius, 0);
    path.quadraticBezierTo(0, 0, 0, smallRadius);

    // Left side
    path.lineTo(0, h - radius);

    // Bottom-left curve (existing)
    path.quadraticBezierTo(0, h, radius, h);

    // Bottom side
    path.lineTo(w - smallRadius, h);

    // Bottom-right with a small curve
    path.quadraticBezierTo(w, h, w, h - smallRadius);

    // Right side
    path.lineTo(w, radius);

    // Top-right curve (existing)
    path.quadraticBezierTo(w, 0, w - radius, 0);

    // Top side
    path.lineTo(smallRadius, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomCornerClipper oldClipper) => false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.lightBlue[800],
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  int _currentIndex = 3;
  int? _hoveredIndex;
  int? _hoveredModuleIndex;
  bool _isTitleHovered = false;

  static final primary = Colors.lightBlue[800]!;
  static const secondary = Color(0xFF0F3773);
  static const accent = Color(0xFFF47852);
  static const textColor = Color(0xFF1a237e);
  static const cardColor1 = Color(0xFFE6E3FF);
  static const cardColor2 = Color(0xFFE8F5E9);
  static const cardColor3 = Color(0xFFFFE0B2);
  static const backgroundLight = Color(0xFFF7F7FD);
  static const dividerColor = Color(0xFFE0E0E0);
  static const darkGreen = Color(0xFF006400);

  Color getDarkerShade(Color color, String route) {
    if (route == '/e-tender/generate-otp' ||
        route == '/e-tender/closing-today' ||
        route == '/e-auction-1/parcel-payment' ||
        route == '/e-tender/ra-live' ||
        route == '/e-auction-1/published-lot' ||
        route == '/e-auction-1/e-sale') {
      return darkGreen;
    }

    HSLColor hsl = HSLColor.fromColor(color);
    return hsl.withLightness((hsl.lightness - 0.5).clamp(0.0, 1.0)).toColor();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _navigateToPage(BuildContext context, String route) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaceholderPage(route: route),
      ),
    );
  }

  PreferredSizeWidget _buildAnimatedAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: () {},
      ),
      title: const Text(
        'IREPS',
        style: TextStyle(
          fontFamily: 'Roboto',
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 22,
          letterSpacing: 1.2,
        ),
      ),
      backgroundColor: primary,
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 5,
          height: 25,
          color: primary,
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primary,
            fontFamily: 'Roboto',
          ),
        ),
      ],
    );
  }

  Widget _buildGridSection(List<GridItem> items, int sectionIndex, {double scale = 1.0}) {
    return GridView.builder(
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 6,
        mainAxisSpacing: 8,
        childAspectRatio: 0.77 * scale,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _buildGridItem(items[index], sectionIndex * 100 + index, scale);
      },
    );
  }

  Widget _buildGridItem(GridItem item, int index, double scale) {
    final titleParts = item.title.split('\n');
    return InkWell(
      onTap: () => _navigateToPage(context, item.route),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipPath(
            clipper: CustomCornerClipper(),
            child: Container(
              width: 55 * scale,
              height: 55 * scale,
              decoration: BoxDecoration(
                color: item.backgroundColor.withOpacity(0.9),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: item.isText
                  ? Center(
                child: Text(
                  item.icon as String,
                  style: TextStyle(
                    color: getDarkerShade(item.backgroundColor, item.route),
                    fontSize: 20 * scale,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
                  : Icon(
                item.icon as IconData,
                color: getDarkerShade(item.backgroundColor, item.route),
                size: 28 * scale,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2 * scale),
            child: Column(
              children: [
                Text(
                  titleParts[0],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 13 * scale,
                    color: textColor,
                    fontWeight: FontWeight.w500,
                    height: 0.9,
                    letterSpacing: -0.2,
                  ),
                ),
                if (titleParts.length > 1) ...[
                  const SizedBox(height: 3),
                  Text(
                    titleParts[1],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 13 * scale,
                      color: textColor,
                      fontWeight: FontWeight.w500,
                      height: 0.9,
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModuleButton(String title, VoidCallback onTap) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFF37E5B), // Changed from primary to orange using the accent color
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Roboto',
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBar _buildAnimatedBottomNav() {
    return BottomNavigationBar(
      elevation: 8,
      type: BottomNavigationBarType.fixed,
      backgroundColor: backgroundLight,
      selectedItemColor: primary,
      unselectedItemColor: textColor.withOpacity(0.6),
      currentIndex: _currentIndex,
      selectedFontSize: 14,
      unselectedFontSize: 14,
      onTap: (index) => setState(() => _currentIndex = index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Login'),
        BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Helpdesk'),
        BottomNavigationBarItem(icon: Icon(Icons.link), label: 'Links'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      appBar: _buildAnimatedAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('E-Tender'),
                  const SizedBox(height: 8),
                  _buildGridSection([
                    GridItem('Custom\nSearch', Icons.tune, cardColor1, '/e-tender/custom-search', true),
                    GridItem('Closing\nToday', Icons.event_available, cardColor2, '/e-tender/closing-today', true),
                    GridItem('Tender\nStatus', Icons.pending_actions, cardColor3, '/e-tender/tender-status', true),
                    GridItem('High Value\nTender', Icons.bar_chart, cardColor1, '/e-tender/high-value', true),
                    GridItem('RA - Live &\nUpcoming', Icons.stream, cardColor2, '/e-tender/ra-live', true),
                    GridItem('RA\nClosed', Icons.lock_clock, cardColor3, '/e-tender/ra-closed', true),
                    GridItem('Search\nPO', Icons.find_in_page, cardColor1, '/e-tender/search-po', true),
                    GridItem('Generate\nOTP', 'OTP', cardColor2, '/e-tender/generate-otp', true, isText: true),
                  ], 0, scale: 0.9),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Divider(color: dividerColor, height: 3.0, thickness: 5.0),
                  ),

                  _buildSectionTitle('E-Auction (Leasing & Sale)'),
                  const SizedBox(height: 8),
                  _buildGridSection([
                    GridItem('Parcel\nPayment', Icons.inventory_2, cardColor2, '/e-auction-1/parcel-payment', true),
                    GridItem('Live\nAuction', Icons.sensors, cardColor3, '/e-auction-1/live', true),
                    GridItem('Upcoming\nAuction', Icons.upcoming, cardColor1, '/e-auction-1/upcoming', true),
                    GridItem('Published\nAuction', Icons.preview, cardColor2, '/e-auction-1/published-lot', true),
                    GridItem('Schedule\nAuction', Icons.event_note, cardColor3, '/e-auction-1/schedules', true),
                    GridItem('Lot\nSearch', Icons.grid_view, cardColor1, '/e-auction-1/lot-search', true),
                    GridItem('E-Sale\nCondition', Icons.document_scanner, cardColor2, '/e-auction-1/e-sale', true),
                    GridItem('Auctioning\nUnits', Icons.device_hub, cardColor3, '/e-auction-1/auction-units', true),
                  ], 1, scale: 0.86),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 80,
            child: Container(
              color: backgroundLight,
            ),
          ),

          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Row(
              children: [
                Expanded(
                  child: _buildModuleButton(
                    'UDM',
                        () => _navigateToPage(context, '/udm'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildModuleButton(
                    'CRIS MMIS',
                        () => _navigateToPage(context, '/cris-mmis'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildAnimatedBottomNav(),
    );
  }
}

class PlaceholderPage extends StatelessWidget {
  final String route;

  const PlaceholderPage({Key? key, required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Page: ${route.split('/').last}',
          style: const TextStyle(
            fontFamily: 'Roboto',
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.lightBlue[800],
      ),
      body: Center(
        child: Text(
          'This is the page for route: $route',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

class GridItem {
  final String title;
  final dynamic icon;
  final Color backgroundColor;
  final String route;
  final bool isMultiLine;
  final bool isText;

  GridItem(this.title, this.icon, this.backgroundColor, this.route, this.isMultiLine, {this.isText = false});
}
