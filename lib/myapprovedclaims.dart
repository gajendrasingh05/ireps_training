import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warranty Claims',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue.shade800,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade800,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const WarrantyClaimsPage(),
    );
  }
}

class WarrantyClaimsPage extends StatelessWidget {
  const WarrantyClaimsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text(
          'My Approved/Dropped Claims',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary Card
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Labels row
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Total Count',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 20,
                      color: Colors.grey.shade300,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    Expanded(
                      child: Text(
                        'Total Value (Rs.)',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Values row
                Row(
                  children: [
                    Expanded(
                      child: const Text(
                        '6',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 30,
                      color: Colors.grey.shade300,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '₹42.8L',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            '4,281,106.00',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade500,
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
          // Claims List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildClaimCard(
                  context,
                  claimNumber: 1,
                  warrantyClaimNo: '36640-24-00185 dt. 29-03-25/',
                  rejectionSupplyRef: '023255-20-01285 dt. 08-03-21',
                  vendorName: 'POWER TECHNOLOGIES CORPORATION-DEHRADUN',
                  poContractNo: '08235684102746 dt. 01-04-24/',
                  challanNo: '39 dt. 05-06-24',
                  itemCode: '560603007551',
                  itemDescription: 'Green aspect main LED signal lighting unit 110 V AC retrofittable in existing CLS housing and co...',
                  rejectedQty: '80 Nos.',
                  rate: '500',
                  value: '40000',
                  status: 'Approved',
                ),
                const SizedBox(height: 12),
                _buildClaimCard(
                  context,
                  claimNumber: 2,
                  warrantyClaimNo: '36640-24-00184 dt. 29-03-25/',
                  rejectionSupplyRef: '095503-20-00092 dt. 08-03-21',
                  vendorName: 'POWER TECHNOLOGIES CORPORATION-DEHRADUN',
                  poContractNo: '08235684102746 dt. 01-04-24/',
                  challanNo: '39 dt. 05-06-24',
                  itemCode: '560603007551',
                  itemDescription: 'Green aspect main LED signal lighting unit 110 V AC retrofittable in existing CLS housing and co...',
                  rejectedQty: '100 Nos.',
                  rate: '500',
                  value: '50000',
                  status: 'Rejected',
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClaimCard(
      BuildContext context, {
        required int claimNumber,
        required String warrantyClaimNo,
        required String rejectionSupplyRef,
        required String vendorName,
        required String poContractNo,
        required String challanNo,
        required String itemCode,
        required String itemDescription,
        required String rejectedQty,
        required String rate,
        required String value,
        required String status,
      }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Claim Number Badge
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blue.shade800,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Center(
              child: Text(
                '$claimNumber',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Warranty Claim No & Rejection/Supply Ref
                _buildInfoSection(
                  'Warranty Claim No. & Rejection/Supply Ref',
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        warrantyClaimNo,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        rejectionSupplyRef,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2196F3),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Vendor Name
                _buildInfoSection(
                  'Vendor Name',
                  Text(
                    vendorName,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF2196F3),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // PO-Contract No & Date/Challan No & Date
                _buildInfoSection(
                  'PO-Contract No. & Date/Challan No. & Date',
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                      children: [
                        TextSpan(text: poContractNo),
                        TextSpan(
                          text: challanNo,
                          style: TextStyle(
                            color: Colors.blue.shade800,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Item Description
                _buildInfoSection(
                  'Item Description',
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$itemCode :',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                          children: [
                            TextSpan(text: itemDescription),
                            const TextSpan(
                              text: 'More',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Bottom Info Section with Modern Cards
                Column(
                  children: [
                    // Info Cards Row
                    Row(
                      children: [
                        Expanded(
                          child: _buildModernInfoCard(
                            'Rejected Qty',
                            rejectedQty,
                            Icons.inventory_2_outlined,
                            Colors.orange.shade600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildModernInfoCard(
                            'Rate (Rs.)',
                            rate,
                            Icons.currency_rupee,
                            Colors.indigo.shade600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Value and Status Row
                    Row(
                      children: [
                        Expanded(
                          child: _buildModernInfoCard(
                            'Value (Rs.)',
                            value,
                            Icons.account_balance_wallet_outlined,
                            Colors.teal.shade600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: (status == 'Approved'
                                    ? Colors.green.shade600
                                    : Colors.red.shade600).withOpacity(0.3),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: (status == 'Approved'
                                      ? Colors.green.shade600
                                      : Colors.red.shade600).withOpacity(0.1),
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Status',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: status == 'Approved'
                                        ? Colors.green.withOpacity(0.1)
                                        : Colors.red.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        status == 'Approved'
                                            ? Icons.check_circle_outline
                                            : Icons.cancel_outlined,
                                        color: status == 'Approved'
                                            ? Colors.green.shade700
                                            : Colors.red.shade700,
                                        size: 14,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        status,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: status == 'Approved'
                                              ? Colors.green.shade700
                                              : Colors.red.shade700,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildModernInfoCard(String title, String value, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              icon,
              color: color,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        content,
      ],
    );
  }
}