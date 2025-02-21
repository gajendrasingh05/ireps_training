import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRIS MMIS App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SearchDemandsScreen(),
    );
  }
}

class SearchDemandsScreen extends StatefulWidget {
  const SearchDemandsScreen({Key? key}) : super(key: key);

  @override
  State<SearchDemandsScreen> createState() => _SearchDemandsScreenState();
}

class _SearchDemandsScreenState extends State<SearchDemandsScreen> with SingleTickerProviderStateMixin {
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now().add(const Duration(days: 365));
  String selectedDepartment = 'All';
  String selectedStatus = '-1';
  String? demandNo;
  bool isNewCRIS = true;

  // Added status options map for label display
  final Map<String, String> statusLabels = {
    "-1": "All",
    "0": "Initiated (Draft)",
    "1": "Under Fund Certification",
    "2": "Fund Certification granted",
    "3": "Forwarded for PAC Approval",
    "4": "PAC Approved",
    "9": "Under Technical Vetting",
    "10": "Technical Vetting done",
    "7": "Under Finance Concurrence",
    "8": "Finance Concurrence accorded",
    "14": "Under Purchase Review",
    "15": "Purchase Review Approved",
    "11": "Under Process",
    "5": "Under Approval",
    "6": "Approved & Forwarded to Purchase",
    "13": "Returned by Purchase Unit",
    "12": "Dropped"
  };

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
  }

  void resetForm() {
    _animationController.reverse().then((_) {
      setState(() {
        fromDate = DateTime.now();
        toDate = DateTime.now().add(const Duration(days: 365));
        selectedDepartment = 'All';
        selectedStatus = '-1';
        demandNo = null;
        isNewCRIS = true;
      });
      _animationController.forward();
    });
    Feedback.forTap(context);
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final initialDate = isFromDate ? fromDate : toDate;
    final firstDate = isFromDate
        ? DateTime(2020)
        : fromDate;
    final lastDate = isFromDate
        ? toDate.isBefore(DateTime(2026)) ? toDate : DateTime(2026)
        : DateTime(2026);

    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme.copyWith(
      primary: Colors.blue.shade800,
      onPrimary: Colors.white,
      surface: Colors.white,
      onSurface: Colors.blue.shade800,
    );

    final date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: colorScheme,
            dialogBackgroundColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue.shade800,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      setState(() {
        if (isFromDate) {
          fromDate = date;
          if (toDate.isBefore(fromDate)) {
            toDate = fromDate.add(const Duration(days: 1));
          }
        } else {
          toDate = date;
        }
      });
      Feedback.forTap(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Demands',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
          onPressed: () {
            Feedback.forTap(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white, size: 22),
            onPressed: () {
              Feedback.forTap(context);
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[100],
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - AppBar().preferredSize.height - 32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Please select demand type:',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildDemandTypeSelector(),
                      const SizedBox(height: 16),
                      const Text(
                        'Demand Date:',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildDateSelectors(isSmallScreen),
                      const SizedBox(height: 16),
                      const Text(
                        'Department',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildDropdown(
                        icon: Icons.account_balance,
                        label: 'Select Department',
                        value: selectedDepartment,
                        items: ['All', 'Finance', 'Operations', 'HR', 'IT'],
                        onChanged: (value) {
                          setState(() {
                            selectedDepartment = value ?? 'All';
                          });
                          Feedback.forTap(context);
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Demand Status',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildStatusDropdown(),
                      const SizedBox(height: 16),
                      const Center(
                        child: Text(
                          'OR',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Demand No.',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildDemandNumberField(),
                      const SizedBox(height: 24),
                      _buildActionButtons(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusDropdown() {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: ListTile(
          dense: true,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          leading: Icon(Icons.list, color: Colors.blue.shade800, size: 20),
          title: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedStatus,
                isExpanded: true,
                icon: AnimatedRotation(
                  turns: 0,
                  duration: const Duration(milliseconds: 300),
                  child: const Icon(Icons.arrow_drop_down, size: 20),
                ),
                style: const TextStyle(fontSize: 14, color: Colors.black),
                dropdownColor: Colors.white,
                borderRadius: BorderRadius.circular(8),
                menuMaxHeight: 300,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedStatus = newValue ?? '-1';
                  });
                  Feedback.forTap(context);
                },
                items: statusLabels.entries.map<DropdownMenuItem<String>>((entry) {
                  return DropdownMenuItem<String>(
                    value: entry.key,
                    child: Text(
                      entry.value,
                      style: const TextStyle(fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDemandTypeSelector() {
    return Row(
      children: [
        Expanded(
          child: _buildDemandTypeButton(
            label: 'Old CRIS MMIS',
            isSelected: !isNewCRIS,
            onTap: () {
              setState(() {
                isNewCRIS = false;
              });
              Feedback.forTap(context);
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildDemandTypeButton(
            label: 'New CRIS MMIS',
            isSelected: isNewCRIS,
            onTap: () {
              setState(() {
                isNewCRIS = true;
              });
              Feedback.forTap(context);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDemandTypeButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Hero(
      tag: 'demand_type_$label',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          splashColor: Colors.blue.shade100,
          child: Ink(
            height: 50,
            decoration: BoxDecoration(
              color: isSelected
                  ? (label.contains('New') ? Colors.blue.shade50 : Colors.grey[300])
                  : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected
                    ? (label.contains('New') ? Colors.blue.shade400 : Colors.grey.shade400)
                    : Colors.grey.shade300,
                width: 1.5,
              ),
              boxShadow: isSelected ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                )
              ] : null,
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected
                      ? (label.contains('New') ? Colors.blue.shade700 : Colors.grey.shade700)
                      : Colors.grey.shade700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelectors(bool isSmallScreen) {
    if (isSmallScreen) {
      return Column(
        children: [
          _buildDateField(
            label: 'From',
            date: fromDate,
            onTap: () => _selectDate(context, true),
          ),
          const SizedBox(height: 8),
          _buildDateField(
            label: 'To',
            date: toDate,
            onTap: () => _selectDate(context, false),
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          child: _buildDateField(
            label: 'From',
            date: fromDate,
            onTap: () => _selectDate(context, true),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildDateField(
            label: 'To',
            date: toDate,
            onTap: () => _selectDate(context, false),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime date,
    required VoidCallback onTap,
  }) {
    return Hero(
      tag: 'date_${label}_${date.millisecondsSinceEpoch}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          splashColor: Colors.blue.shade100,
          child: Ink(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.blue.shade200,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                )
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    formatDate(date),
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.blue.shade800,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.calendar_today,
                    color: Colors.blue.shade800,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required IconData icon,
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: ListTile(
          dense: true,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          leading: Icon(icon, color: Colors.blue.shade800, size: 20),
          title: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                icon: AnimatedRotation(
                  turns: 0,
                  duration: const Duration(milliseconds: 300),
                  child: const Icon(Icons.arrow_drop_down, size: 20),
                ),
                hint: Text(label, style: const TextStyle(fontSize: 14)),
                style: const TextStyle(fontSize: 14, color: Colors.black),
                dropdownColor: Colors.white,
                borderRadius: BorderRadius.circular(8),
                menuMaxHeight: 300,
                onChanged: onChanged,
                items: items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDemandNumberField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Enter Demand No.',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue.shade400, width: 2),
        ),
        filled: true,
        fillColor: Colors.blue.shade50,
        hintStyle: const TextStyle(fontSize: 13),
        prefixIcon: Icon(Icons.numbers, size: 18, color: Colors.blue.shade700),
      ),
      style: const TextStyle(fontSize: 13),
      onChanged: (value) {
        setState(() {
          demandNo = value.isEmpty ? null : value;
        });
      },
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        _buildActionButton(
          "Submit",
          Colors.blue.shade800,
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Processing Search...'),
                  backgroundColor: Colors.blue.shade700,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(10),
                ),
              );
            }
            Feedback.forTap(context);
          },
        ),
        const SizedBox(height: 12),
        _buildActionButton(
          "Reset",
          Colors.blue.shade400,
          onPressed: resetForm,
          isOutlined: true,
        ),
      ],
    );
  }

  Widget _buildActionButton(
      String text,
      Color color, {
        VoidCallback? onPressed,
        bool isOutlined = false,
      }) {
    return SizedBox(
      width: double.infinity,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isOutlined ? Colors.white : color,
            foregroundColor: isOutlined ? color : Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: isOutlined ? BorderSide(color: color, width: 1.5) : BorderSide.none,
            ),
            elevation: isOutlined ? 0 : 2,
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: isOutlined ? color : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}