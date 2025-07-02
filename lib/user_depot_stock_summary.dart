import 'package:flutter/material.dart';

class UserDepotStockSummaryScreen extends StatelessWidget {
  const UserDepotStockSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use Material 3 theme
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade800, Colors.blue.shade600],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          style: IconButton.styleFrom(foregroundColor: Colors.white),
        ),
        title: const Text(
          'User Depot Stock Summary',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
            style: IconButton.styleFrom(foregroundColor: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          // Total Value at the top with gradient
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Container(
              height: 75,
              width: 230,
              padding: const EdgeInsets.all(18),
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
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.account_balance_wallet,
                      color: Colors.blue.shade700,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Stock Value',
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
                            '₹ 911,825,131,385',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Card positioned after Total Stock Value
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: 360, // Reduced width
              height: 300, // Fixed height
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow('Railway', 'IREPS-TESTING'),
                      const SizedBox(height: 8), // Reduced spacing
                      _buildInfoRow('Unit Type', 'Zonal HQ / PU HQ'),
                      const SizedBox(height: 8), // Reduced spacing
                      _buildInfoRow('UNIT', 'EPS/UD'),
                      const SizedBox(height: 8), // Reduced spacing
                      _buildInfoRow('Department', 'Mechanical'),
                      const SizedBox(height: 8), // Reduced spacing
                      _buildInfoRow(
                        'User Depot',
                        '36640-SSE/EPS/UD',
                        valueColor: Colors.orange,
                        valueFontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 8), // Reduced spacing
                      _buildInfoRow(
                        'Stock Value',
                        '911825131384',
                        valueColor: Colors.orange,
                        valueFontWeight: FontWeight.bold,
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _buildActionButton(
                            icon: Icons.share,
                            label: 'Share',
                            onPressed: () {},
                          ),
                          const SizedBox(width: 16),
                          _buildActionButton(
                            icon: Icons.forward,
                            label: 'Forward',
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value, {
    Color? valueColor,
    FontWeight? valueFontWeight,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100, // Reduced width
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14, // Smaller font size
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.1, // Reduced letter spacing
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14, // Smaller font size
                color: valueColor ?? Colors.black,
                fontWeight: valueFontWeight ?? FontWeight.w500,
                letterSpacing: 0.1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        FilledButton.tonal(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: Colors.blue.shade50,
            foregroundColor: Colors.blue.shade800,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(12), // Reduced padding
            minimumSize: const Size(40, 40), // Smaller size
          ),
          child: Icon(icon, size: 20), // Smaller icon
        ),
        const SizedBox(height: 2), // Reduced spacing
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.blue.shade800,
          ), // Smaller font
        ),
      ],
    );
  }
}
