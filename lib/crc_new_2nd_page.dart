import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRC Summary Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue.shade800,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const CRCSummaryPage(),
    );
  }
}

class CRCSummaryPage extends StatefulWidget {
  const CRCSummaryPage({super.key});

  @override
  State<CRCSummaryPage> createState() => _CRCSummaryPageState();
}

class _CRCSummaryPageState extends State<CRCSummaryPage> {
  bool _isGrandTotalExpanded = false;

  // Sample data for multiple cards (you can add as many as needed)
  final List<Map<String, dynamic>> cardsData = const [
    {
      'railway': 'IREPS',
      'unitType': 'Zonal HQ / PU HQ',
      'unitName': 'EPS/UD',
      'department': 'Mechanical',
      'consignee': '36640-SSE/EPS/UD',
      'openingBalance': 175,
      'newConsignments': 2,
      'issuedCRNs': 1,
      'closingBalance': 176,
      'lessThan7Days': 0,
      'days7to15': 2,
      'days15to30': 0,
      'moreThan30Days': 174,
    },
    {
      'railway': 'IREPS',
      'unitType': 'Zonal HQ / PU HQ',
      'unitName': 'EPS/UD',
      'department': 'Mechanical',
      'consignee': '36640-SSE/EPS/UD',
      'openingBalance': 180,
      'newConsignments': 3,
      'issuedCRNs': 2,
      'closingBalance': 181,
      'lessThan7Days': 1,
      'days7to15': 3,
      'days15to30': 2,
      'moreThan30Days': 175,
    },
    // Add more cards as needed...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'CRC Summary',
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
            'Summary of Digitally-signed CRNs for Non-Stock Items supplied by vendors from 09-03-2025 to 09-06-2025',
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
    int totalOpeningBalance = cardsData.fold(0, (sum, card) => sum + (card['openingBalance'] as int));
    int totalNewConsignments = cardsData.fold(0, (sum, card) => sum + (card['newConsignments'] as int));
    int totalIssuedCRNs = cardsData.fold(0, (sum, card) => sum + (card['issuedCRNs'] as int));
    int totalClosingBalance = cardsData.fold(0, (sum, card) => sum + (card['closingBalance'] as int));

    int totalLessThan7Days = cardsData.fold(0, (sum, card) => sum + (card['lessThan7Days'] as int));
    int totalDays7to15 = cardsData.fold(0, (sum, card) => sum + (card['days7to15'] as int));
    int totalDays15to30 = cardsData.fold(0, (sum, card) => sum + (card['days15to30'] as int));
    int totalMoreThan30Days = cardsData.fold(0, (sum, card) => sum + (card['moreThan30Days'] as int));

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
                      'Grand Total Summary (${cardsData.length} Cards)',
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
                  // Total CRC Data
                  _buildDataRow('Opening Balance(Consignments where Digitally-Signed CRN pending)', totalOpeningBalance.toString(), isGrandTotal: true),
                  _buildDataRow('New Consignments Received', totalNewConsignments.toString(), isGrandTotal: true),
                  _buildDataRow('Consignments where Digitally-Signed CRNs issued', totalIssuedCRNs.toString(), isGrandTotal: true),
                  _buildDataRow('Closing Balance(Consignments where Digitally-Signed CRN pending)', totalClosingBalance.toString(), isGrandTotal: true),

                  const SizedBox(height: 20),

                  Text(
                    'Break-up of Pending Digitally-Signed CRNs (Total)',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.green.shade700,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Break-up cards in 2x2 grid
                  _buildBreakupCardsGrid([
                    {'label': '<7 Days', 'value': totalLessThan7Days, 'color': Colors.green},
                    {'label': '7 to 15 Days', 'value': totalDays7to15, 'color': Colors.orange},
                    {'label': '15 to 30 Days', 'value': totalDays15to30, 'color': Colors.red},
                    {'label': '>30 Days', 'value': totalMoreThan30Days, 'color': Colors.deepPurple},
                  ], isGrandTotal: true),
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
      padding: const EdgeInsets.all(16),
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
          const SizedBox(height: 16),

          // Railway and Unit Name Information in one line
          _buildRailwayUnitRow(data['railway'], data['unitName']),
          // Unit Type and Department together in one line
          _buildUnitTypeDepartmentRow(data['unitType'], data['department']),
          _buildInfoRow('Consignee & Sub-Consignee', data['consignee']),
          const SizedBox(height: 16),

          // CRC Data
          _buildDataRow('Opening Balance(Consignments where Digitally-Signed CRN pending)', data['openingBalance'].toString()),
          _buildDataRow('New Consignments Received', data['newConsignments'].toString()),
          _buildDataRow('Consignments where Digitally-Signed CRNs issued', data['issuedCRNs'].toString()),
          _buildDataRow('Closing Balance(Consignments where Digitally-Signed CRN pending)', data['closingBalance'].toString()),
          const SizedBox(height: 16),

          // Break-up Section
          Text(
            'Break-up of Pending Digitally-Signed CRNs',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.red.shade600,
            ),
          ),
          const SizedBox(height: 12),

          // Break-up cards in 2x2 grid
          _buildBreakupCardsGrid([
            {'label': '<7 Days', 'value': data['lessThan7Days'], 'color': Colors.green},
            {'label': '7 to 15 Days', 'value': data['days7to15'], 'color': Colors.orange},
            {'label': '15 to 30 Days', 'value': data['days15to30'], 'color': Colors.red},
            {'label': '>30 Days', 'value': data['moreThan30Days'], 'color': Colors.deepPurple},
          ]),
        ],
      ),
    );
  }

  // New method for Railway and Unit Name in one line
  Widget _buildRailwayUnitRow(String railway, String unitName) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Railway label and data
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Railway: ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Expanded(
                  child: Text(
                    railway,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Unit Name label and data
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Unit Name: ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Expanded(
                  child: Text(
                    unitName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // New method for Unit Type and Department in one line
  Widget _buildUnitTypeDepartmentRow(String unitType, String department) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Unit Type label and data
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Unit Type:',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  unitType,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Department label and data
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Department:',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  department,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreakupCardsGrid(List<Map<String, dynamic>> breakupData, {bool isGrandTotal = false}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate card width based on available space
        double cardWidth = (constraints.maxWidth - 12) / 2; // 12 is the spacing between cards
        double cardHeight = cardWidth * 0.4; // Adjust aspect ratio

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: breakupData.map((item) {
            return SizedBox(
              width: cardWidth,
              height: cardHeight,
              child: _buildBreakupCard(
                item['label'] as String,
                item['value'].toString(),
                item['color'] as MaterialColor,
                isGrandTotal: isGrandTotal,
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildBreakupCard(String label, String value, MaterialColor color, {bool isGrandTotal = false}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color.shade700,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 2),
          Flexible(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: color.shade600,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
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
            flex: 3,
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
          const SizedBox(width: 12),
          Expanded(
            flex: 1,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isGrandTotal ? Colors.green.shade800 : Colors.blue.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}