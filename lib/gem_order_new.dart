import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GeM Order Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade800),
        useMaterial3: true,
      ),
      home: const OrderDetailsPage(),
    );
  }
}

class OrderItem {
  final String id;
  final String productName;
  final String status;
  final String date;
  final double amount;

  OrderItem({
    required this.id,
    required this.productName,
    required this.status,
    required this.date,
    required this.amount,
  });
}

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  final TextEditingController _orderController = TextEditingController(text: "GEMC-5116877");
  bool _isSearching = false;
  bool _noResultsFound = false;
  bool _showResults = false;
  final List<OrderItem> _orderResults = [];

  @override
  void dispose() {
    _orderController.dispose();
    super.dispose();
  }

  void _searchOrder() {
    setState(() {
      _isSearching = true;
      _showResults = false;
      _noResultsFound = false;

      // Simulate search delay
      Future.delayed(const Duration(seconds: 2), () {
        // Generate mock data
        _orderResults.clear();
        if (_orderController.text.isNotEmpty) {
          // Populate with mock data if order number is provided
          _orderResults.addAll([
            OrderItem(
              id: _orderController.text,
              productName: "HP Laptop - 16GB RAM, 512GB SSD",
              status: "Delivered",
              date: "12 May 2025",
              amount: 76500.00,
            ),
            OrderItem(
              id: "${_orderController.text}-PART1",
              productName: "Microsoft Office 365 License",
              status: "Processing",
              date: "10 May 2025",
              amount: 5999.00,
            ),
            OrderItem(
              id: "${_orderController.text}-PART2",
              productName: "Wireless Mouse and Keyboard Combo",
              status: "Shipped",
              date: "11 May 2025",
              amount: 1499.00,
            ),
            OrderItem(
              id: "${_orderController.text}-PART3",
              productName: "Laptop Bag",
              status: "Delivered",
              date: "12 May 2025",
              amount: 999.00,
            ),
          ]);

          setState(() {
            _isSearching = false;
            _showResults = true;
          });
        } else {
          setState(() {
            _isSearching = false;
            _noResultsFound = true;
          });
        }
      });
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Delivered":
        return Colors.green;
      case "Shipped":
        return Colors.blue;
      case "Processing":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        title: const Text('GeM Order Details', style: TextStyle(fontWeight: FontWeight.w500)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              // Handle home button press
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Handle menu button press
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              // Order information card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Enter Order Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'GeM Order No.:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _orderController,
                        decoration: InputDecoration(
                          hintText: 'Enter GeM Order Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.blue.shade800, width: 2),
                          ),
                          prefixIcon: const Icon(Icons.receipt_long),
                          suffixIcon: _orderController.text.isNotEmpty
                              ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _orderController.clear();
                                _showResults = false;
                                _noResultsFound = false;
                              });
                            },
                          )
                              : null,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _searchOrder,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade800,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Search', style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Status area
              if (_isSearching)
                const Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Searching for order details...'),
                    ],
                  ),
                )
              else if (_noResultsFound)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.folder_open,
                        size: 80,
                        color: Colors.amber,
                      ),
                      const SizedBox(height: 8),
                      Icon(
                        Icons.search,
                        size: 40,
                        color: Colors.blue.shade800,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'No order details found',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Please check the order number and try again',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            _noResultsFound = false;
                          });
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Try Again'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.blue.shade800,
                          side: BorderSide(color: Colors.blue.shade800),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                )
              else if (_showResults)
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Order Results (${_orderResults.length})',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.filter_list),
                                onPressed: () {
                                  // Filter functionality can be added here
                                },
                                tooltip: 'Filter results',
                              ),
                            ],
                          ),
                          const Divider(),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _orderResults.length,
                            separatorBuilder: (context, index) => const Divider(),
                            itemBuilder: (context, index) {
                              final item = _orderResults[index];
                              return ListTile(
                                contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                                title: Text(
                                  item.productName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 4),
                                    Text('Order ID: ${item.id}'),
                                    const SizedBox(height: 4),
                                    Text('Date: ${item.date}'),
                                    const SizedBox(height: 4),
                                    Text(
                                      '₹${item.amount.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(item.status).withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: _getStatusColor(item.status),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    item.status,
                                    style: TextStyle(
                                      color: _getStatusColor(item.status),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  // Navigate to order details page
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Viewing details for ${item.id}'),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                // View all orders functionality
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.blue.shade800,
                                side: BorderSide(color: Colors.blue.shade800),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('View All Orders', style: TextStyle(fontSize: 14)),
                            ),
                          ),
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
}