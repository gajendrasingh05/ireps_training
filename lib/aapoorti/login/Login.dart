import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_app/aapoorti/common/AapoortiConstants.dart';
import 'package:flutter_app/aapoorti/common/AapoortiUtilities.dart';
import 'package:flutter_app/aapoorti/provider/aapoorti_language_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/auth_service.dart';
import 'package:local_auth/local_auth.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home/UserHome.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/udm/screens/login_screen.dart';
import 'package:crypto/crypto.dart';

import 'home/newpage.dart';

class LoginActivity extends StatefulWidget {
  String logoutsucc;
  final GlobalKey<ScaffoldState> _scaffoldkey;
  LoginActivity(this._scaffoldkey, this.logoutsucc);
  @override
  State<LoginActivity> createState() => _LoginActivityState();
}

class _LoginActivityState extends State<LoginActivity> {
  bool _obscureText = true;
  bool _rememberMe = false;
  bool showbiomteric = false;
  bool _enableBiometric = false;
  final _passwordController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String _selectedLoginType = 'IREPS';
  // Add selected days variable
  int _selectedDays = 5;
  // Add day options
  final List<int> _dayOptions = [5, 7, 10];
  var jsonResult = null;
  var errorcode = 0;
  TextStyle style = TextStyle(fontFamily: 'Roboto', fontSize: 15.0);
  var email, pin;
  var connectivityresult;
  ProgressDialog? pr;
  bool? _check;
  bool value1 = true;
  String? checkbox;
  BuildContext? context1;
  String? logoutsucc;
  bool visibilty = false;
  Future<bool> checkBiometricAvailable() async {
    final LocalAuthentication auth = LocalAuthentication();
    bool canCheckBiometrics = false;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
      return canCheckBiometrics;
    } on PlatformException catch (e) {
      debugPrint("Error checking biometrics: $e");
      return false;
    }
  }

  // Authenticate using biometrics
  Future<bool> authenticateWithBiometrics() async {
    final LocalAuthentication auth = LocalAuthentication();
    bool authenticated = false;

    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      return authenticated;
    } on PlatformException catch (e) {
      debugPrint("Error authenticating: $e");
      return false;
    }
  }

  // Save user credentials securely for biometric login
  Future<void> saveCredentialsForBiometric() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (email != null && pin != null && email.isNotEmpty && pin.isNotEmpty) {
      await prefs.setString('stored_email', email);
      await prefs.setString('stored_pin', pin);
      await prefs.setString('stored_usertype', userType);
      await prefs.setBool('isbiometricenabled', true);
      await prefs.setBool('is loggedin', true);

      debugPrint("Biometric credentials saved for: $email with userType: $userType");
    }
  }
  // Future<void> loginWithBiometrics() async {
  //   bool authenticated = await authenticateWithBiometrics();
  //
  //   if (authenticated) {
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String? storedEmail = prefs.getString('stored_email');
  //     String? storedPin = prefs.getString('stored_pin');
  //
  //     if (storedEmail != null && storedPin != null) {
  //       AapoortiUtilities.getProgressDialog(pr!);
  //       email = storedEmail;
  //       pin = storedPin;
  //       bool loginSuccess = await _callLoginWebService(email, pin);
  //
  //       if (loginSuccess) {
  //         AapoortiConstants.ans = "true";
  //         Navigator.pop(context);
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => UserHome(userType, email)));
  //       } else {
  //         AapoortiUtilities.stopProgress(pr!);
  //         AapoortiUtilities.showInSnackBar(context, 'Invalid Credentials!');
  //       }
  //     } else {
  //       AapoortiUtilities.showInSnackBar(
  //           context, "Please login with email and PIN first to use biometrics");
  //     }
  //   }
  // }

  Future<void> loginWithBiometrics() async {
    bool authenticated = await AuthService().authenticateLocally();

    if (authenticated) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? storedEmail = prefs.getString('stored_email');
      String? storedPin = prefs.getString('stored_pin');
      String? storedUserType = prefs.getString('stored_usertype');

      if (storedEmail != null && storedPin != null && storedUserType != null) {
        AapoortiUtilities.getProgressDialog(pr!);

        // Set the credentials for login
        email = storedEmail;
        pin = storedPin;
        userType = storedUserType;

        // Call the login web service with stored credentials
        bool loginSuccess = await _callLoginWebService(email, pin);

        if (loginSuccess) {
          AapoortiConstants.ans = "true";
          AapoortiUtilities.stopProgress(pr!);

          // Set login status
          await prefs.setBool("is loggedin", true);
          AapoortiUtilities.loggedin = true;

          // Navigate to UserHome with the stored credentials
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => UserHome(userType, email)));
        } else {
          AapoortiUtilities.stopProgress(pr!);
          AapoortiUtilities.showInSnackBar(context, 'Biometric login failed. Please login with credentials.');

          // If web service fails, disable biometric and clear stored credentials
          await prefs.setBool('isbiometricenabled', false);
          await prefs.remove('stored_email');
          await prefs.remove('stored_pin');
          await prefs.remove('stored_usertype');

          setState(() {
            showbiomteric = false;
            _enableBiometric = false;
          });
        }
      } else {
        AapoortiUtilities.showInSnackBar(
            context, "No saved credentials found. Please login with email and PIN first.");
      }
    } else {
      AapoortiUtilities.showInSnackBar(
          context, "Biometric authentication failed or was cancelled.");
    }
  }

  Container _buildRememberMeSection(AapoortiLanguageProvider language) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        children: [
          Checkbox(
            value: _rememberMe,
            onChanged: (value) {
              setState(() {
                _rememberMe = value ?? false;
              });
            },
          ),
          Text(language.text('slcf')),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: _selectedDays,
                items: _dayOptions.map((days) {
                  return DropdownMenuItem<int>(
                    value: days,
                    child: Text('$days ${language.text('dayskey')}'),
                  );
                }).toList(),
                onChanged: _rememberMe
                    ? (value) {
                        setState(() {
                          _selectedDays = value!;
                        });
                      }
                    : null,
                style: TextStyle(
                  color: _rememberMe ? Colors.black87 : Colors.grey,
                  fontSize: 14,
                ),
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
  void initState() {
    super.initState();
    final Future<SharedPreferences> prefsF = SharedPreferences.getInstance();
    prefsF.then((SharedPreferences prefs) {
      bool isloggedin = prefs.getBool("is loggedin") ?? false;
      bool isbiometricenabled = prefs.getBool("isbiometricenabled") ?? false;

      // Check if we have stored credentials
      String? storedEmail = prefs.getString('stored_email');
      String? storedUserType = prefs.getString('stored_usertype');

      setState(() {
        showbiomteric = isbiometricenabled && storedEmail != null;
        _enableBiometric = isbiometricenabled;
      });

      // Check if biometrics are available when the screen loads
      if (isbiometricenabled) {
        checkBiometricAvailable().then((available) {
          if (!available && _enableBiometric) {
            setState(() {
              _enableBiometric = false;
              showbiomteric = false;
            });
            // Update saved preferences
            prefs.setBool("isbiometricenabled", false);
            AapoortiUtilities.showInSnackBar(context,
                "Biometric authentication is not available on this device");
          }
        });
      }
    });

    // Rest of your existing initState code...
    Future.delayed(Duration.zero, () {
      setState(() {
        logoutsucc = widget.logoutsucc;
        pr = ProgressDialog(context);
        debugPrint('logoutsucc' + widget.logoutsucc);
        debugPrint("init ==" + AapoortiConstants.loginUserEmailID);
      });
    });

    _passwordController.addListener(() {
      if (_passwordController.text.length >= 6) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void showDialogBox(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: Container(
            height: MediaQuery.of(context).size.height * 0.32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                    "For better experience to users, login on APP is allowed using Email ID & PIN.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Text(
                  "Please visit www.ireps.gov.in to create/reset your PIN and then try to login using Email ID and PIN.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Text(
                  "If successfully logged in using Email ID & PIN, please ignore this.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              color: Colors.blue,
              child: Text(
                "OKAY",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    });
  }

  Future<void> _enableloginBottomSheet(
      BuildContext context, AapoortiLanguageProvider language) async {
    return await showModalBottomSheet(
        context: context,
        constraints:
            BoxConstraints.loose(Size(MediaQuery.of(context).size.width, 415)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        clipBehavior: Clip.hardEdge,
        builder: (_) {
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12.0)),
                        alignment: Alignment.center,
                        child: Icon(Icons.clear, size: 15, color: Colors.white),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            " ${language.text('note')}: ",
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.normal,
                                color: Colors.red),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(left: 5.0)),
                          Expanded(
                              child:
                                  Text("1. ${language.text('loginfeature')}.",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                      ))),
                          Padding(padding: EdgeInsets.only(left: 20.0)),
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(35.0, 0.0, 30.0, 10.0)),
                      Row(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(left: 5.0)),
                          Text("2. ${language.text('lfama')}:\n",
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                              )),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                              padding:
                                  EdgeInsets.fromLTRB(30.0, 10.0, 0.0, 10.0)),
                          //Padding(padding: new EdgeInsets.only(top:1.0)),
                          RichText(
                            text: TextSpan(
                              text: language.text('vendor'),
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.blueGrey,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '                      Launched',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[500],
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                              padding:
                                  EdgeInsets.fromLTRB(30.0, 10.0, 0.0, 10.0)),
                          RichText(
                            text: TextSpan(
                              text: language.text('rut'),
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.blueGrey,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '     Launched',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[500],
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                              padding:
                                  EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 10.0)),
                          RichText(
                            text: TextSpan(
                              text: language.text('ruu'),
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.blueGrey),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '        Launched',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green[500])),
                              ],
                            ),
                          ), /*//Padding(padding: new EdgeInsets.only(top:1.0)),
                            Text("Bidder",style: TextStyle(fontSize:15.0,color: Colors.blueGrey,)),*/
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(8.0)),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "   ${language.text('telafi')}: ",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal),
                            ),
                          )
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(35.0, 0.0, 30.0, 10.0)),
                      //new Padding(padding: new EdgeInsets.fromLTRB(35.0, 0.0, 30.0, 20.0)),
                      Row(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(left: 30.0)),
                          Text("1. ${language.text('websitelink')}",
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.blueGrey,
                              )),
                          Padding(padding: EdgeInsets.only(left: 35.0)),
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(35.0, 0.0, 30.0, 10.0)),
                      Row(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(left: 30.0)),
                          Expanded(
                            child: Text('2. ${language.text('lafi')}',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.blueGrey,
                                )),
                          ),
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(35.0, 0.0, 30.0, 10.0)),
                      Row(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(left: 30.0)),
                          Expanded(
                              child: Text("3. ${language.text('ctp')}.",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.blueGrey,
                                  ))),
                        ],
                      ),
                      //Padding(padding: EdgeInsets.fromLTRB(35.0, 0.0, 30.0, 20.0)),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> _resetpinBottomSheet(
      BuildContext context, AapoortiLanguageProvider language) async {
    return await showModalBottomSheet(
        context: context,
        constraints:
            BoxConstraints.loose(Size(MediaQuery.of(context).size.width, 200)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        clipBehavior: Clip.hardEdge,
        builder: (_) {
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("${language.text('toresetpin')}: ",
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.normal)),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12.0)),
                            alignment: Alignment.center,
                            child: Icon(Icons.clear,
                                size: 15, color: Colors.white),
                          ))
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(35.0, 0.0, 30.0, 10.0)),
                  Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 10.0)),
                      Text("1. ${language.text('websitelink')}",
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.blueGrey,
                          )),
                      Padding(padding: EdgeInsets.only(left: 35.0)),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(35.0, 0.0, 30.0, 10.0)),
                  Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 10.0)),
                      Expanded(
                        child: Text("2. ${language.text('goto')}",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.blueGrey,
                            )),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(35.0, 0.0, 30.0, 10.0)),
                  Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 10.0)),
                      Expanded(
                          child: Text("3. ${language.text('selresetpin')}.",
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.blueGrey))),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  String? hashPassOutput;
  String? hash2;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userType = "";
  Future<bool> _callLoginWebService(String email, String pin) async {
    debugPrint(
        'Function called ' + email.toString() + "-------" + pin.toString());
    try {
      var input = email + "#" + pin;
      debugPrint(input);
      var hashPassInput = <String, String>{"input": input};
      var bytes = utf8.encode(input);
      hash2 = sha256.convert(bytes).toString();
      debugPrint(hash2);
      AapoortiConstants.hash = '' + "~" + hash2!;
      var random = Random.secure();
      String ctoken = random.nextInt(100).toString();

      for (var i = 1; i < 10; i++) {
        ctoken = ctoken + random.nextInt(100).toString();
      }
      //JSON VALUES FOR POST PARAM
      Map<String, dynamic> urlinput = {
        "userId": "$email",
        "pass": "" + "~$hash2",
        "cToken": "$ctoken",
        "sToken": "",
        "os": "Flutter~ios",
        "token4": "",
        "token5": ""
      };
      // Map<String, dynamic>  urlinput = {"userId":"$email","pass":"$hashPassOutput","cToken":"$ctoken","sToken":"","os":"Flutter","token4":"","token5":""};
      String urlInputString = json.encode(urlinput);
      debugPrint("login url input ${urlinput.toString()}");
      //NAME FOR POST PARAM
      String paramName = 'UserLogin';
      //Form Body For URL
      String formBody =
          paramName + '=' + Uri.encodeQueryComponent(urlInputString);
      var url = AapoortiConstants.webServiceUrl + 'Login/UserLogin';
      debugPrint("url = " + url);
      final response = await http.post(Uri.parse(url),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded"
          },
          body: formBody,
          encoding: Encoding.getByName("utf-8"));
      jsonResult = json.decode(response.body);
      debugPrint("form body = " + json.encode(formBody).toString());
      debugPrint("json result = " + jsonResult.toString());
      debugPrint("response code = " + response.statusCode.toString());
      AapoortiUtilities.stopProgress(pr!);
      if (response.statusCode == 200) {
        debugPrint("Error code " + jsonResult[0]['ErrorCode'].toString());
        if (jsonResult[0]['ErrorCode'] == null) {
          AapoortiConstants.loginUserEmailID = email;
          AapoortiUtilities.setUserDetails(
              jsonResult); //To save user details in shared object
          userType = jsonResult[0]['USER_TYPE'].toString();
          return true;
        } else
          return false;
      } else
        return false;
    } on PlatformException catch (e) {
      AapoortiUtilities.stopProgress(pr!);
      AapoortiUtilities.showInSnackBar(
          context, " ");
    } on FormatException catch (ex) {
      AapoortiUtilities.stopProgress(pr!);
      AapoortiUtilities.showInSnackBar(
          context, " ");
    } on Exception catch (exc) {
      AapoortiUtilities.stopProgress(pr!);
      AapoortiUtilities.showInSnackBar(
          context, " ");
    }
    return false;
  }

  void validateAndLogin(int days) async {
    var res;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      AapoortiUtilities.getProgressDialog(pr!);
      _check = await _callLoginWebService(email, pin);
      res = _check;
      debugPrint("res return ${res.toString()}");
      if (res == true) {
        debugPrint("res return1 ${res.toString()}");
        _check = true;

        // Set user as logged in
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool("is loggedin", true);

        // Save user credentials for future biometric login
        await prefs.setString('last_login_email', email);
        await prefs.setString('last_login_usertype', userType);

        // If biometric toggle is on, save credentials for biometric login
        if (_enableBiometric) {
          await saveCredentialsForBiometric();
          setState(() {
            showbiomteric = true;
          });

          // Show a confirmation to the user
          AapoortiUtilities.showInSnackBar(
              context, "Biometric login enabled successfully");
        }

        AapoortiUtilities.loggedin = true;
        Navigator.pop(context);

        AapoortiConstants.ans = "true";
        if (_rememberMe == true)
          checkbox = "true";
        else
          checkbox = "false";
        AapoortiConstants.check = checkbox!;
        AapoortiConstants.date =
            DateTime.now().add(Duration(days: days)).toString();

        // Navigate to UserHome with proper parameters
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => UserHome(userType, email)));
      } else {
        debugPrint("res return3 ${res.toString()}");
        AapoortiUtilities.stopProgress(pr!);
        AapoortiUtilities.showInSnackBar(context, 'Invalid Credentials!');
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //_emailController.dispose();
    _passwordController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AapoortiLanguageProvider language =
        Provider.of<AapoortiLanguageProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: InkWell(
        onTap: () {
          FocusScope.of(context)
              .unfocus(); // Dismiss keyboard when tapping outside
        },
        child: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //const SizedBox(height: 40),
                    Center(
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/nlogo.png',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        language.text('irepsheading'),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1565C0),
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Updated Login Type Selector
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: _LoginTypeButton(
                              title: language.text('ireps'),
                              isSelected: _selectedLoginType == 'IREPS',
                              onTap: () {
                                setState(() {
                                  _selectedLoginType = 'IREPS';
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: _LoginTypeButton(
                              title: language.text('udmtitle'),
                              isSelected: _selectedLoginType == 'UDM',
                              onTap: () {
                                setState(() {
                                  _selectedLoginType = 'UDM';
                                });
                                Navigator.pushNamed(
                                    context, LoginScreen.routeName);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Email Field
                    TextFormField(
                      //controller: _emailController,
                      initialValue: AapoortiConstants.loginUserEmailID != ""
                          ? AapoortiConstants.loginUserEmailID
                          : '',
                      validator: (value) {
                        bool emailValid = RegExp(
                                "^[_A-Za-z0-9-]+(\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\.[A-Za-z0-9]+)*(\.[A-Za-z]{2,})\$")
                            .hasMatch(value!.trim());
                        if (value.isEmpty) {
                          return (language.text('evalidemail'));
                        } else if (!emailValid) {
                          return (language.text('evalidemail'));
                        }
                        return null;
                      },
                      onSaved: (value) {
                        email = value!.trim();
                      },
                      decoration: InputDecoration(
                        labelText: language.text('email'),
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 10),
                    // PIN Field with numeric keyboard
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: language.text('enterpin'),
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      obscureText: _obscureText,
                      keyboardType: TextInputType.number,
                      initialValue: null,
                      validator: (pin) {
                        if (pin!.isEmpty) {
                          return (language.text('digitpin'));
                        } else if (pin.length < 6 || pin.length > 12) {
                          return (language.text('digitpin'));
                        }
                        return null;
                      },
                      onSaved: (value) {
                        pin = value;
                      },
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    const SizedBox(height: 10),
                    // Remember Me Section with Days Selection
                    _buildRememberMeSection(language),
                    const SizedBox(height: 6),
                    // Login Button
                    ElevatedButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        try {
                          connectivityresult =
                              await InternetAddress.lookup('google.com');
                          if (connectivityresult != null) {
                            validateAndLogin(_selectedDays);
                          }
                        } on SocketException catch (_) {
                          AapoortiUtilities.showInSnackBar(
                              context, language.text('connectionissue'));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1565C0),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        language.text('login'),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // Add a biometric login button when biometrics are enabled
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              _enableloginBottomSheet(context, language);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              language.text('ela'),
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              _resetpinBottomSheet(context, language);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              language.text('resetpin'),
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            showbiomteric
                                ? "---------Login with biometric----------"
                                : "--------------Enable biometric ?---------------------",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                              fontSize: 13,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Left side always shows fingerprint/face icons
                            Row(
                              children: [
                                Icon(
                                  Icons.fingerprint_sharp,
                                  size: 36,
                                  color: (showbiomteric || _enableBiometric) ? Colors.blue[700] : Colors.grey,
                                ),
                                const SizedBox(width: 16),
                                Icon(
                                  Icons.face,
                                  size: 36,
                                  color: (showbiomteric || _enableBiometric) ? Colors.blue[700] : Colors.grey,
                                ),
                              ],
                            ),

                            // Right side switches between toggle and login button
                            showbiomteric
                            // RETURNING USER: Show fingerprint login button
                                 ? ElevatedButton(
                onPressed: () async{
          // Replace the existing onPressed code with this:
          await loginWithBiometrics();
          },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            child: Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          )

          : Switch(
                              value: _enableBiometric,
                              onChanged: (value) async {
                                if (value) {
                                  // Check if biometric authentication is available
                                  bool canUse = await checkBiometricAvailable();
                                  if (!canUse) {
                                    AapoortiUtilities.showInSnackBar(
                                        context, "Biometric authentication is not available on this device");
                                    return;
                                  }

                                  // Check if user has already entered email and PIN
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();

                                    // Authenticate user with biometrics immediately
                                    bool authenticated = await AuthService().authenticateLocally();

                                    if (authenticated) {
                                      // Test login credentials first to ensure they're valid
                                      AapoortiUtilities.getProgressDialog(pr!);
                                      bool loginSuccess = await _callLoginWebService(email, pin);

                                      if (loginSuccess) {
                                        // Save credentials for biometric login
                                        await saveCredentialsForBiometric();

                                        setState(() {
                                          _enableBiometric = true;
                                          showbiomteric = true; // Enable biometric login button
                                        });
                                        AapoortiUtilities.stopProgress(pr!);
                                        AapoortiUtilities.showInSnackBar(
                                            context, "Biometric authentication enabled successfully!");
                                      } else {
                                        AapoortiUtilities.stopProgress(pr!);
                                        AapoortiUtilities.showInSnackBar(
                                            context, "Invalid credentials. Please check your email and PIN.");
                                      }
                                    } else {
                                      // User cancelled biometric authentication or it failed
                                      AapoortiUtilities.showInSnackBar(
                                          context, "Biometric authentication was cancelled or failed.");
                                    }
                                  } else {
                                    // Form validation failed
                                    AapoortiUtilities.showInSnackBar(
                                        context, "Please enter valid email and PIN first.");
                                  }
                                } else {
                                  // Disabling biometric authentication
                                  setState(() {
                                    _enableBiometric = false;
                                    showbiomteric = false;
                                  });

                                  // Remove stored biometric credentials
                                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                                  await prefs.remove('stored_email');
                                  await prefs.remove('stored_pin');
                                  await prefs.setBool('isbiometricenabled', false);

                                  AapoortiUtilities.showInSnackBar(
                                      context, "Biometric authentication disabled.");
                                }
                              },
                              activeColor: Colors.blue[700],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'By enabling biometric authentication you will be able to login through your device set biometric',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginTypeButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _LoginTypeButton({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1565C0) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
