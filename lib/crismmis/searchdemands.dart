import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demand Details',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue,
        ),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const DemandDetailsPage(),
    );
  }
}

class DemandDetails {
  final String demandNo;
  final String date;
  final String indentor;
  final String status;
  final String value;
  final String currentWith;
  final String description;

  DemandDetails({
    required this.demandNo,
    required this.date,
    required this.indentor,
    required this.status,
    required this.value,
    required this.currentWith,
    required this.description,
  });
}

class DemandDetailsPage extends StatelessWidget {
  const DemandDetailsPage({super.key});

  List<DemandDetails> get demandDetailsList => [
    DemandDetails(
      demandNo: 'CRIS-FINANCE-25-00052',
      date: '28/01/2025',
      indentor: 'FINANCE',
      status: 'Returned on 11/02/25',
      value: '₹290,800',
      currentWith: 'MAHESH SINGH\nExecutive/Acct',
      description: 'Procurement of 4 Nos of all in one Desktop PCs with 03 years of OEM warranty support and 4 Nos of Microsoft Office Suite Software',
    ),
    DemandDetails(
      demandNo: 'CRIS-FINANCE-24-00051',
      date: '18/12/2024',
      indentor: 'FINANCE',
      status: 'Demand Approved to Purchase Unit: CRIS on 19/12/24',
      value: '₹62,524',
      currentWith: 'Purchase Unit: CRIS',
      description: 'Procurement of Composite Cartridges for offcial use of Director Finance.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Demand Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
        backgroundColor: Colors.blue[700],
        elevation: 2,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: demandDetailsList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: _buildDemandCard(context, demandDetailsList[index], index + 1),
          );
        },
      ),
    );
  }

  Widget _buildDemandCard(BuildContext context, DemandDetails details, int index) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context, details, index),
            const SizedBox(height: 24),
            _buildDemandDetails(context, details),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, DemandDetails details, int index) {
    final demandIdParts = details.demandNo.split('-');
    final demandNumeric = demandIdParts.length > 2 ? demandIdParts.last : details.demandNo;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue[700],
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$index. ',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'CRIS-FINANCE-',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.8,
                          ),
                        ),
                        Text(
                          demandNumeric,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  details.date,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDemandDetails(BuildContext context, DemandDetails details) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHighlightedRow(
          context,
          'Demand Status',
          details.status,
          icon: Icons.pending_actions_outlined,
        ),
        _buildDetailRow(
          context,
          'Indentor',
          details.indentor,
          icon: Icons.account_balance_outlined,
        ),
        _buildDetailRow(
          context,
          'Estimated Value',
          details.value,
          icon: Icons.currency_rupee_outlined,
        ),
        _buildHighlightedRow(
          context,
          'Current With',
          details.currentWith,
          icon: Icons.person_outlined,
        ),
        _buildExpandableDescription(
          context,
          details.description,
          icon: Icons.description_outlined,
          isLast: true,
        ),
      ],
    );
  }

  Widget _buildDetailRow(
      BuildContext context,
      String label,
      String value, {
        IconData? icon,
        bool isLast = false,
      }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null)
            Container(
              width: 30,
              alignment: Alignment.center,
              child: Icon(
                icon,
                size: 22,
                color: Colors.blue[600],
              ),
            ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 15,
                    height: 1.4,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightedRow(
      BuildContext context,
      String label,
      String value, {
        IconData? icon,
        bool isLast = false,
      }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null)
            Container(
              width: 30,
              alignment: Alignment.center,
              child: Icon(
                icon,
                size: 22,
                color: Colors.blue[600],
              ),
            ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 15,
                    height: 1.4,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableDescription(
      BuildContext context,
      String description, {
        IconData? icon,
        bool isLast = false,
      }) {
    return StatefulBuilder(
      builder: (context, setState) {
        final ValueNotifier<bool> expandedNotifier = ValueNotifier<bool>(false);
        final ValueNotifier<bool> isHoveringNotifier = ValueNotifier<bool>(false);

        return ValueListenableBuilder<bool>(
            valueListenable: expandedNotifier,
            builder: (context, isExpanded, child) {
              final maxLines = isExpanded ? null : 2;
              final overflow = isExpanded
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis;

              return Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (icon != null)
                      Container(
                        width: 30,
                        alignment: Alignment.center,
                        child: Icon(
                          icon,
                          size: 22,
                          color: Colors.blue[600],
                        ),
                      ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            description,
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 15,
                              height: 1.4,
                              letterSpacing: 0.2,
                            ),
                            maxLines: maxLines,
                            overflow: overflow,
                          ),
                          if (description.length > 80)
                            ValueListenableBuilder<bool>(
                              valueListenable: isHoveringNotifier,
                              builder: (context, isHovering, _) {
                                return MouseRegion(
                                  onEnter: (_) => isHoveringNotifier.value = true,
                                  onExit: (_) => isHoveringNotifier.value = false,
                                  child: GestureDetector(
                                    onTap: () {
                                      expandedNotifier.value = !expandedNotifier.value;
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 4),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                        horizontal: 12.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isHovering ? Colors.blue[50] : Colors.transparent,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            isExpanded ? 'See less' : 'See more',
                                            style: TextStyle(
                                              color: Colors.blue[700],
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Icon(
                                            isExpanded
                                                ? Icons.keyboard_arrow_up
                                                : Icons.keyboard_arrow_down,
                                            size: 16,
                                            color: Colors.blue[700],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
        );
      },
    );
  }
}