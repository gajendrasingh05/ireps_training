import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stores Depot Stock List',
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
      home: const StoresDepotPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StoresDepotPage extends StatelessWidget {
  const StoresDepotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Stores Depot Stock List',
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
          // Summary Header
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade100, Colors.blue.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade200.withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      icon: Icons.inventory_2,
                      title: 'Total Records',
                      value: '1,526',
                      subtitle: 'Items Found',
                      iconColor: Colors.green,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.grey.shade300.withOpacity(0.3),
                          Colors.grey.shade400.withOpacity(0.6),
                          Colors.grey.shade300.withOpacity(0.3),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Expanded(
                    child: _buildSummaryCard(
                      icon: Icons.currency_rupee,
                      title: 'Total Value',
                      value: '₹1.85B',
                      subtitle: '1,852,335,192.95',
                      iconColor: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          // Stock Items List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: stockItems.length,
              itemBuilder: (context, index) {
                return StockItemCard(
                  item: stockItems[index],
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
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade800.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey.shade500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class StockItemCard extends StatelessWidget {
  final StockItem item;
  final int index;

  const StockItemCard({
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
                    color: Colors.blue.shade800,
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
                        '${item.railway} - ${item.ireps}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade800,
                        ),
                      ),
                      Text(
                        '${item.storesDepot} • Ward ${item.ward}',
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
                    color: Colors.blue.shade800,
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
                      'Rate (Rs.)',
                      item.rate.toStringAsFixed(2),
                      Colors.green.shade600
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildDetailItem(
                'Stock Qty. / Unit',
                '${item.stockQty} ${item.unit}',
                Colors.black
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
                  item.description,
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

class StockItem {
  final String railway;
  final String ireps;
  final String storesDepot;
  final String ward;
  final String plNo;
  final double rate;
  final int stockQty;
  final String unit;
  final String description;

  StockItem({
    required this.railway,
    required this.ireps,
    required this.storesDepot,
    required this.ward,
    required this.plNo,
    required this.rate,
    required this.stockQty,
    required this.unit,
    required this.description,
  });
}

final List<StockItem> stockItems = [
  StockItem(
    railway: 'Railway',
    ireps: 'IREPS',
    storesDepot: '05: EPS DEPOT 05',
    ward: '10',
    plNo: '10050243',
    rate: 2149.33,
    stockQty: 0,
    unit: 'Number',
    description: 'Fuel injection tube assembly DLW Drg.No.SKE-0863,Alt-"m" or latest. DLW part no.10051703.',
  ),
  StockItem(
    railway: 'Railway',
    ireps: 'IREPS',
    storesDepot: '25: EPS 25',
    ward: '01',
    plNo: '10050243',
    rate: 2144.58,
    stockQty: 2,
    unit: 'Number',
    description: 'Fuel injection tube assembly DLW Drg.No.SKE-0863,Alt-"m" or latest. DLW part no.10051703.',
  ),
  StockItem(
    railway: 'Railway',
    ireps: 'IREPS',
    storesDepot: '27: EPS 27',
    ward: '01',
    plNo: '10050243',
    rate: 2209.54,
    stockQty: 1,
    unit: 'Number',
    description: 'Fuel injection tube assembly DLW Drg.No.SKE-0863,Alt-"m" or latest. DLW part no.10051703.',
  ),
];