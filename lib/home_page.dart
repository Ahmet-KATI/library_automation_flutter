import 'package:first_project/login_page.dart';
import 'package:flutter/material.dart';
import 'package:first_project/app_colors.dart';
import 'package:first_project/database_service.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage(this.userName,{super.key});
  final String userName;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService _databaseService = DatabaseService();
  String userName = "User";
  String email = "User";



  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (Route<dynamic> route) => false,
    );
  }
  @override
  void initState() {
    super.initState();
    // Fetch user information here
    _fetchUserInfo();
  }

  Future<void> _fetchUserInfo() async {
    // Mock data for user information
    _databaseService.getEmailByUsername(widget.userName).then(
      (value) {
        
        setState(() {
                  email = value!;
        userName = widget.userName;
        });
      },
    );
    

  }

  void _borrowBook() {
    // Implement book borrowing logic
    _showSuccessDialog("Başarılı", "Kitap ödünç alındı.");
  }

  void _returnBook() {
    // Implement book returning logic
    _showSuccessDialog("Başarılı", "Kitap teslim edildi.");
  }

  void _showErrorDialog(String errorTitle, String errorDescription) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(errorTitle),
          content: Text(errorDescription),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(String successTitle, String successDescription) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(successTitle),
          content: Text(successDescription),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1, // Add top spacing
              ),
              SvgPicture.asset(
                height: 200,
                width: 200,
                "assets/vectors/person.svg",
                color: AppColors.primaryColor,
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                "Kullanıcı Bilgileri",
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 46,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(32),
                      color: AppColors.secondaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: SizedBox(
                        width: 300,
                        child: Column(
                          children: [
                            const Text(
                              "Kullanıcı Adı",
                              style: TextStyle(
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              userName,
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Text(
                              "E-mail",
                              style: TextStyle(
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              email,
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    width: 450,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: FilledButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.primaryColor,
                              ),
                            ),
                            onPressed: _borrowBook,
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                "Kitap Ödünç Al",
                                style: TextStyle(
                                  color: AppColors.secondaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: FilledButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.primaryColor,
                              ),
                            ),
                            onPressed: _returnBook,
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                "Kitap Teslim Et",
                                style: TextStyle(
                                  color: AppColors.secondaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1, // Add bottom spacing
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _logout,
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.logout, color: AppColors.secondaryColor),
      ),
    );
  }
}
