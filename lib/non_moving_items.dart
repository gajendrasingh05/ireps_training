import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Non-Moving Items',
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

class NonMovingItemsPage extends StatelessWidget {
  const NonMovingItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = _getSampleData();
    final totalValue = items.fold(0.0, (sum, item) => sum + item.value);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Non-Moving Items',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary Header - Rectangle Cards
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    icon: Icons.inventory_2,
                    title: 'Total Records',
                    value: '${items.length}',
                    subtitle: 'Items Found',
                    iconColor: Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSummaryCard(
                    icon: Icons.currency_rupee,
                    title: 'Total Value',
                    value: '₹${totalValue.toStringAsFixed(2)}',
                    subtitle: 'Total Worth',
                    iconColor: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          // Items List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return InventoryItemCard(
                  item: items[index],
                  index: index + 1,
                );
              },
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
            decoration: BoxDecoration(
              color: Colors.blue.shade800.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<InventoryItem> _getSampleData() {
    return [
      InventoryItem(
        id: 1,
        consigneeDepot: 'SSE/FPS/UD\n36640 - Mechanical\nIREPS-TESTING',
        ledgerNo: '001 Consumable Items1\n0001 Liquid Soap',
        plNo: '10120555',
        itemType: 'Vital\nConsumable\n10-ORDINARY NEW STORES',
        stockStatus: 'Stock',
        lastReceiptDate: '21-05-2025',
        lastIssueDate: '12-10-2023',
        stockUnit: '100.000 Nos.',
        thresholdLimit: 32000,
        averageRate: 100.00,
        value: 10000.00,
        briefDescription: 'Cover element lub oil strainer',
      ),
      InventoryItem(
        id: 2,
        consigneeDepot: 'SSE/FPS/UD\n36640 - Mechanical\nIREPS-TESTING',
        ledgerNo: '001 Consumable Items1\n0001 Liquid Soap',
        plNo: '82050001001S',
        itemType: 'Vital\nM&P Spares\n10-ORDINARY NEW STORES',
        stockStatus: 'Non-Stock',
        lastReceiptDate: '28-08-2022',
        lastIssueDate: '06-10-2023',
        stockUnit: '1.000 Nos.',
        thresholdLimit: 2000,
        averageRate: 2000.00,
        value: 2000.00,
        briefDescription: 'Drugs and Pharmaceuticals.',
      ),
      InventoryItem(
        id: 3,
        consigneeDepot: 'SSE/FPS/UD\n36640 - Mechanical\nIREPS-TESTING',
        ledgerNo: '002 Maintenance Items\n0002 Engine Oil',
        plNo: '10120777',
        itemType: 'Critical\nMaintenance\n15-SPECIAL STORES',
        stockStatus: 'Stock',
        lastReceiptDate: '15-03-2025',
        lastIssueDate: '20-09-2023',
        stockUnit: '50.000 Liters',
        thresholdLimit: 15000,
        averageRate: 450.00,
        value: 22500.00,
        briefDescription: 'High grade engine lubricant for diesel locomotives',
      ),
    ];
  }
}

class InventoryItemCard extends StatelessWidget {
  final InventoryItem item;
  final int index;

  const InventoryItemCard({
    super.key,
    required this.item,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade300, // Changed to lighter blue
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      '$index',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Consignee Depot',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade800,
                        ),
                      ),
                      Text(
                        item.consigneeDepot.split('\n')[0],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade300, // Changed to lighter blue
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.share,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Details Grid
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem('PL No', item.plNo, Colors.black),
                ),
                Expanded(
                  child: _buildDetailItem(
                      'Avg Rate (Rs.)',
                      '₹${item.averageRate.toStringAsFixed(2)}',
                      Colors.green.shade600
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                      'Stock Unit',
                      item.stockUnit,
                      Colors.black
                  ),
                ),
                Expanded(
                  child: _buildDetailItem(
                      'Value (Rs.)',
                      '₹${item.value.toStringAsFixed(2)}',
                      Colors.orange.shade700
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                      'Last Receipt',
                      item.lastReceiptDate,
                      Colors.black
                  ),
                ),
                Expanded(
                  child: _buildDetailItem(
                      'Last Issue',
                      item.lastIssueDate,
                      Colors.black
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                      'Stock Status',
                      item.stockStatus,
                      item.stockStatus == 'Stock' ? Colors.green.shade600 : Colors.red.shade600
                  ),
                ),
                Expanded(
                  child: _buildDetailItem(
                      'Threshold',
                      '${item.thresholdLimit}',
                      Colors.black
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Ledger Info and Item Type in a row layout
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ledger Information
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ledger Information',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.ledgerNo,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Item Type / Category
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Item Type / Category',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.itemType,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Description
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Brief Description',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.briefDescription,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    height: 1.4,
                  ),
                ),
              ],
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
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}

class InventoryItem {
  final int id;
  final String consigneeDepot;
  final String ledgerNo;
  final String plNo;
  final String itemType;
  final String stockStatus;
  final String lastReceiptDate;
  final String lastIssueDate;
  final String stockUnit;
  final int thresholdLimit;
  final double averageRate;
  final double value;
  final String briefDescription;

  InventoryItem({
    required this.id,
    required this.consigneeDepot,
    required this.ledgerNo,
    required this.plNo,
    required this.itemType,
    required this.stockStatus,
    required this.lastReceiptDate,
    required this.lastIssueDate,
    required this.stockUnit,
    required this.thresholdLimit,
    required this.averageRate,
    required this.value,
    required this.briefDescription,
  });
}