import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Depot Module',
      theme: ThemeData(
        primaryColor: const Color(0xFF0D47A1),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        fontFamily: 'Montserrat',
        useMaterial3: true,
      ),
      home: const UDMHomePage(),
    );
  }
}

class UDMHomePage extends StatefulWidget {
  const UDMHomePage({Key? key}) : super(key: key);

  @override
  State<UDMHomePage> createState() => _UDMHomePageState();
}

class _UDMHomePageState extends State<UDMHomePage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  bool _isEnglish = true;
  late AnimationController _animationController;
  late Animation<double> _animation;

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _showSearchResults = false;

  // English and Hindi translations for all menu items
  final Map<String, String> _translations = {
    'Search Item': 'आइटम खोजें',
    'Stock Availability': 'स्टॉक उपलब्धता',
    'Stores Depot': 'स्टोर डिपो',
    'Stock Summary': 'स्टॉक सारांश',
    'Non-Moving Items': 'गैर-चलने वाली वस्तुएं',
    'Value-Wise Stock': 'मूल्य-वार स्टॉक',
    'High Value Items': 'उच्च मूल्य वाली वस्तुएं',
    'Stock Item History': 'स्टॉक आइटम इतिहास',
    'Search PO': 'खरीद आदेश खोजें',
    'Consumption Analysis': 'खपत विश्लेषण',
    'Consumption Summary': 'खपत सारांश',
    'Transactions': 'लेन-देन',
    'On-Line Bill Status': 'ऑनलाइन बिल स्थिति',
    'On-Line Bill Summary': 'ऑनलाइन बिल सारांश',
    'CRN': 'सीआरएन',
    'CRC': 'सीआरसी',
    'NS Demands': 'एनएस मांगें',
    'GeM Order Details': 'जीईएम ऑर्डर विवरण',
    'Inventory Management': 'इन्वेंटरी प्रबंधन',
    'Reports & Transactions': 'रिपोर्ट और लेनदेन',
    'Home': 'होम',
    'Profile': 'प्रोफाइल',
    'Search for items, stocks, orders...': 'आइटम, स्टॉक, ऑर्डर खोजें...',
    'No results found for': 'के लिए कोई परिणाम नहीं मिला',
    'Search Results': 'खोज परिणाम',
  };

  final List<MenuItemData> _inventoryItems = [
    MenuItemData(
      title: 'Search Item',
      icon: Icons.search,
      color: const Color(0xFF4285F4),
      bgColor: const Color(0xFFE8F0FE),
    ),
    MenuItemData(
      title: 'Stock Availability',
      icon: Icons.analytics_outlined,
      color: const Color(0xFF34A853),
      bgColor: const Color(0xFFE6F4EA),
    ),
    MenuItemData(
      title: 'Stores Depot',
      icon: Icons.store,
      color: const Color(0xFF673AB7),
      bgColor: const Color(0xFFF3E5F5),
    ),
    MenuItemData(
      title: 'Stock Summary',
      icon: Icons.bar_chart,
      color: const Color(0xFF009688),
      bgColor: const Color(0xFFE0F2F1),
    ),
    MenuItemData(
      title: 'Non-Moving Items',
      icon: Icons.inventory_2,
      color: const Color(0xFFFF6D00),
      bgColor: const Color(0xFFFFF3E0),
    ),
    MenuItemData(
      title: 'Value-Wise Stock',
      icon: Icons.trending_up,
      color: const Color(0xFF4CAF50),
      bgColor: const Color(0xFFE8F5E9),
    ),
    MenuItemData(
      title: 'High Value Items',
      icon: Icons.attach_money,
      color: const Color(0xFFFFB300),
      bgColor: const Color(0xFFFFF8E1),
    ),
    MenuItemData(
      title: 'Stock Item History',
      icon: Icons.history,
      color: const Color(0xFF43A047),
      bgColor: const Color(0xFFE8F5E9),
    ),
  ];

  final List<MenuItemData> _reportsItems = [
    MenuItemData(
      title: 'Search PO',
      icon: Icons.receipt_long,
      color: const Color(0xFF03A9F4),
      bgColor: const Color(0xFFE1F5FE),
    ),
    MenuItemData(
      title: 'Consumption Analysis',
      icon: Icons.pie_chart,
      color: const Color(0xFF7E57C2),
      bgColor: const Color(0xFFEDE7F6),
    ),
    MenuItemData(
      title: 'Consumption Summary',
      icon: Icons.assessment,
      color: const Color(0xFF00ACC1),
      bgColor: const Color(0xFFE0F7FA),
    ),
    MenuItemData(
      title: 'Transactions',
      icon: Icons.swap_horiz,
      color: const Color(0xFFEC407A),
      bgColor: const Color(0xFFFCE4EC),
    ),
    MenuItemData(
      title: 'On-Line Bill Status',
      icon: Icons.receipt,
      color: const Color(0xFF3949AB),
      bgColor: const Color(0xFFE8EAF6),
    ),
    MenuItemData(
      title: 'On-Line Bill Summary',
      icon: Icons.description,
      color: const Color(0xFF5E35B1),
      bgColor: const Color(0xFFEDE7F6),
    ),
    MenuItemData(
      title: 'CRN',
      icon: Icons.assignment,
      color: const Color(0xFFE53935),
      bgColor: const Color(0xFFFFEBEE),
    ),
    MenuItemData(
      title: 'CRC',
      icon: Icons.category,
      color: const Color(0xFF039BE5),
      bgColor: const Color(0xFFE1F5FE),
    ),
    MenuItemData(
      title: 'NS Demands',
      icon: Icons.assignment_turned_in,
      color: const Color(0xFF455A64),
      bgColor: const Color(0xFFECEFF1),
    ),
    MenuItemData(
      title: 'GeM Order Details',
      icon: Icons.shopping_bag,
      color: const Color(0xFF212121),
      bgColor: const Color(0xFFF5F5F5),
    ),
  ];

  List<MenuItemData> get _allItems => [..._inventoryItems, ..._reportsItems];

  List<MenuItemData> get _filteredItems {
    if (_searchQuery.isEmpty) {
      return [];
    }

    final query = _searchQuery.toLowerCase();
    return _allItems.where((item) =>
    item.title.toLowerCase().contains(query) ||
        _translations[item.title]!.toLowerCase().contains(query)
    ).toList();
  }

  // Helper method to get translated text
  String _translate(String text) {
    return _isEnglish ? text : _translations[text] ?? text;
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
      _showSearchResults = _searchQuery.isNotEmpty;
    });
  }

  void _toggleLanguage() {
    setState(() {
      _isEnglish = !_isEnglish;
      if (_isEnglish) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _showSearchResults = false;
    });
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            Expanded(
              child: _showSearchResults
                  ? _buildSearchResults()
                  : _buildMainContent(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildMainContent() {
    return ListView(
      padding: const EdgeInsets.only(bottom: 16),
      children: [
        _buildCategorySection(
          _translate('Inventory Management'),
          _inventoryItems,
          Colors.blue.shade700,
        ),
        const SizedBox(height: 24),
        _buildCategorySection(
          _translate('Reports & Transactions'),
          _reportsItems,
          Colors.deepPurple.shade700,
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    final results = _filteredItems;

    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              _isEnglish
                  ? '${_translate("No results found for")} "$_searchQuery"'
                  : '"$_searchQuery" ${_translate("No results found for")}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            '${_translate("Search Results")} (${results.length})',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D47A1),
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: results.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final item = results[index];
              return ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: item.bgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    item.icon,
                    color: item.color,
                  ),
                ),
                title: Text(
                  _translate(item.title),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  _clearSearch();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${_translate(item.title)} ${_isEnglish ? 'selected' : 'चुना गया'}'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.grid_view_rounded,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                'User Depot Module',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: _toggleLanguage,
            child: Container(
              width: 60,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF4285F4),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    left: _isEnglish ? 5 : null,
                    right: _isEnglish ? null : 5,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          _isEnglish ? 'A' : 'अ',
                          style: TextStyle(
                            color: const Color(0xFF1A73E8),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: _translate('Search for items, stocks, orders...'),
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: const Icon(Icons.search, color: Color(0xFF0D47A1)),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.clear, color: Color(0xFF0D47A1)),
            onPressed: _clearSearch,
          )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
            _showSearchResults = _searchQuery.isNotEmpty;
          });
        },
        onFieldSubmitted: (value) {
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }

  Widget _buildCategorySection(String title, List<MenuItemData> items, Color accentColor) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.9,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return _buildMenuCard(item);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(MenuItemData item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${_translate(item.title)} ${_isEnglish ? 'selected' : 'चुना गया'}'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: item.bgColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    item.icon,
                    color: item.color,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _translate(item.title),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF0D47A1),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: _translate('Home'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            activeIcon: const Icon(Icons.person),
            label: _translate('Profile'),
          ),
        ],
      ),
    );
  }
}

class MenuItemData {
  final String title;
  final IconData icon;
  final Color color;
  final Color bgColor;

  MenuItemData({
    required this.title,
    required this.icon,
    required this.color,
    required this.bgColor,
  });
}