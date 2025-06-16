import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NS Demand Summary Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue.shade800,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const NSDemandSummaryPage(),
    );
  }
}

class NSDemandSummaryPage extends StatefulWidget {
  const NSDemandSummaryPage({super.key});

  @override
  State<NSDemandSummaryPage> createState() => _NSDemandSummaryPageState();
}

class _NSDemandSummaryPageState extends State<NSDemandSummaryPage> {
  bool _isGrandTotalExpanded = false;

  // Data from the NS Demand Summary images
  final List<Map<String, dynamic>> cardsData = const [
    {
      'railway': 'IREPS',
      'unitType': 'Zonal HQ / PU HQ',
      'unitName': 'EPS/UD',
      'department': 'Mechanical',
      'indentingConsignee': '36640/SR. SECTION ENGINEER-I/PS/NEW DELHI',
      'indentorName': 'CRIS TEST 2022-SSE/EPS/UD',
      'total': 6,
      'inDraftStage': 3,
      'underFinanceConcurrence': 0,
      'underFinanceVeting': 0,
      'underProcess': 1,
      'approvedForwardedToPurchase': 1,
      'returnedByPurchaseUnit': 0,
      'dropped': 1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'NS Demand Summary',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, size: 24),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, size: 24),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Main scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title Header
                    _buildTitleHeader(),
                    const SizedBox(height: 30),

                    // Individual Cards
                    ...List.generate(cardsData.length, (index) {
                      return Column(
                        children: [
                          _buildDataCard(index + 1, cardsData[index]),
                          const SizedBox(height: 30),
                        ],
                      );
                    }),

                    // Add some padding at bottom to ensure last card is visible above grand total
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Fixed Grand Total Section at bottom
            _buildGrandTotalSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.shade800.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            'Summary of NS Demand Status from 09-03-2025 to 09-06-2025',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.blue.shade800,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '(Position as on 09-06-2025)',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrandTotalSection() {
    // Calculate grand totals dynamically
    int totalCount = cardsData.fold(0, (sum, card) => sum + (card['total'] as int));
    int totalInDraftStage = cardsData.fold(0, (sum, card) => sum + (card['inDraftStage'] as int));
    int totalUnderFinanceConcurrence = cardsData.fold(0, (sum, card) => sum + (card['underFinanceConcurrence'] as int));
    int totalUnderFinanceVeting = cardsData.fold(0, (sum, card) => sum + (card['underFinanceVeting'] as int));
    int totalUnderProcess = cardsData.fold(0, (sum, card) => sum + (card['underProcess'] as int));
    int totalApprovedForwardedToPurchase = cardsData.fold(0, (sum, card) => sum + (card['approvedForwardedToPurchase'] as int));
    int totalReturnedByPurchaseUnit = cardsData.fold(0, (sum, card) => sum + (card['returnedByPurchaseUnit'] as int));
    int totalDropped = cardsData.fold(0, (sum, card) => sum + (card['dropped'] as int));

    return Container(
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        border: Border(
          top: BorderSide(color: Colors.green.shade200, width: 1),
        ),
      ),
      child: Column(
        children: [
          // Header with arrow
          InkWell(
            onTap: () {
              setState(() {
                _isGrandTotalExpanded = !_isGrandTotalExpanded;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(
                    Icons.assessment,
                    color: Colors.green.shade700,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Grand Total Summary (${cardsData.length} Card)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ),
                  Icon(
                    _isGrandTotalExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: Colors.green.shade700,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),

          // Expandable content
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _isGrandTotalExpanded ? null : 0,
            child: _isGrandTotalExpanded
                ? Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Total NS Demand Data
                  _buildDataRow('Total', totalCount.toString(), isGrandTotal: true),
                  _buildDataRow('In Draft Stage', totalInDraftStage.toString(), isGrandTotal: true),
                  _buildDataRow('Under Finance Concurrence', totalUnderFinanceConcurrence.toString(), isGrandTotal: true),
                  _buildDataRow('Under Finance Veting', totalUnderFinanceVeting.toString(), isGrandTotal: true),
                  _buildDataRow('Under Process', totalUnderProcess.toString(), isGrandTotal: true),
                  _buildDataRow('Approved & Forwarded to Purchase', totalApprovedForwardedToPurchase.toString(), isGrandTotal: true),
                  _buildDataRow('Returned by Purchase Unit', totalReturnedByPurchaseUnit.toString(), isGrandTotal: true),
                  _buildDataRow('Dropped', totalDropped.toString(), isGrandTotal: true),
                ],
              ),
            )
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildDataCard(int cardNumber, Map<String, dynamic> data) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Header
          Text(
            'Card No. $cardNumber',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
          const SizedBox(height: 20),

          // Railway Information
          _buildInfoRow('Railway', data['railway']),
          _buildInfoRow('Unit Type', data['unitType']),
          _buildInfoRow('Unit Name', data['unitName']),
          _buildInfoRow('Department', data['department']),
          _buildInfoRow('Indenting Consignee', data['indentingConsignee']),
          _buildInfoRow('Indentor\'s Name', data['indentorName']),
          const SizedBox(height: 20),

          // NS Demand Status Data
          _buildDataRow('Total', data['total'].toString()),
          _buildDataRow('In Draft Stage', data['inDraftStage'].toString()),
          _buildDataRow('Under Finance Concurrence', data['underFinanceConcurrence'].toString()),
          _buildDataRow('Under Finance Veting', data['underFinanceVeting'].toString()),
          _buildDataRow('Under Process', data['underProcess'].toString()),
          _buildDataRow('Approved & Forwarded to Purchase', data['approvedForwardedToPurchase'].toString()),
          _buildDataRow('Returned by Purchase Unit', data['returnedByPurchaseUnit'].toString()),
          _buildDataRow('Dropped', data['dropped'].toString()),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataRow(String label, String value, {bool isGrandTotal = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: isGrandTotal ? Colors.green.shade700 : Colors.grey[600],
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isGrandTotal ? Colors.green.shade800 : Colors.blue.shade800,
            ),
          ),
        ],
      ),
    );
  }
}