// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import the image_picker package
import 'dart:io'; // Import for File

// Global state for storing user credentials
class UserData {
  static String email = ''; // Static variable to hold email
  static String password = ''; // Static variable to hold password
}


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login SignUp App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHr1azOS6y47GnsvtXnuOjv0iELbTPdNQ-8g&s'),
            ),
            SizedBox(height: 30),
            Text(
              'Chedrick Appointment Booking App',
              style: TextStyle(fontSize: 23),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 144, 170, 191), // Background color
                    foregroundColor: Colors.black, // Text color
                  ),
                  child: Text('Login'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 144, 170, 191), // Background color
                    foregroundColor: Colors.black, // Text color
                  ),
                  child: Text('Sign Up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}




class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _login() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      if (email == 'correct@email.com' && password == 'correctpassword') {
        UserData.email = email;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage(userName: UserData.email)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid email or password'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    Divider(height: 5),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.key),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        border: InputBorder.none,
                      ),
                      obscureText: _obscureText,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 192, 198, 204), // Background color
                  foregroundColor: Colors.black, // Text color
                ),
                child: Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
                child: Text('Don\'t have an account? Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscureText = true;
  bool _obscureConfirmText = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Passwords do not match'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      UserData.email = _emailController.text;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Account created successfully!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(userName: UserData.email)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    Divider(height: 5),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.key),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        border: InputBorder.none,
                      ),
                      obscureText: _obscureText,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    Divider(height: 20),
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        prefixIcon: Icon(Icons.key),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmText ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmText = !_obscureConfirmText;
                            });
                          },
                        ),
                        border: InputBorder.none,
                      ),
                      obscureText: _obscureConfirmText,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 192, 198, 204), // Background color
                  foregroundColor: Colors.black, // Text color
                ),
                child: Text('Sign Up'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class HomePage extends StatefulWidget {
  final String userName; // Variable to hold the username

  // Constructor to receive the username from ProfilePage
  HomePage({Key? key, required this.userName}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _profileImageFile;

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    print("Pick image function called"); // Debugging statement
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      print("Image picked: ${pickedFile.path}"); // Debugging statement
      setState(() {
        _profileImageFile = File(pickedFile.path);
      });
    } else {
      print("No image selected."); // Debugging statement
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Chedrick Laboratory and Diagnostic Center'),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 118, 173, 245),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: _profileImageFile != null
                            ? FileImage(_profileImageFile!)
                            : NetworkImage('https://static-00.iconduck.com/assets.00/profile-circle-icon-2048x2048-cqe5466q.png') as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.camera_alt),
                          onPressed: () {
                            print("Camera icon pressed"); // Debugging statement
                            _pickImage();
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.userName, // Display the username here
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePageContent()));
              },
            ),
            ListTile(
              leading: Icon(Icons.medical_services),
              title: Text('Services'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ServiceScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notification'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/lab.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ],
      ),
    );
  }
}


class HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chedrick Laboratory and Diagnostic Center'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Chedrick Laboratory and Diagnostic Center',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 5, 0, 0),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Chedrick Laboratory and Diagnostic Center (CLDC) is one of the institutions in the field of medical examination and research. It was established in J.P. Rizal Cor. F Mangobos St. Poblacion 1, Bauan, Batangas in 2019.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class ServiceScreen extends StatelessWidget {
  final List<ServiceItem> services = [
    ServiceItem(name: 'Blood Chemistry', icon: Icons.bloodtype),
    ServiceItem(name: 'Clinical Microscopy', icon: Icons.biotech),
    ServiceItem(name: 'Hematology', icon: Icons.water),
    ServiceItem(name: 'Serology', icon: Icons.science),
    ServiceItem(name: 'COVID Swab Test', icon: Icons.sick),
    ServiceItem(name: 'Drug Test', icon: Icons.local_hospital),
    ServiceItem(name: 'ECG', icon: Icons.monitor_heart),
    ServiceItem(name: 'X-Ray', icon: Icons.medical_services),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Our Services'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.white, // Set the background color to white
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    return ServiceCard(service: services[index]);
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to appointment booking screen or implement your logic here
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PatientInformationScreen(services: services),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 144, 170, 191), // Set background color
              ),
              child: Text(
                'Book an Appointment',
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ServiceItem {
  final String name;
  final IconData icon;

  ServiceItem({required this.name, required this.icon});
}

class ServiceCard extends StatelessWidget {
  final ServiceItem service;

  ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Colors.blue, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            service.icon,
            size: 50,
            color: Colors.black,
          ),
          SizedBox(height: 10),
          Text(
            service.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}


class PatientInformationScreen extends StatefulWidget {
  final List<ServiceItem> services;

  PatientInformationScreen({required this.services});

  @override
  _PatientInformationScreenState createState() => _PatientInformationScreenState();
}

class _PatientInformationScreenState extends State<PatientInformationScreen> {
  List<String?> _selectedServices = [null];
  List<DateTime?> _selectedDates = [null];
  List<TimeOfDay?> _selectedTimes = [null];

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  bool _sendCopy = false;

  _selectDate(BuildContext context, int index) async {
  DateTime now = DateTime.now();
  DateTime firstDate = DateTime(2023, 1, 1);
  DateTime lastDate = DateTime(2024, 12, 31);

  // Define the list of unavailable dates in August
  Set<int> unavailableDates = {1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 20, 21, 24, 25};

  DateTime? picked = await showDatePicker(
    context: context,
    initialDate: _selectedDates[index] ?? now,
    firstDate: firstDate,
    lastDate: lastDate,
    selectableDayPredicate: (DateTime day) {
      // Disable the specific dates in August
      if (day.month == DateTime.august && unavailableDates.contains(day.day)) {
        return false;
      }
      // Allow only Monday to Saturday (1 to 6 in DateTime.weekday)
      return day.weekday >= DateTime.monday && day.weekday <= DateTime.saturday;
    },
  );

  if (picked != null && picked != _selectedDates[index]) {
    if (picked.month == DateTime.august && unavailableDates.contains(picked.day)) {
      // Show "Fully Booked" message for the unavailable August dates
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('August ${picked.day}, ${picked.year} is Fully Booked.'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      setState(() {
        _selectedDates[index] = picked;
      });

      // Show notification or feedback about selected date
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Selected date: ${picked.toString().split(' ')[0]}'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}


  _selectTime(BuildContext context, int index) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: _selectedTimes[index] ?? TimeOfDay.now(),
    builder: (BuildContext context, Widget? child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        child: child!,
      );
    },
  );

  if (picked != null) {
    // Define allowed time range
    TimeOfDay earliestAllowedTime = TimeOfDay(hour: 7, minute: 0);
    TimeOfDay latestAllowedTime = TimeOfDay(hour: 16, minute: 0);

    // Define lunch break time
    TimeOfDay lunchBreakStart = TimeOfDay(hour: 12, minute: 0);
    TimeOfDay lunchBreakEnd = TimeOfDay(hour: 13, minute: 0);

    // Convert TimeOfDay to minutes since midnight for easier comparison
    int pickedInMinutes = picked.hour * 60 + picked.minute;
    int lunchBreakStartInMinutes = lunchBreakStart.hour * 60 + lunchBreakStart.minute;
    int lunchBreakEndInMinutes = lunchBreakEnd.hour * 60 + lunchBreakEnd.minute;
    int earliestAllowedInMinutes = earliestAllowedTime.hour * 60 + earliestAllowedTime.minute;
    int latestAllowedInMinutes = latestAllowedTime.hour * 60 + latestAllowedTime.minute;

    // Check if selected time is during lunch break
    if (pickedInMinutes >= lunchBreakStartInMinutes && pickedInMinutes < lunchBreakEndInMinutes) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Lunch Break'),
            content: Text('The selected time is during lunch break (12:00 PM to 1:00 PM). Please choose a different time.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    } 
    // Check if selected time is within the allowed range
    else if (pickedInMinutes < earliestAllowedInMinutes || pickedInMinutes > latestAllowedInMinutes) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Time is not Available'),
            content: Text('Selected time must be between 7:00 AM and 4:00 PM.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    } else {
      // Time is within allowed range and not during lunch break, update the selected time
      setState(() {
        _selectedTimes[index] = picked;
      });
    }
  }
}


  _addAppointment() {
    setState(() {
      _selectedServices.add(null);
      _selectedDates.add(null);
      _selectedTimes.add(null);
    });
  }

  Future<void> _showConfirmationDialog() async {
    if (_fullNameController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _selectedServices.any((service) => service == null) ||
        _selectedDates.any((date) => date == null) ||
        _selectedTimes.any((time) => time == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill out all fields.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    bool? wantCopy = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Full Name: ${_fullNameController.text}'),
              Text('Address: ${_addressController.text}'),
              Text('Email: ${_emailController.text}'),
              for (int i = 0; i < _selectedServices.length; i++)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Service: ${_selectedServices[i] ?? 'Not Selected'}'),
                    Text('Date: ${_selectedDates[i]?.toString().split(' ')[0] ?? 'Not Selected'}'),
                    Text('Time: ${_selectedTimes[i]?.format(context) ?? 'Not Selected'}'),
                    SizedBox(height: 10),
                  ],
                ),
              Row(
                children: [
                  Text('Send me a copy: '),
                  Checkbox(
                    value: _sendCopy,
                    onChanged: (value) {
                      setState(() {
                        _sendCopy = value!;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Yes, Submit'),
            ),
          ],
        );
      },
    );

    if (wantCopy != null && wantCopy) {
      _sendNotification();
    }
  }

  void _sendNotification() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Notification Sent '),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Return to the previous screen
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double commonWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Online Appointment Form'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.white, // Set the background color to white
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Fill out your appointment form carefully.',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0),
                _buildTextField('Full Name:', 'Enter Full Name', _fullNameController, width: commonWidth),
                const SizedBox(height: 10.0),
                _buildTextField('Address:', 'Enter Address', _addressController, width: commonWidth),
                const SizedBox(height: 10.0),
                _buildTextField('Email:', 'Enter Email', _emailController, width: commonWidth),
                const SizedBox(height: 10.0),
                for (int i = 0; i < _selectedServices.length; i++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBox('Service:', DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          hintText: 'Select Service',
                        ),
                        items: widget.services.map((ServiceItem service) {
                          return DropdownMenuItem<String>(
                            value: service.name,
                            child: Text(service.name),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedServices[i] = newValue;
                          });
                        },
                        value: _selectedServices[i],
                      ), width: commonWidth),
                      const SizedBox(height: 10.0),
                      _buildBox('Date:', TextButton(
                        onPressed: () => _selectDate(context, i),
                        child: Text(
                          _selectedDates[i] != null
                              ? _selectedDates[i]!.toString().split(' ')[0]
                              : 'Select Date',
                          style: const TextStyle(color: Color.fromARGB(255, 11, 21, 29)),
                        ),
                      ), width: commonWidth),
                      const SizedBox(height: 10.0),
                      _buildBox('Time:', TextButton(
                        onPressed: () => _selectTime(context, i),
                        child: Text(
                          _selectedTimes[i] != null
                              ? '${_selectedTimes[i]!.hour}:${_selectedTimes[i]!.minute.toString().padLeft(2, '0')} ${_selectedTimes[i]!.period == DayPeriod.am ? 'AM' : 'PM'}'
                              : 'Select Time',
                          style: const TextStyle(color: Color.fromARGB(255, 11, 21, 29)),
                        ),
                      ), width: commonWidth),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                TextButton(
                  onPressed: _addAppointment,
                  child: Text('Add Another Appointment'),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    _showConfirmationDialog();
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller, {double width = 300.0}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(height: 5.0),
        Container(
          width: width,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBox(String label, Widget child, {double width = 300.0}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16.0),
        ),
        const SizedBox(height: 5.0),
        Container(
          width: width,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0),
          ),
          padding: const EdgeInsets.all(8.0),
          child: child,
        ),
      ],
    );
  }
}

class NotificationScreen extends StatelessWidget {
  final List<String> notifications = [
    'The test results are now available .',
    'You may now proceed to your appointment.',
    'Your appointment has been confirmed.',
    'The medical form has been successfully submitted.',
    'Copy of your Appointment.',
    
  ];

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: notifications.isNotEmpty
            ? ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  // Generate a unique timestamp for each notification
                  String timestamp = _formatTimestamp(DateTime.now().subtract(Duration(minutes: index)));

                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.notifications),
                      title: Text(notifications[index]),
                      trailing: Text(timestamp), // Display timestamp on the right side
                    ),
                  );
                },
              )
            : Center(
                child: Text('No notifications available'),
              ),
      ),
    );
  }

  // Function to format timestamp including AM/PM
  String _formatTimestamp(DateTime dateTime) {
    String period = dateTime.hour < 12 ? 'AM' : 'PM';
    int hour = dateTime.hour % 12;
    hour = hour == 0 ? 12 : hour; // Convert 0 to 12 for 12-hour format
    String minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }
}