import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardTab extends StatefulWidget {
  const DashboardTab({super.key});

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final _demandNoController = TextEditingController();
  final _itemDescriptionController = TextEditingController();
  final _fromDateController = TextEditingController();
  final _toDateController = TextEditingController();

  // Dropdown values
  String? _selectedStatus = 'All';
  String? _selectedIndentor = 'All';
  String? _selectedConsignee = 'All';

  // Date values
  DateTime? _fromDate;
  DateTime? _toDate;

  // Dropdown options
  final List<String> _statusOptions = [
    'All',
    'Pending',
    'Approved',
    'Rejected',
    'In Progress',
    'Completed',
  ];

  final List<String> _indentorOptions = [
    'All',
    'SSE/EPS/UD',
    'SSE/ELE/UD',
    'SSE/CIV/UD',
    'SSE/SIG/UD',
    'SSE/STO/UD',
    'DEN/EPS',
    'DEN/ELE',
  ];

  final List<String> _consigneeOptions = [
    'All',
    'Central Store',
    'Local Store',
    'Depot Store',
    'Workshop Store',
    'Signal Store',
    'Electrical Store',
  ];

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
    _demandNoController.dispose();
    _itemDescriptionController.dispose();
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

  void _resetForm() {
    setState(() {
      _demandNoController.clear();
      _itemDescriptionController.clear();
      _selectedStatus = 'All';
      _selectedIndentor = 'All';
      _selectedConsignee = 'All';

      // Reset to default dates
      _toDate = DateTime.now();
      _fromDate = DateTime.now().subtract(const Duration(days: 30));
      _fromDateController.text = DateFormat('dd-MM-yyyy').format(_fromDate!);
      _toDateController.text = DateFormat('dd-MM-yyyy').format(_toDate!);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.blue.shade700,
              size: 20,
            ),
            const SizedBox(width: 12),
            const Text(
              'Form has been reset successfully',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        backgroundColor: Colors.blue.shade50,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _submitForm() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NSDemandDashboardScreen()),
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
            // Filters Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dashboard Filters',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Status and Demand No Row
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _selectedStatus,
                            isExpanded: true,
                            decoration: const InputDecoration(
                              labelText: 'Status',
                              prefixIcon: Icon(Icons.flag_outlined),
                              isDense: true,
                            ),
                            items: _statusOptions.map((String status) {
                              return DropdownMenuItem<String>(
                                value: status,
                                child: Text(
                                  status,
                                  style: const TextStyle(fontSize: 14),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedStatus = newValue;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _demandNoController,
                            decoration: const InputDecoration(
                              labelText: 'Demand No.',
                              prefixIcon: Icon(Icons.numbers_outlined),
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Indentor and Consignee Row
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _selectedIndentor,
                            isExpanded: true,
                            decoration: const InputDecoration(
                              labelText: 'Indentor',
                              prefixIcon: Icon(Icons.person_outline),
                              isDense: true,
                            ),
                            items: _indentorOptions.map((String indentor) {
                              return DropdownMenuItem<String>(
                                value: indentor,
                                child: Text(
                                  indentor,
                                  style: const TextStyle(fontSize: 14),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedIndentor = newValue;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _selectedConsignee,
                            isExpanded: true,
                            decoration: const InputDecoration(
                              labelText: 'Consignee',
                              prefixIcon: Icon(Icons.business_outlined),
                              isDense: true,
                            ),
                            items: _consigneeOptions.map((String consignee) {
                              return DropdownMenuItem<String>(
                                value: consignee,
                                child: Text(
                                  consignee,
                                  style: const TextStyle(fontSize: 14),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedConsignee = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Item Description
                    TextFormField(
                      controller: _itemDescriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Item Description',
                        prefixIcon: Icon(Icons.description_outlined),
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 16),

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
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _resetForm,
                    icon: const Icon(Icons.restart_alt_rounded),
                    label: const Text('Reset'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: Colors.blue.shade600, width: 1.5),
                      foregroundColor: Colors.blue.shade600,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
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
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NSDemandDashboardScreen extends StatefulWidget {
  const NSDemandDashboardScreen({super.key});

  @override
  State<NSDemandDashboardScreen> createState() =>
      _NSDemandDashboardScreenState();
}

class _NSDemandDashboardScreenState extends State<NSDemandDashboardScreen> {
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
      status: 'Demand Initiated',
    ),
    DemandItem(
      demandNoDate: 'IREPS-36640-25-00167\nDt.2025-06-06\n809809',
      indentor: 'CRIS TEST 2022 SSE/EPS/UD',
      itemDetails: 'Item No.1: Tender Axle Boxes and det.... [Qty: Set]',
      valueMinApprovalLevel: '₹0.00 - Jr. Scale',
      currentlyWith: 'CRIS TEST 2022 SSE/EPS/UD',
      status: 'Pending',
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
          'Dashboard',
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
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: item.status == 'Approved'
                          ? const Color.fromRGBO(232, 245, 233, 1)
                          : item.status == 'Pending'
                          ? Colors.orange.shade50
                          : Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item.status,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: item.status == 'Approved'
                            ? Colors.green.shade700
                            : item.status == 'Pending'
                            ? Colors.orange.shade700
                            : Colors.blue.shade700,
                      ),
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
