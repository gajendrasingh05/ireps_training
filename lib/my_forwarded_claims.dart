//*** path ***
//Reports & Transaction >> Rejection/Warranty >> MyForwardedClaims

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Item-List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue.shade800,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade800,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const ForwardedClaimsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ForwardedClaimsPage extends StatefulWidget {
  const ForwardedClaimsPage({super.key});

  @override
  State<ForwardedClaimsPage> createState() => _ForwardedClaimsPageState();
}

class _ForwardedClaimsPageState extends State<ForwardedClaimsPage> {
  late ScrollController _scrollController;
  final int scrollItemCount = 5; // Set your desired skip amount here
  final double itemHeight = 200.0;
  bool _isScrolling = false;

  List<Claims> get items => List.generate(
    20,
    (index) => Claims(
      id: index + 1,
      forwardToDate: 'MOHAN LAL Sr.DME/EPS/UD 05/06/2025',
      warranty: '36640-25-00066 dt. 05-06-25/',
      udm: 'comp-05-06-2025 dt. 05-06-2025',
      vendorName: 'M/S TEST BIDDER.-KANPUR',
      poContract: '224342344 dt. 05-06-25/ ch789 dt. 05-06-25',
      itemDescription:
          '6546 .Item Description test(Product/Component Rejected: Description as per Complaint test - PLNo.23244414)',
      rejectedQty: 12.00,
      value: 27.60,
      rate: 2.30,
    ),
  );

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (!_isScrolling) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool _canScrollUp() =>
      _scrollController.hasClients &&
      _scrollController.offset > (itemHeight * 2);

  bool _canScrollDown() {
    if (!_scrollController.hasClients) return true;
    return _scrollController.offset <
        (_scrollController.position.maxScrollExtent - 10);
  }

  void _scrollUp() {
    final double scrollDistance = scrollItemCount * itemHeight;
    final double targetOffset = (_scrollController.offset - scrollDistance)
        .clamp(0.0, double.infinity);

    _isScrolling = true;
    _scrollController
        .animateTo(
          targetOffset,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        )
        .then((_) {
          _isScrolling = false;
          setState(() {});
        });
  }

  void _scrollDown() {
    final double scrollDistance = scrollItemCount * itemHeight;
    final double targetOffset = _scrollController.offset + scrollDistance;

    _isScrolling = true;
    _scrollController
        .animateTo(
          targetOffset,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        )
        .then((_) {
          _isScrolling = false;
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    final totalValue = 5116734.10;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Forwarded Claims',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    icon: Icons.inventory_2,
                    title: 'Total Items',
                    value: '${items.length}',
                    subtitle: 'items found',
                    iconColor: Colors.blue.shade700,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildSummaryCard(
                    icon: Icons.currency_rupee,
                    title: 'Total Value (Rs.)',
                    value: totalValue.toStringAsFixed(2),
                    subtitle: '',
                    iconColor: Colors.blue.shade700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  child: ClaimsCard(item: items[index], index: index + 1),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButtons(),
    );
  }

  Widget _buildFloatingActionButtons() {
    final List<Widget> buttons = [];

    // Up arrow (only show after some scrolling)
    if (_canScrollUp()) {
      buttons.add(
        FloatingActionButton(
          heroTag: "previous",
          onPressed: _scrollUp,
          backgroundColor: Colors.blue.shade50,
          foregroundColor: Colors.blue.shade700,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.keyboard_arrow_up),
        ),
      );
      buttons.add(const SizedBox(height: 12));
    }

    // Down arrow (show when can scroll down)
    if (_canScrollDown()) {
      buttons.add(
        FloatingActionButton(
          heroTag: "next",
          onPressed: _scrollDown,
          backgroundColor: Colors.blue.shade50,
          foregroundColor: Colors.blue.shade700,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.keyboard_arrow_down),
        ),
      );
    }

    return Column(mainAxisSize: MainAxisSize.min, children: buttons);
  }

  Widget _buildSummaryCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Color iconColor,
  }) {
    return Container(
      height: 75,
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
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
                    value,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.blueGrey.shade400,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ClaimsCard extends StatelessWidget {
  final Claims item;
  final int index;

  const ClaimsCard({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withValues(alpha: 0.07),
            spreadRadius: 1,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      '$index',
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabelValue(
                        'Forwarded To / Date:',
                        item.forwardToDate,
                      ),
                      const SizedBox(height: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Vendor Name:',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            item.vendorName,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'PO-Contract / Challan No. & Date:',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  item.poContract,
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                ),
              ],
            ),

            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildKeyValueTile(
                    'Rate:',
                    '₹${item.rate}',
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildKeyValueTile(
                    'Rejected Qty:',
                    '${item.rejectedQty} Nos.',
                    Colors.red.shade300,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildLabelValue(
              'Warranty Claim No. & Rejection / Supply Ref:',
              item.warranty,
            ),
            const SizedBox(height: 12),
            Text(
              'Item Description',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            ExpandableText(text: item.itemDescription),
          ],
        ),
      ),
    );
  }

  Widget _buildLabelValue(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 13, color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildKeyValueTile(String title, String value, Color color) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;

  const ExpandableText({super.key, required this.text, this.maxLines = 2});

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          maxLines: _expanded ? null : widget.maxLines,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.4),
        ),
        if (_shouldShowToggle(widget.text))
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Text(
              _expanded ? 'Read more' : 'Read less',
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }

  bool _shouldShowToggle(String text) => text.length > 100;
}

class Claims {
  final int id;
  final String forwardToDate;
  final String warranty;
  final String udm;
  final String vendorName;
  final String poContract;
  final String itemDescription;
  final double rejectedQty;
  final double value;
  final double rate;

  Claims({
    required this.id,
    required this.forwardToDate,
    required this.warranty,
    required this.udm,
    required this.vendorName,
    required this.poContract,
    required this.itemDescription,
    required this.rejectedQty,
    required this.value,
    required this.rate,
  });
}
