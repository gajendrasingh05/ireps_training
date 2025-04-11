import 'package:flutter/material.dart';

void main() {
  runApp(const ProcurementApp());
}

class ProcurementApp extends StatelessWidget {
  const ProcurementApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // Removed debug banner
      title: 'Procurement System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const DemandDetailsPage(),
    );
  }
}

class DemandDetailsPage extends StatelessWidget {
  const DemandDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Non-Stock Demand',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.check_circle, color: Colors.green),
            label: const Text(
              'Demand Approved',
              style: TextStyle(color: Colors.green),
            ),
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DemandHeader(),
                  const SizedBox(height: 16),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: constraints.maxWidth),
                    child: const Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        ExpandableCard(title: 'Items & Consignees', child: ItemsConsigneesPanel()),
                        ExpandableCard(title: 'LPR', child: LPRPanel()),
                        ExpandableCard(title: 'Likely Suppliers', child: SuppliersPanel()),
                        ExpandableCard(title: 'Documents', child: DocumentsPanel()),
                        ExpandableCard(title: 'Conditions', child: ConditionsPanel()),
                        ExpandableCard(title: 'Allocation', child: AllocationPanel()),
                        ExpandableCard(title: 'Authentication Details', child: AuthenticationPanel()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ExpandableCard extends StatelessWidget {
  final String title;
  final Widget child;

  const ExpandableCard({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final cardWidth = screenWidth > 1200
            ? 400.0
            : (screenWidth > 800
            ? (screenWidth / 2) - 24
            : screenWidth - 32);

        return SizedBox(
          width: cardWidth,
          child: Card(
            child: ExpansionTile(
              title: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: cardWidth,
                  ),
                  child: child,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
class DemandHeader extends StatefulWidget {
  const DemandHeader({Key? key}) : super(key: key);

  @override
  State<DemandHeader> createState() => _DemandHeaderState();
}

class _DemandHeaderState extends State<DemandHeader> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            SizedBox(
              height: 300,
              child: Card(
                elevation: 2,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  children: [
                    _buildBasicDetails(),
                    _buildFundDetails(),
                    _buildProcurementDetails(),
                    _buildEstimateDetails(),
                    _buildTechnicalDetails(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(5, (index) => _buildPageIndicator(index)),
                const SizedBox(width: 16),

                Text(
                  ' ',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildPageIndicator(int pageIndex) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == pageIndex ? Colors.blue : Colors.grey.shade300,
      ),
    );
  }

  Widget _buildBasicDetails() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Basic Details',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 18),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildHeaderItem('Demand No.', 'IMMSTEST-CRIS-EPS-EPS-24-00005', Icons.comment_bank_sharp),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: _buildHeaderItem('Indentor', 'NAVAL KUMAR GUPTA\nAM/01', Icons.person),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildHeaderItem('Demand Value', 'Rs. 90,000/-\n(Rupees Ninety Thousand Only)', Icons.currency_rupee),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: _buildHeaderItem('Purpose',
                      'S1: Sanctioned Estimate\n'
                          'S2: Sanctioned Estimate\n'
                          'S3: Sanctioned Estimate\n'
                          'S4: Sanctioned Estimate',
                      Icons.description),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFundDetails() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Fund Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildHeaderItem('Fund Availability Year', '2022-2023', Icons.account_balance),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: _buildHeaderItem('Indentor Demand Reference', 'testing1', Icons.bookmark),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildHeaderItem('Whether PAC Case?', 'No', Icons.help_outline),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: _buildHeaderItem('Estimate Date', '30/10/2024', Icons.event),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProcurementDetails() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Procurement Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildHeaderItem('Bill Passing Officer', 'GM/01', Icons.assignment_ind),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: _buildHeaderItem('Procurement Type', 'Purchase Through Stores(IREPS)', Icons.store),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildHeaderItem('Demand Type', 'ICT ITEMS', Icons.category),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: _buildHeaderItem('Mode of Procurement', 'Limited Tender', Icons.shopping_cart),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEstimateDetails() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Estimate Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildHeaderItem('Sanctioned Estimate No.', 'testing2', Icons.receipt),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: _buildHeaderItem('Bill Paying Officer', 'GM/Finance/IMMS', Icons.payments),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildHeaderItem('Estimate Item No.', 'testing3', Icons.list_alt),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: _buildHeaderItem('Purchase Unit', 'HQ - IMMS', Icons.business),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTechnicalDetails() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Technical Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 24),
            _buildHeaderItem('Technical Vetting Required', 'NO', Icons.gavel, showViewButton: true),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderItem(String label, String value, IconData icon, {bool showViewButton = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: Colors.blue),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  fontSize: 14,
                ),
              ),
            ),
            if (showViewButton)
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.visibility, size: 18),
                label: const Text('View'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 26),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
class ItemsConsigneesPanel extends StatelessWidget {
  const ItemsConsigneesPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Group A50001-Software, Hardware and Furniture',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Item Details'),
            Card(
              elevation: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 800),
                  child: _buildItemDetailsTable(),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Consignee Details'),
            Card(
              elevation: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 800),
                  child: _buildConsigneeTable(),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Card(
                elevation: 1,
                child: Container(
                  width: 250,
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                  child: Column(
                    children: [
                      const Text(
                        'Total Value',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Rs. 90,000/-',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '(Inclusive All taxes)',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? Colors.black87,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItemDetailsTable() {
    return DataTable(
      headingRowColor: MaterialStateProperty.all(Colors.grey.shade100),
      columnSpacing: 4,
      horizontalMargin: 8,
      headingRowHeight: 40,
      dataRowHeight: 140,
      columns: const [
        DataColumn(
          label: Text('SN',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
          ),
        ),
        DataColumn(
          label: Text('Item Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
          ),
        ),
        DataColumn(
          label: Text('Total Qty./Rate/Value',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
          ),
        ),
      ],
      rows: [
        DataRow(cells: [
          const DataCell(
              Padding(
                padding: EdgeInsets.only(right: 4),
                child: Text('1.', style: TextStyle(fontSize: 13)),
              )
          ),
          DataCell(
            Container(
              constraints: const BoxConstraints(
                minWidth: 100,
                maxWidth: 250,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow('Code:','57010012010'),
                    const SizedBox(height: 8),
                    _buildDetailRow('Type:', 'Supply'),
                    const SizedBox(height: 8),
                    _buildDetailRow('Description:', 'Computer Hardware'),
                    const SizedBox(height: 8),
                    _buildDetailRow(
                      'Warranty:',
                      '30 month(s) from the date of Supply',
                      valueColor: Colors.red.shade700,
                    ),
                  ],
                ),
              ),
            ),
          ),
          DataCell(
            Container(
              constraints: const BoxConstraints(minWidth: 130),
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildQuantityRow('Total Qty:', '2 Number'),
                    const Padding(
                      padding: EdgeInsets.only(left: 70),
                      child: Text(
                        '(Only Two Number)',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildQuantityRow('Rate:', 'Rs. 45,000/-'),
                    const SizedBox(height: 8),
                    _buildQuantityRow('Value:', 'Rs. 90,000/-'),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ],
    );
  }

  Widget _buildQuantityRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildConsigneeTable() {
    return DataTable(
      headingRowColor: MaterialStateProperty.all(Colors.grey.shade100),
      columnSpacing: 24,
      horizontalMargin: 16,
      columns: const [
        DataColumn(
          label: Text('Consignee',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
          ),
        ),
        DataColumn(
          label: Text('Delivery Reqd. by',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
          ),
        ),
        DataColumn(
          label: Text('Quantity',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
          ),
        ),
        DataColumn(
          label: Text('State',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
          ),
        ),
        DataColumn(
          label: Text('Required at',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
          ),
        ),
        DataColumn(
          label: Text('Address',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
          ),
        ),
      ],
      rows: [
        DataRow(cells: [
          const DataCell(Text(
            'ACCTS-ACCTS-IMMSTEST',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
          )),
          const DataCell(Text('12/11/2024',
              style: TextStyle(fontSize: 13)
          )),
          const DataCell(Text(
            '2 Number',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
          )),
          const DataCell(Text('Andhra Pradesh',
              style: TextStyle(fontSize: 13)
          )),
          const DataCell(Text('NDLS',
              style: TextStyle(fontSize: 13)
          )),
          const DataCell(Text('NEW DELHI',
              style: TextStyle(fontSize: 13)
          )),
        ]),
      ],
    );
  }
}
class LPRPanel extends StatelessWidget {
  const LPRPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 8.0), // Reduced from 12.0
              child: const Text(
                'Last Purchase Details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Card(
              elevation: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width - 32,
                  ),
                  child: _buildLPRTable(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLPRTable() {
    return Theme(
      data: ThemeData(
        dividerTheme: const DividerThemeData(
          space: 3,
        ),
      ),
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(Colors.grey.shade100),
        columnSpacing: 24,
        horizontalMargin: 25,
        dataRowMinHeight: 80, // Reduced from 80
        dataRowMaxHeight: 100, // Reduced from 120
        columns: const [
          DataColumn(
            label: Text('SN',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
            ),
          ),
          DataColumn(
            label: Text('Item Details',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
            ),
          ),
          DataColumn(
            label: Text('Rate Type & Details',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
            ),
          ),
          DataColumn(
            label: Text('     Firm',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
            ),
          ),
          DataColumn(
            label: Text('All Incl. Rate',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
            ),
          ),
        ],
        rows: [
          DataRow(cells: [
            const DataCell(
              Text('1',
                  style: TextStyle(fontSize: 13)
              ),
            ),
            DataCell(
              Container(
                constraints: const BoxConstraints(
                  minWidth: 120,
                  maxWidth: 250,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('570100120010',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500
                        )
                    ),
                    SizedBox(height: 4),
                    Text('Computer Hardware',
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey
                        )
                    ),
                  ],
                ),
              ),
            ),
            DataCell(
              Container(
                constraints: const BoxConstraints(
                  minWidth: 160,
                  maxWidth: 200,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center, // Changed from start
                  children: [
                    const Text('LPR(My By: IMMSTEST)',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500
                        )
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.all(6), // Reduced from 8
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Colors.grey.shade200,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('PO No.: gsm-Test',
                              style: TextStyle(fontSize: 13)
                          ),
                          SizedBox(height: 2),
                          Text('dt. 03/04/2024',
                              style: TextStyle(fontSize: 13)
                          ),
                          SizedBox(height: 2),
                          Text('(Non-IMMS PO)',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey
                              )
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            DataCell(
              Container(
                constraints: const BoxConstraints(
                  minWidth: 100,
                  maxWidth: 240,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'TEST BIDDER\n10-ODISHA',
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500
                        )
                    ),
                  ],
                ),
              ),
            ),
            const DataCell(
              Text('Rs.500 per Nos.',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500
                  )
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
class SuppliersPanel extends StatelessWidget {
  const SuppliersPanel({Key? key}) : super(key: key);

  Widget _buildDetailRow(String label, String value, {Color? labelColor, Color? valueColor}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: labelColor ?? Colors.grey[600],
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13,
              color: valueColor ?? Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: const Text(
                'Likely Suppliers',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Card(
              elevation: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width - 32,
                  ),
                  child: _buildSuppliersTable(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuppliersTable() {
    return Theme(
      data: ThemeData(
        dividerTheme: const DividerThemeData(
          space: 3,
        ),
      ),
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(Colors.grey.shade100),
        columnSpacing: 24,
        horizontalMargin: 25,
        dataRowMinHeight: 120,
        dataRowMaxHeight: 140,
        columns: const [
          DataColumn(
            label: Text('SN',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
            ),
          ),
          DataColumn(
            label: Text('                         Firm Details',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
            ),
          ),
          DataColumn(
            label: Text('              Category',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
            ),
          ),
        ],
        rows: [
          DataRow(cells: [
            const DataCell(
              Text('1',
                  style: TextStyle(fontSize: 13)
              ),
            ),
            DataCell(
              Container(
                constraints: const BoxConstraints(
                  minWidth: 200,
                  maxWidth: 400,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDetailRow('         Name:', 'TEST BIDDER 10-ODISHA'),
                      const SizedBox(height: 8),
                      _buildDetailRow('         Address:', 'Odisha Odisha, Odisha, India, 221014'),
                      const SizedBox(height: 8),
                      _buildDetailRow('         Mobile:', '+91 9876543216'),
                      const SizedBox(height: 8),
                      _buildDetailRow('         Email:', 'tb11.testbidder@gmail.com'),
                    ],
                  ),
                ),
              ),
            ),
            DataCell(
              Container(
                constraints: const BoxConstraints(
                  minWidth: 120,
                  maxWidth: 300,
                ),
                child: const Text(
                  '      Last Supplier (LPR)',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
class DocumentsPanel extends StatelessWidget {
  const DocumentsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: const Text(
                'Documents',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Card(
              elevation: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width - 32,
                  ),
                  child: _buildDocumentsTable(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentsTable() {
    return Theme(
      data: ThemeData(
        dividerTheme: const DividerThemeData(
          space: 5,
        ),
      ),
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(Colors.grey.shade100),
        columnSpacing: 32,
        horizontalMargin: 25,
        dataRowMinHeight: 52,
        dataRowMaxHeight: 64,
        headingRowHeight: 48,
        columns: const [
          DataColumn(
            label: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Text(
                'SN',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
          ),
          DataColumn(
            label: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Text(
                'Details',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
          ),
          DataColumn(
            label: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Text(
                'File Name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
          ),
        ],
        rows: [
          _buildDocumentRow('1', 'Technical Specification', 'Doc01.pdf', 'S00001'),
          _buildDocumentRow('2', 'Others', 'doc02.pdf', 'OT00001'),
          _buildDocumentRow('3', '', 'Doc03.pdf', 'DP0001'),
          _buildDocumentRow('4', 'Technical Specification', 'doc04.pdf', 'S00002'),
          _buildDocumentRow('5', 'Special Conditions', 'doc05.pdf', 'SPC0001'),
          _buildDocumentRow('6', '', 'doc06.pdf', '1233!@#\$%^()_+[]}{>?'),
          _buildDocumentRow('7', 'Technical Specification', 'doc07.pdf', 'S000003'),
        ],
      ),
    );
  }

  DataRow _buildDocumentRow(String sn, String category, String fileName, String description) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            sn,
            style: const TextStyle(fontSize: 13),
          ),
        ),
        DataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (category.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    category,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  description,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                // Handle document opening
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Text(
                          fileName,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          placeholder: false,
        ),
      ],
    );
  }
}
class ConditionsPanel extends StatelessWidget {
  const ConditionsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width - 32,
                  ),
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(Colors.grey.shade100),
                    columnSpacing: 24,
                    horizontalMargin: 25,
                    columns: const [
                      DataColumn(
                        label: Text('SN',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                      DataColumn(
                        label: Text('Condition Type',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                      DataColumn(
                        label: Text('Template',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                      DataColumn(
                        label: Text('Condition Heading/Description',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                      DataColumn(
                        label: Text('Confirmation Required',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                      DataColumn(
                        label: Text('Remarks Allowed',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                      DataColumn(
                        label: Text('Document Allowed',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                    ],
                    rows: [
                      _buildConditionRow(
                          '1.1',
                          'Scope',
                          'Normal',
                          'Condition Heading::Scope\nCondition Desc::Scope',
                          '   No',
                          '   No',
                          'Not Allowed'
                      ),
                      _buildConditionRow(
                          '1.1/1',
                          'Scope',
                          'Normal',
                          'Child1::Condition Heading::Scope\nCondition Desc::Scope',
                          '   No',
                          '   No',
                          'Not Allowed'
                      ),
                      _buildConditionRow(
                          '1.1/2',
                          'Scope',
                          'Normal',
                          'Child2::Condition Heading::Scope\nCondition Desc::Scope',
                          '   No',
                          '   No',
                          'Not Allowed'
                      ),
                      _buildConditionRow(
                          '2.1',
                          'Checklist',
                          'Normal',
                          'Condition Heading::Checklist\nCondition Desc::Checklist',
                          '   No',
                          '   No',
                          'Not Allowed'
                      ),
                      _buildConditionRow(
                          '2.2',
                          'Commercial Compliance',
                          'Special\n(Bidder to Confirm)',
                          'Condition Heading::Commercial Compliance\nCondition Desc::Commercial Compliance',
                          '   No',
                          '   No',
                          'Not Allowed'
                      ),
                      _buildConditionRow(
                          '2.2/1',
                          'Commercial Compliance',
                          'Normal',
                          'Child01::Condition Heading::Commercial Compliance\nCondition Desc::',
                          '   No',
                          '   No',
                          'Not Allowed'
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildConditionRow(
      String sn,
      String conditionType,
      String template,
      String headingDesc,
      String confirmationRequired,
      String remarksAllowed,
      String documentAllowed,
      ) {
    return DataRow(
      cells: [
        DataCell(Text(sn, style: const TextStyle(fontSize: 13))),
        DataCell(Text(conditionType, style: const TextStyle(fontSize: 13))),
        DataCell(Text(template, style: const TextStyle(fontSize: 13))),
        DataCell(Text(headingDesc, style: const TextStyle(fontSize: 13))),
        DataCell(Text(confirmationRequired, style: const TextStyle(fontSize: 13))),
        DataCell(Text(remarksAllowed, style: const TextStyle(fontSize: 13))),
        DataCell(Text(documentAllowed, style: const TextStyle(fontSize: 13))),
      ],
    );
  }
}
class AllocationPanel extends StatelessWidget {
  const AllocationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width - 32,
                  ),
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(Colors.grey.shade100),
                    columnSpacing: 24,
                    horizontalMargin: 25,
                    columns: const [
                      DataColumn(
                        label: Text('SN',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                      DataColumn(
                        label: Text('Item',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                      DataColumn(
                        label: Text('Consignee',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                      DataColumn(
                        label: Text('Qty',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                      DataColumn(
                        label: Text('Allocation',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                      DataColumn(
                        label: Text('Value (Rs.)',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                    ],
                    rows: [
                      _buildAllocationRow(
                        '1.',
                        '5170100120010- Computer Hardware (@#\$%^&*()_++ - []}{\\/:9<<??',
                        'ACCTS - ADCTS\n(CHS -RLMS TESTING)',
                        '2.0 Number',
                        'EPSW020000\nEPSW020000-Integration of e-tendering in Works Contracts with IPSM',
                        '90,000/-',
                      ),
                      _buildAllocationRow(
                        '',
                        'Input Tax Credit (ITC) Flag: TI-No ITC (Input goods or services used exclusively for non',
                        '',
                        '',
                        '',
                        '',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildAllocationRow(
      String sn,
      String item,
      String consignee,
      String qty,
      String allocation,
      String value,
      ) {
    return DataRow(
      cells: [
        DataCell(Text(sn, style: const TextStyle(fontSize: 13))),
        DataCell(Text(item, style: const TextStyle(fontSize: 13))),
        DataCell(Text(consignee, style: const TextStyle(fontSize: 13))),
        DataCell(Text(qty, style: const TextStyle(fontSize: 13))),
        DataCell(Text(allocation, style: const TextStyle(fontSize: 13))),
        DataCell(Text(value, style: const TextStyle(fontSize: 13))),
      ],
    );
  }
}

class AuthenticationPanel extends StatefulWidget {
  const AuthenticationPanel({super.key});

  @override
  State<AuthenticationPanel> createState() => _AuthenticationPanelState();
}

class _AuthenticationPanelState extends State<AuthenticationPanel> {
  final List<Map<String, String>> authData = [
    {
      'sNo': '1',
      'stage': 'For Fund Certification',
      'timestamp': '08-11-2024 16:50:43',
      'name': 'NAVAL KUMAR GUPTA',
      'designation': 'AM/01',
      'email': 'ameps@gmail.com',
      'forwardedToName': 'GM EPS',
      'forwardedToDesignation': 'GM/01',
      'forwardedToEmail': 'gmeps@gmail.com',
      'remarks': 'Please try to change Demand Type to ICT with Technical Vetting not required.\n\n(Funds Availability of Rs.2,25,000 /- for FY 2022-2023)',
    },
    {
      'sNo': '2',
      'stage': 'For Fund Certification',
      'timestamp': '08-11-2024 16:47:58',
      'name': 'NAVAL KUMAR GUPTA',
      'designation': 'AM/01',
      'email': 'ameps@gmail.com',
      'forwardedToName': 'NAVAL KUMAR GUPTA',
      'forwardedToDesignation': 'AM/01',
      'forwardedToEmail': 'ameps@gmail.com',
      'remarks': 'Forwarded.\n\n(Funds Availability of Rs.2,25,000 /- for FY 2022-2023)',
    },
    {
      'sNo': '3',
      'stage': 'For Fund Certification',
      'timestamp': '04-12-2024 17:37:57',
      'name': 'NAVAL KUMAR GUPTA',
      'designation': 'AM/01',
      'email': 'ameps@gmail.com',
      'forwardedToName': 'GM EPS',
      'forwardedToDesignation': 'GM/01',
      'forwardedToEmail': 'gmeps@gmail.com',
      'remarks': 'Hello Indian Railways E-Procurement System----\n01.Indian Railways E-Procurement System\n02.Indian Railways E-Procurement System\n03.Indian Railways E-Procurement System\n\n(Funds Availability of Rs.2,25,000 /- for FY 2022-2023)',
    },
    {
      'sNo': '4',
      'stage': 'Fund Certification',
      'timestamp': '04-12-2024 17:40:33',
      'name': 'GM EPS',
      'designation': 'GM/01',
      'email': 'gmeps@gmail.com',
      'forwardedToName': 'NAVAL KUMAR GUPTA',
      'forwardedToDesignation': 'AM/01',
      'forwardedToEmail': 'ameps@gmail.com',
      'remarks': 'Hello Indian Railways E-Procurement System====\n01.Indian Railways E-Procurement System\n02.Indian Railways E-Procurement System\n03.Indian Railways E-Procurement System\n\n(Funds Availability of Rs.2,25,000 /- for FY 2022-2023)',
    },
  ];

  void _showRemarksDialog(BuildContext context, String remarks) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Remarks',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  remarks,
                  style: const TextStyle(fontSize: 14),
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
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: MaterialStateProperty.all(Colors.grey.shade50),
            columnSpacing: 28,
            horizontalMargin: 20,
            dataRowHeight: 90,
            headingRowHeight: 56,
            columns: const [
              DataColumn(
                label: Text(
                  'S.No.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Stage/Activity',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Name & Designation',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Forwarded To',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Status',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
            rows: authData.map((data) {
              return DataRow(
                cells: [
                  DataCell(
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        data['sNo']!,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  DataCell(
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data['stage']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            data['timestamp']!,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  DataCell(
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data['name']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            data['designation']!,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            data['email']!,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  DataCell(
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data['forwardedToName']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            data['forwardedToDesignation']!,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            data['forwardedToEmail']!,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  DataCell(
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.verified_rounded,
                                  size: 16,
                                  color: Colors.green.shade700,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Verified',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.green.shade700,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () => _showRemarksDialog(
                              context,
                              data['remarks']!,
                            ),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'View Remarks',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
