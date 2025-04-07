import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:math';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const DemandCertificationApp());
}

class DemandCertificationApp extends StatelessWidget {
  const DemandCertificationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demand Certification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue[800],
          foregroundColor: Colors.white, // Changed to white
          elevation: 1,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white, // Changed to white
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10),
          ),
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.symmetric(vertical: 6),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      ),
      home: const DemandCertificationScreen(),
    );
  }
}

enum UserProfileMode {
  sendBackToPreviousUser,
  sendBackToInitiator,
  sendBackToIndentingGroup
}

class DemandCertificationScreen extends StatefulWidget {
  const DemandCertificationScreen({Key? key}) : super(key: key);

  @override
  _DemandCertificationScreenState createState() => _DemandCertificationScreenState();
}

class _DemandCertificationScreenState extends State<DemandCertificationScreen> {
  // Controllers
  final _demandNoController = TextEditingController(text: 'CRIS-EPS-25-00382');
  final _demandDateController = TextEditingController(text: '21/03/2025');
  final _documentDescriptionController = TextEditingController();
  final _remarksController = TextEditingController();
  final _otpController = TextEditingController();

  // State variables
  bool _isDataSaved = false;
  bool _isDataFrozen = false;
  String _selectedStage = 'Fund Certification';
  String _selectedAction = 'Forward';
  UserProfileMode? _selectedUserProfileMode;
  XFile? _uploadedFile;
  String? _generatedOTP;
  bool _isDocDescriptionExpanded = false;
  bool _isUploading = false;

  // Dropdown options
  final _stages = ['Fund Certification', 'Initial Review', 'Final Approval'];
  final _actions = ['Forward', 'Approve', 'Reject'];
  final _users = [
    'HAG CRIS MMIS',
    'John Doe',
    'Jane Smith',
    'Alice Johnson'
  ];

  late String _selectedUser;

  @override
  void initState() {
    super.initState();
    _selectedUser = _users.first;
  }

  void _saveData() {
    if (_remarksController.text.isEmpty) {
      _showErrorSnackBar('Please fill in remarks');
      return;
    }

    if (_selectedUserProfileMode == null) {
      _showErrorSnackBar('Please select a user profile mode');
      return;
    }

    // Generate OTP
    _generatedOTP = _generateOTP();

    setState(() {
      _isDataSaved = true;
      _isDataFrozen = true;
    });

    // Show confirm data screen
    _navigateToConfirmScreen();
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red[700],
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _navigateToConfirmScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ConfirmDataScreen(
          demandNo: _demandNoController.text,
          demandDate: _demandDateController.text,
          stage: _selectedStage,
          action: _selectedAction,
          documentDescription: _documentDescriptionController.text,
          fileName: _uploadedFile?.name,
          userProfileMode: _selectedUserProfileMode!,
          user: _selectedUser,
          remarks: _remarksController.text,
          onEdit: () {
            Navigator.of(context).pop();
            setState(() {
              _isDataFrozen = false;
            });
          },
          onNext: () {
            Navigator.of(context).pop();
            _showOTPDialog();
          },
        ),
      ),
    );
  }

  String _generateOTP() {
    // Generate a 6-digit OTP
    return (Random().nextInt(900000) + 100000).toString();
  }

  void _showOTPDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Enter OTP',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                      children: [
                        const TextSpan(
                          text: 'OTP has been sent to your registered mobile number for request ID ',
                        ),
                        TextSpan(
                          text: 'R235',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _otpController,
                    decoration: InputDecoration(
                      labelText: 'Enter OTP',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, letterSpacing: 8),
                  ),
                  TextButton(
                    onPressed: () {
                      // Resend OTP logic
                      _generatedOTP = _generateOTP();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('New OTP sent: $_generatedOTP'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: const Text(
                      'Resend OTP',
                      style: TextStyle(color: Colors.blue, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_otpController.text == _generatedOTP) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('OTP Verified Successfully'),
                                  backgroundColor: Colors.green,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              _resetForm();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Invalid OTP'),
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Submit', style: TextStyle(fontSize: 16)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _otpController.clear();
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Cancel', style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void _resetForm() {
    setState(() {
      _isDataSaved = false;
      _isDataFrozen = false;
      _documentDescriptionController.clear();
      _remarksController.clear();
      _selectedStage = _stages.first;
      _selectedAction = _actions.first;
      _selectedUserProfileMode = null;
      _uploadedFile = null;
      _otpController.clear();
      _isDocDescriptionExpanded = false;
    });
  }

  void _toggleDocDescription() {
    if (!_isDataFrozen) {
      setState(() {
        _isDocDescriptionExpanded = !_isDocDescriptionExpanded;
      });
    }
  }

  Future<void> _requestPermissionAndUpload() async {
    if (_isDataFrozen) return;

    setState(() {
      _isUploading = true;
    });

    try {
      // For iOS, photos permission is needed
      if (Platform.isIOS) {
        var photosStatus = await Permission.photos.request();
        if (!photosStatus.isGranted) {
          _showPermissionError();
          return;
        }
      } else {
        // For Android
        var storageStatus = await Permission.storage.request();
        if (!storageStatus.isGranted) {
          _showPermissionError();
          return;
        }
      }

      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        // Verify file exists and is readable
        final File file = File(pickedFile.path);
        if (await file.exists()) {
          setState(() {
            _uploadedFile = pickedFile;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('File uploaded: ${_uploadedFile!.name}'),
              backgroundColor: Colors.green[700],
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          );
        } else {
          _showUploadError('File could not be read');
        }
      }
    } catch (e) {
      _showUploadError('Error during upload: $e');
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  void _showPermissionError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Storage permission is required to upload files'),
        backgroundColor: Colors.red[700],
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Settings',
          textColor: Colors.white,
          onPressed: () => openAppSettings(),
        ),
      ),
    );
  }

  void _showUploadError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red[700],
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Changed to white
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Action on Demand', style: TextStyle(color: Colors.white)), // Changed to white
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Demand No and Date - Simplified without card
                Row(
                  children: [
                    Expanded(
                      child: _buildDetailColumn('Demand No', _demandNoController.text),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildDetailColumn('Demand Date', _demandDateController.text),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Stage and Action - Simplified
                Card(
                  elevation: 0.5,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        _buildDropdown(
                          label: 'Stage',
                          value: _selectedStage,
                          items: _stages,
                          onChanged: _isDataFrozen ? null : (value) {
                            setState(() => _selectedStage = value!);
                          },
                        ),
                        const SizedBox(height: 10),
                        _buildDropdown(
                          label: 'Action',
                          value: _selectedAction,
                          items: _actions,
                          onChanged: _isDataFrozen ? null : (value) {
                            setState(() => _selectedAction = value!);
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Document Description and Upload - Simplified
                Card(
                  elevation: 0.5,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Document Description and Upload buttons
                        Row(
                          children: [
                            // Document Description
                            Expanded(
                              child: GestureDetector(
                                onTap: _isDataFrozen ? null : _toggleDocDescription,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey[300]!),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          _documentDescriptionController.text.isEmpty
                                              ? 'Doc Description'
                                              : _documentDescriptionController.text,
                                          style: TextStyle(
                                            color: _documentDescriptionController.text.isEmpty
                                                ? Colors.grey[700]
                                                : Colors.black87,
                                            fontSize: 14,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Upload Button
                            Expanded(
                              child: GestureDetector(
                                onTap: _isUploading || _isDataFrozen ? null : _requestPermissionAndUpload,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: _isUploading ? Colors.grey[200] : Colors.grey[50],
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey[300]!),
                                  ),
                                  child: Text(
                                    _isUploading ? 'Uploading...' : 'Upload (Optional)',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Show text field when expanded
                        if (_isDocDescriptionExpanded)
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: TextField(
                              controller: _documentDescriptionController,
                              decoration: InputDecoration(
                                labelText: 'Document Description',
                                labelStyle: const TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: Colors.grey[50],
                              ),
                              enabled: !_isDataFrozen,
                              maxLines: 2,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),

                        // Uploaded File Information
                        if (_uploadedFile != null)
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _uploadedFile!.name,
                                    style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                if (!_isDataFrozen)
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _uploadedFile = null;
                                      });
                                    },
                                    child: Text(
                                      'Remove',
                                      style: TextStyle(
                                        color: Colors.blue[700],
                                        fontSize: 14,
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

                const SizedBox(height: 8),

                // User Profile Mode - With added header
                Card(
                  elevation: 0.5,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Added "Select User" heading
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Select User',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        // Horizontal scrolling buttons
                        SizedBox(
                          height: 40,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              _buildUserProfileModeButton(UserProfileMode.sendBackToPreviousUser),
                              const SizedBox(width: 10),
                              _buildUserProfileModeButton(UserProfileMode.sendBackToInitiator),
                              const SizedBox(width: 10),
                              _buildUserProfileModeButton(UserProfileMode.sendBackToIndentingGroup),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // User Selection - Simplified
                Card(
                  elevation: 0.5,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: _buildDropdown(
                      label: 'User',
                      value: _selectedUser,
                      items: _users,
                      onChanged: _isDataFrozen ? null : (value) {
                        setState(() => _selectedUser = value!);
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Remarks - Reduced size
                Card(
                  elevation: 0.5,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: _remarksController,
                      decoration: InputDecoration(
                        hintText: 'Enter your remarks here...',
                        labelText: 'Remarks',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      enabled: !_isDataFrozen,
                      maxLines: 2, // Reduced from 3 to 2
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),

                // Action Buttons - Swapped positions of Reset and Preview
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    children: [
                      // Reset button now first
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _resetForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isDataFrozen ? Colors.blue : Colors.grey,
                            foregroundColor: Colors.white, // Text in white
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Reset', style: TextStyle(fontSize: 16)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Preview button now second
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _isDataFrozen ? null : _saveData,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            foregroundColor: Colors.white, // Preview text in white
                          ),
                          child: const Text('Preview', style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailColumn(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?)? onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item, style: const TextStyle(fontSize: 14)),
        );
      }).toList(),
      onChanged: onChanged,
      style: const TextStyle(fontSize: 14, color: Colors.black87),
      isExpanded: true,
    );
  }

  Widget _buildUserProfileModeButton(UserProfileMode mode) {
    final buttonText = _getUserProfileModeText(mode);
    final isSelected = _selectedUserProfileMode == mode;

    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: OutlinedButton(
        onPressed: _isDataFrozen ? null : () {
          setState(() {
            _selectedUserProfileMode = mode;
          });
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue[50] : Colors.white,
          foregroundColor: isSelected ? Colors.blue[700] : Colors.grey[700],
          side: BorderSide(color: isSelected ? Colors.blue[300]! : Colors.grey[300]!),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  String _getUserProfileModeText(UserProfileMode mode) {
    switch (mode) {
      case UserProfileMode.sendBackToPreviousUser:
        return 'Send Back to Previous User';
      case UserProfileMode.sendBackToInitiator:
        return 'Send Back to Initiator';
      case UserProfileMode.sendBackToIndentingGroup:
        return 'Send Back to Indenting Group';
    }
  }

  @override
  void dispose() {
    _demandNoController.dispose();
    _demandDateController.dispose();
    _documentDescriptionController.dispose();
    _remarksController.dispose();
    _otpController.dispose();
    super.dispose();
  }
}

// ConfirmDataScreen with improved simplicity and elegan
// Define DetailItem class at the top level
class DetailItem {
  final String label;
  final String value;
  final bool isMultiline;

  DetailItem({
    required this.label,
    required this.value,
    this.isMultiline = false,
  });
}

class ConfirmDataScreen extends StatelessWidget {
  final String demandNo;
  final String demandDate;
  final String stage;
  final String action;
  final String documentDescription;
  final String? fileName;
  final UserProfileMode userProfileMode;
  final String user;
  final String remarks;
  final VoidCallback onEdit;
  final VoidCallback onNext;

  const ConfirmDataScreen({
    Key? key,
    required this.demandNo,
    required this.demandDate,
    required this.stage,
    required this.action,
    required this.documentDescription,
    this.fileName,
    required this.userProfileMode,
    required this.user,
    required this.remarks,
    required this.onEdit,
    required this.onNext,
  }) : super(key: key);

  String _getUserProfileModeText(UserProfileMode mode) {
    switch (mode) {
      case UserProfileMode.sendBackToPreviousUser:
        return 'Previous User';
      case UserProfileMode.sendBackToInitiator:
        return 'Initiator';
      case UserProfileMode.sendBackToIndentingGroup:
        return 'Indenting Group';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Data'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Compact Info Banner with Icon
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: Colors.blue[700],
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Please review the information carefully',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue[700],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Data Cards Section
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Demand and Process Information - Combined
                      _buildSectionCard(
                        title: 'Demand Details',
                        items: [
                          [
                            DetailItem(label: 'Demand No', value: demandNo),
                            DetailItem(label: 'Stage', value: stage),
                          ],
                          [
                            DetailItem(label: 'Demand Date', value: demandDate),
                            DetailItem(label: 'Action', value: action),
                          ],
                        ],
                        isCompact: true,
                      ),

                      const SizedBox(height: 12),

                      // Document Information Card (only show if there's content)
                      if (documentDescription.isNotEmpty || fileName != null)
                        _buildSectionCard(
                          title: 'Document Details',
                          items: [
                            [
                              if (documentDescription.isNotEmpty)
                                DetailItem(label: 'Description', value: documentDescription),
                            ],
                            [
                              if (fileName != null)
                                DetailItem(label: 'File', value: fileName!),
                            ],
                          ],
                          isCompact: true,
                        ),

                      if (documentDescription.isNotEmpty || fileName != null)
                        const SizedBox(height: 12),

                      // Forwarding Information Card
                      _buildSectionCard(
                        title: 'Forwarding Details',
                        items: [
                          [
                            DetailItem(
                                label: 'Forward To',
                                value: _getUserProfileModeText(userProfileMode)
                            ),
                            DetailItem(label: 'User', value: user),
                          ],
                        ],
                        isCompact: true,
                      ),

                      const SizedBox(height: 12),

                      // Remarks Section as a separate card
                      _buildSectionCard(
                        title: 'Remarks',
                        items: [
                          [
                            DetailItem(
                                label: '',  // Empty label since the card title already says "Remarks"
                                value: remarks.isNotEmpty ? remarks : 'No remarks available',
                                isMultiline: true
                            ),
                          ],
                        ],
                        isCompact: false,
                        showDivider: false,
                      ),
                    ],
                  ),
                ),
              ),

              // Action Buttons
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: const Text('Edit', style: TextStyle(fontSize: 15)),
                        onPressed: onEdit,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.grey[600],
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        child: const Text('Confirm', style: TextStyle(fontSize: 15)),
                        onPressed: onNext,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue[700],
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
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
    );
  }

  // Creates a section card with title and multiple rows of items
  Widget _buildSectionCard({
    required String title,
    required List<List<DetailItem>> items,
    bool isCompact = false,
    bool showDivider = true,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
          ),

          // Optional Divider
          if (showDivider)
            const Divider(height: 1, thickness: 1, indent: 12, endIndent: 12),

          // Items in rows
          isCompact
              ? _buildCompactDetailItems(items)
              : Column(
            children: items.map((rowItems) =>
                Column(children: rowItems.map((item) => _buildDetailItemRow(item)).toList())
            ).toList(),
          ),
        ],
      ),
    );
  }

  // Creates a compact grid layout for items
  Widget _buildCompactDetailItems(List<List<DetailItem>> items) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: items.map((rowItems) {
          // Filter out any multiline items to handle separately
          final multilineItems = rowItems.where((item) => item
              .isMultiline).toList();
          final standardItems = rowItems.where((item) => !item
              .isMultiline).toList();

          return Column(
            children: [
              // Standard items in a row
              if (standardItems.isNotEmpty)
                Row(
                  children: standardItems.map((item) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.label,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.value,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[900],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),

              // Handle multiline items
              ...multilineItems.map((item) => _buildDetailItemRow(item)),

              // Add spacing between rows
              if (items.indexOf(rowItems) < items.length - 1)
                const SizedBox(height: 16),
            ],
          );
        }).toList(),
      ),
    );
  }

  // Creates a row for each detail item
  Widget _buildDetailItemRow(DetailItem item) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label (only show if not empty)
          if (item.label.isNotEmpty)
            Text(
              item.label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),

          // Add space only if there's a label
          if (item.label.isNotEmpty)
            const SizedBox(height: 4),

          // Value
          Text(
            item.value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: item.isMultiline ? FontWeight.normal : FontWeight.w600,
              color: Colors.grey[900],
              height: item.isMultiline ? 1.4 : 1.2,
            ),
          ),
        ],
      ),
    );
  }
}