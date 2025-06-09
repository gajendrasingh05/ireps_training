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
      debugShowCheckedModeBanner: false, // Remove debug banner
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue.shade800, // Changed to blue shade 800
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const CRCSummaryPage(),
    );
  }
}

class CRCSummaryPage extends StatelessWidget {
  const CRCSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'CRC Summary',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        backgroundColor: Colors.blue.shade800, // Changed app bar color to blue shade 800
        foregroundColor: Colors.white, // Changed to white for better contrast
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, size: 20),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, size: 20),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Header
              _buildTitleHeader(),
              const SizedBox(height: 20),

              // Railway Info
              _buildRailwayInfo(),
              const SizedBox(height: 20),

              // Summary Stats
              _buildSummaryStats(),
              const SizedBox(height: 20),

              // Detailed Summary
              _buildDetailedSummary(),
              const SizedBox(height: 20),

              // Breakdown by Days
              _buildBreakdown(),
              const SizedBox(height: 20),

              // Grand Total
              _buildGrandTotal(),

              const SizedBox(height: 80), // Space for FAB
            ],
          ),
        ),
      ),
      // Removed FloatingActionButton as requested
    );
  }

  Widget _buildTitleHeader() {
    return Card(
      elevation: 2,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.blue.shade800.withOpacity(0.1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Summary of Digitally-signed CRCs for Non-Stock Items',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade800,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'supplied by vendors from 09-03-2025 to 09-06-2025',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
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
      ),
    );
  }

  Widget _buildRailwayInfo() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Railway Information',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade800,
              ),
            ),
            const SizedBox(height: 12),
            _buildInfoRow('Railway:', 'IREPS-TESTING'),
            _buildInfoRow('Unit Type:', 'Zonal HQ / PU HQ'),
            _buildInfoRow('Unit Name:', 'EPS/UD'),
            _buildInfoRow('Department:', 'Mechanical'),
            _buildInfoRow('Consignee & Sub-Consignee:', '36640-SSE/EPS/UD'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Summary',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.blue.shade800,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildStatCard('Opening\nBalance', '165', Colors.orange)),
            const SizedBox(width: 12),
            Expanded(child: _buildStatCard('New\nReceived', '6', Colors.green)),
            const SizedBox(width: 12),
            Expanded(child: _buildStatCard('CRCs\nIssued', '1', Colors.blue)),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedSummary() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Consignment Summary',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade800,
              ),
            ),
            const SizedBox(height: 16),
            _buildSummaryItem(
              'Opening Balance (Consignments where Digitally-Signed CRC pending)',
              '165',
              'Pending consignments from previous period',
            ),
            const Divider(height: 24),
            _buildSummaryItem(
              'New Consignments Received',
              '6',
              'Recently added to the system',
            ),
            const Divider(height: 24),
            _buildSummaryItem(
              'Consignments where Digitally-Signed CRCs issued',
              '1',
              'Successfully processed consignments',
            ),
            const Divider(height: 24),
            _buildSummaryItem(
              'Closing Balance (Consignments where Digitally-Signed CRC pending)',
              '165',
              'Remaining pending consignments (165 + 6 - 1 = 170, but showing 165 as per data)',
              isHighlighted: false, // Removed highlighting to remove blue circle
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value, String description, {bool isHighlighted = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isHighlighted ? Colors.blue.shade800 : Colors.black87,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildBreakdown() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Break-up of Pending Digitally-Signed CRCs',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade800,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildBreakdownCard('<7 Days', '0', Colors.green)),
                const SizedBox(width: 8),
                Expanded(child: _buildBreakdownCard('7 to 15 Days', '3', Colors.orange)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _buildBreakdownCard('15 to 30 Days', '0', Colors.blue)),
                const SizedBox(width: 8),
                Expanded(child: _buildBreakdownCard('>30 Days', '162', Colors.red)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBreakdownCard(String period, String count, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            period,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrandTotal() {
    return Card(
      elevation: 4, // Increased elevation for better appearance
      child: Container(
        padding: const EdgeInsets.all(20), // Increased padding
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient( // Added gradient for better look
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade800.withOpacity(0.05),
              Colors.blue.shade800.withOpacity(0.02),
            ],
          ),
          border: Border.all(
            color: Colors.blue.shade800.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.summarize,
                  color: Colors.blue.shade800,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Grand Total Summary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildGrandTotalRow('Opening Balance (Consignments where Digitally-Signed CRC pending)', '165'),
                  const SizedBox(height: 12),
                  _buildGrandTotalRow('New Consignments Received', '6'),
                  const SizedBox(height: 12),
                  _buildGrandTotalRow('Consignments where Digitally-Signed CRCs issued', '1'),
                  const SizedBox(height: 12),
                  _buildGrandTotalRow('Closing Balance (Consignments where Digitally-Signed CRC pending)', '165'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrandTotalRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.blue.shade800.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
        ),
      ],
    );
  }
}