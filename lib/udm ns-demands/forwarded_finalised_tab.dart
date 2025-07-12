import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ForwardedFinalisedTab extends StatefulWidget {
  const ForwardedFinalisedTab({super.key});

  @override
  State<ForwardedFinalisedTab> createState() => _ForwardedFinalisedTabState();
}

class _ForwardedFinalisedTabState extends State<ForwardedFinalisedTab> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final _fromDateController = TextEditingController();
  final _toDateController = TextEditingController();

  // Date values
  DateTime? _fromDate;
  DateTime? _toDate;

  @override
  void initState() {
    super.initState();
    // Set default dates (last 30 days)
    _toDate = DateTime.now();
    _fromDate = DateTime.now().subtract(const Duration(days: 30));
    _fromDateController.text = DateFormat('dd-MM-yyyy').format(_fromDate!);
    _toDateController.text = DateFormat('dd-MM-yyyy').format(_toDate!);
  }

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isFromDate
          ? _fromDate ?? DateTime.now()
          : _toDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue.shade800,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isFromDate) {
          _fromDate = picked;
          _fromDateController.text = DateFormat('dd-MM-yyyy').format(picked);
        } else {
          _toDate = picked;
          _toDateController.text = DateFormat('dd-MM-yyyy').format(picked);
        }
      });
    }
  }

  void _submitForm() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NSDemandFinalizedScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Range Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.keyboard_double_arrow_right,
                          color: Colors.blue.shade800,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Forwarded/Finalised by me',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue.shade800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Date Range Row
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _fromDateController,
                            decoration: const InputDecoration(
                              labelText: 'From Date',
                              prefixIcon: Icon(Icons.calendar_today_outlined),
                            ),
                            readOnly: true,
                            onTap: () => _selectDate(context, true),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select from date';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _toDateController,
                            decoration: const InputDecoration(
                              labelText: 'To Date',
                              prefixIcon: Icon(Icons.event_outlined),
                            ),
                            readOnly: true,
                            onTap: () => _selectDate(context, false),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select to date';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _submitForm,
                icon: const Icon(Icons.search_outlined),
                label: const Text('Submit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NSDemandFinalizedScreen extends StatefulWidget {
  const NSDemandFinalizedScreen({super.key});

  @override
  State<NSDemandFinalizedScreen> createState() =>
      _NSDemandFinalizedScreenState();
}

class _NSDemandFinalizedScreenState extends State<NSDemandFinalizedScreen> {
  late ScrollController _scrollController;
  final int scrollItemCount = 5;
  final double itemHeight = 200.0;
  bool _isScrolling = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Sample data for demonstration
  List<DemandItem> get demandItems => [
    DemandItem(
      demandNoDate: 'IREPS-36640-25-00168\nDt.2025-06-06\n809809',
      indentor: 'CRIS TEST 2022 SSE/EPS/UD',
      itemDetails:
          'Item No.1: Tender Axle Boxes and det.... [Qty: 100 Pairs]\nItem No.2: Spring & Spring Gear..... [Qty: 1 Set]\nItem No.3: —.... [Qty: 102 Pairs]',
      valueMinApprovalLevel: '₹1,717,686.00 - SAG',
      currentlyWith: 'CRIS TEST 2022 SSE/EPS/UD',
      status: 'Sent for further action on 02/06/25',
    ),
    DemandItem(
      demandNoDate: 'IREPS-36640-25-00167\nDt.2025-06-06\n809809',
      indentor: 'CRIS TEST 2022 SSE/EPS/UD',
      itemDetails: 'Item No.1: Tender Axle Boxes and det.... [Qty: Set]',
      valueMinApprovalLevel: '₹0.00 - Jr. Scale',
      currentlyWith: 'CRIS TEST 2022 SSE/EPS/UD',
      status: 'Demand Approved & Forwaded to Purchase Unit',
    ),
    DemandItem(
      demandNoDate: 'IREPS-36640-25-00166\nDt.2025-06-06\n809809',
      indentor: 'CRIS TEST 2022 SSE/ELE/UD',
      itemDetails: 'Item No.1: Electrical Components.... [Qty: 50 Units]',
      valueMinApprovalLevel: '₹850,000.00 - DRM',
      currentlyWith: 'CRIS TEST 2022 SSE/ELE/UD',
      status: 'Approved',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(color: Colors.blue.shade800),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          style: IconButton.styleFrom(foregroundColor: Colors.white),
        ),
        title: const Text(
          'Forwaded/Finalized by me',
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
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: demandItems.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: NsDemandCard(
                    item: demandItems[index],
                    index: index + 1,
                  ),
                );
              },
              controller: _scrollController,
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButtons(),
    );
  }

  Widget _buildFloatingActionButtons() {
    final List<Widget> buttons = [];

    // Previous Button (only show if not at top)
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

    // Next Button (only show if not at bottom)
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

  bool _canScrollUp() {
    return _scrollController.hasClients && _scrollController.offset > 10;
  }

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
}

class NsDemandCard extends StatelessWidget {
  final DemandItem item;
  final int index;

  const NsDemandCard({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {  
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.07),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Demand No. & Date',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.blueGrey.shade700,
                          ),
                        ),
                        Text(
                          item.demandNoDate.split('\n')[0],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue.shade800,
                          ),
                        ),
                        Text(
                          item.demandNoDate.split('\n')[1],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blueGrey.shade600,
                          ),
                        ),
                        Text(
                          item.demandNoDate.split('\n')[2],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.teal.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              _buildDetailField('Indentor', item.indentor, Colors.black87),

              const SizedBox(height: 12),

              _buildDetailField(
                'Item Details',
                item.itemDetails,
                Colors.blueGrey.shade700,
              ),

              const SizedBox(height: 12),

              _buildDetailField(
                'Value & Min, Approval Level',
                item.valueMinApprovalLevel,
                Colors.green.shade600,
              ),

              const SizedBox(height: 12),

              _buildDetailField(
                'Currently With',
                item.currentlyWith,
                Colors.black87,
              ),
              const SizedBox(height: 12,),
              _buildDetailField('Status', item.status, Colors.black87,),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailField(String label, String value, Color valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.blueGrey.shade700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: valueColor,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

class DemandItem {
  final String demandNoDate;
  final String indentor;
  final String itemDetails;
  final String valueMinApprovalLevel;
  final String currentlyWith;
  final String status;

  DemandItem({
    required this.demandNoDate,
    required this.indentor,
    required this.itemDetails,
    required this.valueMinApprovalLevel,
    required this.currentlyWith,
    required this.status,
  });
}
