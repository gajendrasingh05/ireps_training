import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Item-List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue.shade800,
        scaffoldBackgroundColor: Colors.grey.shade50,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade800,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const NonMovingItemsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NonMovingItemsPage extends StatefulWidget {
  const NonMovingItemsPage({super.key});

  @override
  State<NonMovingItemsPage> createState() => _NonMovingItemsPageState();
}

class _NonMovingItemsPageState extends State<NonMovingItemsPage> {
  late ScrollController _scrollController;
  final int scrollItemCount = 5; // Number of items to scroll per button press
  final double itemHeight = 200.0; // Approximate height of each item card
  bool _isScrolling = false;

  List<InventoryItem> get items => [
    InventoryItem(
      id: 1,
      department: 'Mechanical',
      railway: 'IREPS-TESTING',
      userDepot: 'SSE/EPS/UD',
      consigneeCode: '36640',
      plNo: '000200010013',
      ledgerName: '021-Test Ledger 27',
      itemCategory: '10-ORDINARY NEW STORES',
      itemDescription: 'Test Folio : Tender Axle Boxes and details.',
      rate: 129.65,
      qty: '26 Nos.',
    ),
    InventoryItem(
      id: 2,
      department: 'Mechanical',
      railway: 'IREPS-TESTING',
      userDepot: 'SSE/EPS/UD',
      consigneeCode: '36640',
      plNo: '01070123',
      ledgerName: '001-Consumeble Items1',
      itemCategory: '10-ORDINARY NEW STORES',
      itemDescription: 'Liquid Soap : TEST/2007',
      rate: 0,
      qty: '25 Nos.',
    ),
    InventoryItem(
      id: 3,
      department: 'Electrical',
      railway: 'IREPS-TESTING',
      userDepot: 'SSE/ELE/UD',
      consigneeCode: '36641',
      plNo: '000300015024',
      ledgerName: '030-Electrical Components',
      itemCategory: '15-ELECTRICAL ITEMS',
      itemDescription: 'LED Light Assembly for Coach Lighting System',
      rate: 245.80,
      qty: '50 Nos.',
    ),
    InventoryItem(
      id: 4,
      department: 'Civil',
      railway: 'IREPS-TESTING',
      userDepot: 'SSE/CIV/UD',
      consigneeCode: '36645',
      plNo: '000400020035',
      ledgerName: '040-Civil Construction Materials',
      itemCategory: '20-CONSTRUCTION MATERIALS',
      itemDescription: 'Concrete Mix for Platform Construction - Grade M25',
      rate: 3500.00,
      qty: '100 Cum.',
    ),
    InventoryItem(
      id: 5,
      department: 'Signal & Telecom',
      railway: 'IREPS-TESTING',
      userDepot: 'SSE/SIG/UD',
      consigneeCode: '36640',
      plNo: '000500025046',
      ledgerName: '050-Signal Equipment',
      itemCategory: '25-SIGNAL & TELECOM',
      itemDescription: 'Digital Signal Controller Unit with Remote Monitoring',
      rate: 15750.25,
      qty: '12 Sets',
    ),
    InventoryItem(
      id: 6,
      department: 'Mechanical',
      railway: 'IREPS-TESTING',
      userDepot: 'SSE/EPS/UD',
      consigneeCode: '36640',
      plNo: '000600030057',
      ledgerName: '060-Safety Equipment',
      itemCategory: '30-SAFETY ITEMS',
      itemDescription: 'Fire Extinguisher - ABC Type 9 Kg Capacity',
      rate: 1850.00,
      qty: '35 Nos.',
    ),
    InventoryItem(
      id: 7,
      department: 'Stores',
      railway: 'IREPS-TESTING',
      userDepot: 'SSE/STO/UD',
      consigneeCode: '36607',
      plNo: '000700035068',
      ledgerName: '070-Office Supplies',
      itemCategory: '35-GENERAL STORES',
      itemDescription: 'A4 Size Paper Ream - 80 GSM White Printing Paper',
      rate: 285.50,
      qty: '200 Reams',
    ),
    InventoryItem(
      id: 8,
      department: 'Mechanical',
      railway: 'IREPS-TESTING',
      userDepot: 'SSE/LOC/UD',
      consigneeCode: '36608',
      plNo: '000800040071',
      ledgerName: '080-Locomotive Spares',
      itemCategory: '40-LOCOMOTIVE PARTS',
      itemDescription: 'Traction Motor Bearing Assembly for WAP-7 Locomotive',
      rate: 45780.75,
      qty: '8 Sets',
    ),
    InventoryItem(
      id: 9,
      department: 'Civil',
      railway: 'IREPS-TESTING',
      userDepot: 'SSE/PER/UD',
      consigneeCode: '36609',
      plNo: '000900045082',
      ledgerName: '090-Track Materials',
      itemDescription: 'Rail 52 Kg/m UIC-54 Standard Length 13m for Main Line',
      itemCategory: '45-TRACK COMPONENTS',
      rate: 89500.00,
      qty: '120 Rails',
    ),
    InventoryItem(
      id: 10,
      department: 'Electrical',
      railway: 'IREPS-TESTING',
      userDepot: 'SSE/TRD/UD',
      consigneeCode: '36610',
      plNo: '001000050093',
      ledgerName: '100-Overhead Equipment',
      itemCategory: '50-OHE MATERIALS',
      itemDescription: 'Catenary Wire ACSR 150 sq.mm for 25KV AC Traction',
      rate: 1250.00,
      qty: '5000 Mtr',
    ),
    InventoryItem(
      id: 11,
      department: 'Signal & Telecom',
      railway: 'IREPS-TESTING',
      userDepot: 'SSE/SIG/UD',
      consigneeCode: '36611',
      plNo: '001100055104',
      ledgerName: '110-Interlocking Equipment',
      itemCategory: '55-SIGNALING SYSTEMS',
      itemDescription: 'Electronic Interlocking PI Type with Route Relay',
      rate: 125750.50,
      qty: '2 Sets',
    ),
    InventoryItem(
      id: 12,
      department: 'Mechanical',
      railway: 'IREPS-TESTING',
      userDepot: 'SSE/CAR/UD',
      consigneeCode: '36612',
      plNo: '001200060115',
      ledgerName: '120-Coach Components',
      itemCategory: '60-COACH PARTS',
      itemDescription: 'FIAT Bogie Frame Assembly for LHB Coach',
      rate: 285000.00,
      qty: '4 Sets',
    ),
    InventoryItem(
      id: 13,
      department: 'Stores',
      railway: 'IREPS-TESTING',
      userDepot: 'SSE/STO/UD',
      consigneeCode: '36613',
      plNo: '001300065126',
      ledgerName: '130-Safety Items',
      itemCategory: '65-SAFETY EQUIPMENT',
      itemDescription: 'Detonators Railway Grade A for Fog Signal Protection',
      rate: 45.25,
      qty: '1000 Nos.',
    ),
    InventoryItem(
      id: 14,
      department: 'Civil',
      railway: 'IREPS-TESTING',
      userDepot: 'SSE/BRI/UD',
      consigneeCode: '36614',
      plNo: '001400070137',
      ledgerName: '140-Bridge Materials',
      itemCategory: '70-BRIDGE COMPONENTS',
      itemDescription: 'Prestressed Concrete Sleeper Type PSC-12 for BG Track',
      rate: 2850.00,
      qty: '500 Nos.',
    ),
    InventoryItem(
      id: 15,
      department: 'Electrical',
      railway: 'IREPS-TESTING',
      userDepot: 'SSE/TRS/UD',
      consigneeCode: '36615',
      plNo: '001500075148',
      ledgerName: '150-Substation Equipment',
      itemCategory: '75-POWER SUPPLY',
      itemDescription: '25KV/400V Station Transformer 2500 KVA for TSS',
      rate: 1850000.00,
      qty: '1 No.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // Add listener to rebuild when scroll position changes
    _scrollController.addListener(() {
      if (!_isScrolling) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalValue = 589693840.52;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Item List',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    icon: Icons.inventory_2,
                    title: 'Total Items',
                    value: '${items.length}',
                    subtitle: 'records found',
                    iconColor: Colors.blue.shade700,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildSummaryCard(
                    icon: Icons.currency_rupee,
                    title: 'Total Value (Rs.)',
                    value: totalValue.toStringAsFixed(2),
                    subtitle: '',
                    iconColor: Colors.blue.shade700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  child: InventoryItemCard(
                    item: items[index],
                    index: index + 1,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButtons(),
    );
  }

  Widget _buildFloatingActionButtons() {
    final List<Widget> buttons = [];

    // Previous Button (only show if not at top)
    if (_canScrollUp()) {
      buttons.add(
        FloatingActionButton(
          heroTag: "previous",
          onPressed: _scrollUp,
          backgroundColor: Colors.blue.shade50,
          foregroundColor: Colors.blue.shade700,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.keyboard_arrow_up),
        ),
      );
      buttons.add(const SizedBox(height: 12));
    }

    // Summary Button (always visible)
    buttons.add(
      FloatingActionButton(
        heroTag: "summary",
        onPressed: () => _showSummaryDialog(),
        backgroundColor: Colors.blue.shade50,
        foregroundColor: Colors.blue.shade700,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.analytics_outlined),
            Text(
              "Summary",
              style: TextStyle(color: Colors.blue.shade800, fontSize: 8),
            ),
          ],
        ),
      ),
    );

    // Next Button (only show if not at bottom)
    if (_canScrollDown()) {
      buttons.add(const SizedBox(height: 12));
      buttons.add(
        FloatingActionButton(
          heroTag: "next",
          onPressed: _scrollDown,
          backgroundColor: Colors.blue.shade50,
          foregroundColor: Colors.blue.shade700,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.keyboard_arrow_down),
        ),
      );
    }

    return Column(mainAxisSize: MainAxisSize.min, children: buttons);
  }

  bool _canScrollUp() {
    return _scrollController.hasClients && _scrollController.offset > 10;
  }

  bool _canScrollDown() {
    if (!_scrollController.hasClients) return true;
    return _scrollController.offset <
        (_scrollController.position.maxScrollExtent - 10);
  }

  void _scrollUp() {
    final double scrollDistance = scrollItemCount * itemHeight;
    final double targetOffset = (_scrollController.offset - scrollDistance)
        .clamp(0.0, double.infinity);

    _isScrolling = true;
    _scrollController
        .animateTo(
          targetOffset,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        )
        .then((_) {
          _isScrolling = false;
          setState(() {});
        });
  }

  void _scrollDown() {
    final double scrollDistance = scrollItemCount * itemHeight;
    final double targetOffset = _scrollController.offset + scrollDistance;

    _isScrolling = true;
    _scrollController
        .animateTo(
          targetOffset,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        )
        .then((_) {
          _isScrolling = false;
          setState(() {});
        });
  }

  void _showSummaryDialog() {
    final String totalValue = '589693840.52';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.grey.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Summary Table Section
                        _buildSummaryTable(),
                        const SizedBox(height: 8),

                        // Grand Total Section
                        _buildAnalysisSection('Total Value', Icons.calculate, [
                          _buildTotalValueRow('Total Value (Rs.)', totalValue),
                        ]),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade50,
                        foregroundColor: Colors.blue.shade900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(12),
                      ),
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnalysisSection(
    String title,
    IconData icon,
    List<Widget> children,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: Colors.blue.shade800),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSummaryTable() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.table_chart, size: 20, color: Colors.blue.shade800),
              const SizedBox(width: 8),
              Text(
                'Summary Statistics',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Header Row
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Total Qty',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Unit',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Total Value (Rs.)',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Data Rows
          _buildTableRow('157.68', 'KM', '4304750.72'),
          _buildTableRow('20471', 'Kgs.', '27596340.97'),
          _buildTableRow('36', 'ML', '1483.20'),
          _buildTableRow('8', 'Set', '1600.00'),
          _buildTableRow('78287.33', 'Nos.', '535840860.67'),
          _buildTableRow('5', 'HDCUM', '10000.00'),
          _buildTableRow('1', 'Grams', '1.00'),
          _buildTableRow('507.8', 'HMTR', '125299.65'),
          _buildTableRow('5', 'KLTR', '117031.40'),
          _buildTableRow('555', 'Gross', '184815.00'),
          _buildTableRow('337.2', 'MTR', '20843532.33'),
          _buildTableRow('28008.4', 'LTR', '668125.58'),
        ],
      ),
    );
  }

  Widget _buildTableRow(String quantity, String unit, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              quantity,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              unit,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.blue.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: Text(
                value.isNotEmpty ? '₹$value' : '',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.green.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalValueRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: Text(
                '₹$value',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Color iconColor,
  }) {
    return Container(
      height: 75,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade100, Colors.blue.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade200.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey.shade700,
                  ),
                ),
                const SizedBox(height: 2),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.blueGrey.shade400,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InventoryItemCard extends StatelessWidget {
  final InventoryItem item;
  final int index;

  const InventoryItemCard({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withValues(alpha: 0.07),
            spreadRadius: 1,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Transform.translate(
                  offset: Offset(0, -20),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Center(
                      child: Text(
                        '$index',
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Consignee Code: ${item.consigneeCode}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Department: ${item.department}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blueGrey.shade700,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Railway: ${item.railway}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blueGrey.shade700,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'User Depot: ${item.userDepot}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blueGrey.shade700,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: Colors.blue.shade200,
                          width: 1,
                        ),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.share,
                          color: Colors.blue.shade700,
                          size: 18,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserDepotDetailsPage(
                              consigneeCode: item.consigneeCode,
                              userDepot: item.userDepot,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: Colors.blue.shade200,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: _buildDetailItem(
                    'PL No./Item Code',
                    item.plNo,
                    Colors.black,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Item Category',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueGrey.shade700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.itemCategory,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.blueGrey.shade700,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: _buildDetailItem(
                    'Rate',
                    '₹${item.rate.toStringAsFixed(2)}',
                    Colors.green.shade700,
                  ),
                ),
                Expanded(
                  child: _buildDetailItem('Quantity', item.qty, Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ledger Name',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueGrey.shade700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.ledgerName,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.blueGrey.shade700,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Item Description',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey.shade700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              item.itemDescription,
              style: TextStyle(
                fontSize: 13,
                color: Colors.blueGrey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, Color valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.blueGrey.shade600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}

class InventoryItem {
  final int id;
  final String department;
  final String railway;
  final String userDepot;
  final String consigneeCode;
  final String plNo;
  final String ledgerName;
  final String itemCategory;
  final String itemDescription;
  final double rate;
  final String qty;

  InventoryItem({
    required this.id,
    required this.department,
    required this.railway,
    required this.userDepot,
    required this.consigneeCode,
    required this.plNo,
    required this.ledgerName,
    required this.itemCategory,
    required this.itemDescription,
    required this.rate,
    required this.qty,
  });
}

class UserDepotDetailsPage extends StatelessWidget {
  final String consigneeCode;
  final String userDepot;

  const UserDepotDetailsPage({
    super.key,
    required this.consigneeCode,
    required this.userDepot,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Depot Details',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // First Card - Consignee Details
            _buildConsigneeCard(),
            const SizedBox(height: 16),

            // Second Card - Overall-in-charge Details
            _buildOverallInChargeCard(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Share functionality
        },
        backgroundColor: Colors.blue.shade50,
        child: Icon(Icons.share, color: Colors.blue.shade800),
      ),
    );
  }

  Widget _buildConsigneeCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IREPS Header with Badge
          Row(
            children: [
              Text(
                'IREPS',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Consignee',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Code',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 18,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      consigneeCode,
                      style: TextStyle(
                        color: Colors.blue.shade800,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 4),

          // Sub-card with contact details
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.pink.shade50,
                      child: Text(
                        'C2',
                        style: TextStyle(
                          color: Colors.pink.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CRIS TEST 2022',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          Text(
                            'Senior System Engineer',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Contact Information and Action Buttons
                Row(
                  children: [
                    // Contact Information Column
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildContactInfo(
                            Icons.email,
                            'cris.test@ireps.gov.in',
                          ),
                          const SizedBox(height: 8),
                          _buildContactInfo(Icons.phone, '+91-9876543210'),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Action Buttons Row
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.blue.shade500,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.person_add,
                                color: Colors.white,
                                size: 20,
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ),
                          const SizedBox(width: 12),
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.green.shade500,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                FontAwesomeIcons.whatsapp,
                                color: Colors.white,
                                size: 20,
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Depot Address
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.blue.shade800,
                            size: 18,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            'Depot Address',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        userDepot,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'IREPS Testing Division, Railway Board\nNew Delhi - 110001, India',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                          height: 1.4,
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
    );
  }

  Widget _buildOverallInChargeCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Red Label
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text(
              'Details of Overall-in-charge',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.blue.shade800,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          // Contact Details
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.red.shade100,
                      child: Text(
                        'ML',
                        style: TextStyle(
                          color: Colors.red.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'MOHAN LAL',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          Text(
                            'Chief Engineer (IREPS)',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Contact Information and Action Buttons
                Row(
                  children: [
                    // Contact Information Column
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildContactInfo(
                            Icons.email,
                            'mohan.lal@ireps.gov.in',
                          ),
                          const SizedBox(height: 8),
                          _buildContactInfo(Icons.phone, '+91-9123456789'),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Action Buttons Row
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.blue.shade500,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.person_add,
                                color: Colors.white,
                                size: 20,
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ),
                          const SizedBox(width: 12),
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.green.shade500,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                FontAwesomeIcons.whatsapp,
                                color: Colors.white,
                                size: 20,
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
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
        ],
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String info) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade600),
        const SizedBox(width: 8),
        Text(info, style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
      ],
    );
  }
}
