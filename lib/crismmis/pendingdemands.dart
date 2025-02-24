import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demand Details App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[50],
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0073CF)),
      ),
      home: const DemandDetails(),
    );
  }
}

class DemandDetails extends StatelessWidget {
  const DemandDetails({Key? key}) : super(key: key);

  void _showStatusCodeModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xFF0073CF),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Status Code Reference',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: controller,
                  padding: const EdgeInsets.all(20),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _buildStatusItem('D', 'Demand Initiated'),
                      _buildStatusItem('F', 'Fund(Allocation) Certified'),
                      _buildStatusItem('P', 'PAC Approved'),
                      _buildStatusItem('T', 'Technical Vetting'),
                      _buildStatusItem('C', 'Financial Concurrence'),
                      _buildStatusItem('R', 'Purchase Review'),
                      _buildStatusItem('S', 'Sanctioned'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusItem(String code, String description) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              shape: BoxShape.circle,
            ),
            child: Text(
              code,
              style: const TextStyle(
                color: Color(0xFF0073CF),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              description,
              style: const TextStyle(
                color: Color(0xFF0073CF),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> demands = [
      {
        'id': 'IMMSTEST-CRIS-EPS-EPS-24-00018',
        'date': '12-DEC-24',
        'status': 'Demand returned from Purchase Unit IMMS on 27/12/24',
        'statusCode': 'F—C—R—S',
        'indentor': 'NAVAL KUMAR GUPTA',
        'indentorCode': 'AM/01',
        'purpose': 'testing for large value demand',
        'estimatedValue': 'Rs.3555360.0',
        'approvalLevel': 'MD',
        'currentWith': {
          'name': 'AM/01',
          'email': 'ameps@gmail.com'
        }
      },
      {
        'id': 'IMMSTEST-CRIS-EPS-EPS-24-00019',
        'date': '17-DEC-24',
        'status': 'Fund Certified on 17/12/24',
        'statusCode': 'F',
        'indentor': 'NAVAL KUMAR GUPTA',
        'indentorCode': 'AM/01',
        'purpose': 'purchase of 12 pC',
        'estimatedValue': 'Rs.5287634.0',
        'approvalLevel': 'MD',
        'currentWith': {
          'name': 'AM/01',
          'email': 'ameps@gmail.com'
        }
      },
      {
        'id': 'IMMSTEST-CRIS-EPS-EPS-24-00001',
        'date': '01-MAY-24',
        'status': 'Demand returned from Purchase Unit IMMS on 29/07/24',
        'statusCode': 'F—P—V—C—R—S',
        'indentor': 'NAVAL KUMAR GUPTA',
        'indentorCode': 'AM/01',
        'purpose': 'testing purpose',
        'estimatedValue': 'Rs.125000.0',
        'approvalLevel': 'GM/GGM',
        'currentWith': {
          'name': 'AM/01',
          'email': 'ameps@gmail.com'
        }
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color(0xFF0073CF),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Pending Demands',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: demands.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: DemandCard(
              demandDetails: demands[index],
              demandNumber: index + 1,
              onStatusCodeTap: () => _showStatusCodeModal(context),
            ),
          );
        },
      ),
    );
  }
}

class DemandCard extends StatelessWidget {
  final Map<String, dynamic> demandDetails;
  final int demandNumber;
  final VoidCallback onStatusCodeTap;

  const DemandCard({
    Key? key,
    required this.demandDetails,
    required this.demandNumber,
    required this.onStatusCodeTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0073CF), Color(0xFF1E88E5)],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '$demandNumber. ${demandDetails['id']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        demandDetails['date'],
                        style: TextStyle(color: Colors.grey[800], fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildDetailItem(
              Icons.info_outline,
              'Status',
              demandDetails['status'],
              subtitle: demandDetails['statusCode'],
              onStatusCodeTap: onStatusCodeTap,
            ),
            _buildDetailItem(
              Icons.person,
              'Indentor',
              demandDetails['indentor'],
              subtitle: demandDetails['indentorCode'],
              isBold: true,
              isBlueText: true,
            ),
            _buildDetailItem(
              Icons.person,
              'Currently With',
              demandDetails['currentWith']['name'],
              subtitle: demandDetails['currentWith']['email'],
              isBold: true,
              isBlueText: true,
            ),
            _buildDetailItem(
              Icons.description,
              'Purpose',
              demandDetails['purpose'],
            ),
            _buildDetailItem(
              Icons.currency_rupee,
              'Value / Approval Level',
              '${demandDetails['estimatedValue']} / ${demandDetails['approvalLevel']}',
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(
      IconData icon,
      String label,
      String value, {
        String? subtitle,
        bool isBold = false,
        bool isBlueText = false,
        bool isLast = false,
        VoidCallback? onStatusCodeTap,
      }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFF0073CF).withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, size: 16, color: const Color(0xFF0073CF)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  InkWell(
                    onTap: label == 'Status' ? onStatusCodeTap : null,
                    child: Row(
                      children: [
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: isBlueText ? const Color(0xFF0073CF) : Colors.grey[600],
                            fontSize: 14,
                            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        if (label == 'Status') ...[
                          const SizedBox(width: 4),
                          Icon(
                            Icons.info_outline,
                            size: 14,
                            color: const Color(0xFF0073CF),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}