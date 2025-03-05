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
            ),
          );
        },
      ),
    );
  }
}

class DemandCard extends StatefulWidget {
  final Map<String, dynamic> demandDetails;
  final int demandNumber;

  const DemandCard({
    Key? key,
    required this.demandDetails,
    required this.demandNumber,
  }) : super(key: key);

  @override
  State<DemandCard> createState() => _DemandCardState();
}

class _DemandCardState extends State<DemandCard> {
  bool _showStatusReference = false;

  Widget _buildStatusCodeReference() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // The reference card
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 10, bottom: 16, left: 34),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Status Code Reference',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: const Color(0xFF0073CF),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _showStatusReference = false;
                      });
                    },
                    child: Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const Divider(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: [
                  _buildStatusCodeItem('D', 'Demand Initiated'),
                  _buildStatusCodeItem('F', 'Fund(Allocation) Certified'),
                  _buildStatusCodeItem('P', 'PAC Approved'),
                  _buildStatusCodeItem('T', 'Technical Vetting'),
                  _buildStatusCodeItem('C', 'Financial Concurrence'),
                  _buildStatusCodeItem('R', 'Purchase Review'),
                  _buildStatusCodeItem('S', 'Sanctioned'),
                ],
              ),
            ],
          ),
        ),
        // Arrow pointing up
        Positioned(
          top: 2,
          left: 50,
          child: CustomPaint(
            painter: ArrowPainter(Colors.grey[100]!, Colors.grey.withOpacity(0.3)),
            size: const Size(16, 8),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusCodeItem(String code, String description) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            shape: BoxShape.circle,
          ),
          child: Text(
            code,
            style: const TextStyle(
              color: Color(0xFF0073CF),
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          description,
          style: const TextStyle(
            color: Color(0xFF0073CF),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0073CF), Color(0xFF1E88E5)],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${widget.demandNumber}. ${widget.demandDetails['id']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: Container(
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
                        Expanded(
                          child: Text(
                            widget.demandDetails['date'],
                            style: TextStyle(color: Colors.grey[800], fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildDetailItem(
              context,
              Icons.info_outline,
              'Status',
              widget.demandDetails['status'],
              subtitle: widget.demandDetails['statusCode'],
              showStatusInfo: true,
            ),
            if (_showStatusReference) _buildStatusCodeReference(),
            _buildDetailItem(
              context,
              Icons.person,
              'Indentor',
              widget.demandDetails['indentor'],
              subtitle: widget.demandDetails['indentorCode'],
              isBold: true,
              isBlueText: true,
            ),
            _buildDetailItem(
              context,
              Icons.person,
              'Currently With',
              widget.demandDetails['currentWith']['name'],
              subtitle: widget.demandDetails['currentWith']['email'],
              isBold: true,
              isBlueText: true,
            ),
            _buildDetailItem(
              context,
              Icons.description,
              'Purpose',
              widget.demandDetails['purpose'],
            ),
            _buildDetailItem(
              context,
              Icons.currency_rupee,
              'Value / Approval Level',
              '${widget.demandDetails['estimatedValue']} / ${widget.demandDetails['approvalLevel']}',
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(
      BuildContext context,
      IconData icon,
      String label,
      String value, {
        String? subtitle,
        bool isBold = false,
        bool isBlueText = false,
        bool isLast = false,
        bool showStatusInfo = false,
      }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : (_showStatusReference && showStatusInfo ? 0 : 20)),
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
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  ),
                  overflow: TextOverflow.visible,
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          subtitle,
                          style: TextStyle(
                            color: isBlueText ? const Color(0xFF0073CF) : Colors.grey[600],
                            fontSize: 14,
                            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (showStatusInfo) ...[
                        const SizedBox(width: 4),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _showStatusReference = !_showStatusReference;
                            });
                          },
                          child: Icon(
                            Icons.info_outline,
                            size: 14,
                            color: const Color(0xFF0073CF),
                          ),
                        ),
                      ],
                    ],
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

// Custom painter for drawing the arrow
class ArrowPainter extends CustomPainter {
  final Color fillColor;
  final Color borderColor;

  ArrowPainter(this.fillColor, this.borderColor);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}