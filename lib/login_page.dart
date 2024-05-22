import 'package:first_project/admin_page.dart';
import 'package:first_project/app_colors.dart';
import 'package:first_project/database_service.dart';
import 'package:first_project/home_page.dart';
import 'package:first_project/sign_up.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final DatabaseService _databaseService = DatabaseService();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
  void _handleLogin() async {
    String? role = await _databaseService.login(
        userNameController.text, passwordController.text);

    if (role != null) {
      if (role == 'Admin') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const AdminPage()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage(userNameController.text)),
        );
      }
    } else {
      _showErrorDialog("Giriş Başarısız", "Kullanıcı adı veya şifre hatalı.");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height:
                    MediaQuery.of(context).size.height * 0.1, // Add top spacing
              ),
              SvgPicture.asset(
                height: 200,
                width: 200,
                "assets/vectors/logo.svg",
                // ignore: deprecated_member_use
                color: AppColors.primaryColor,
              ),
              const SizedBox(
                height: 64,
              ),
              const Text(
                "Giriş Yap",
                style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 46,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 32,
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(32),
                        color: AppColors.secondaryColor),
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
                                  fontSize: 24),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextField(
                              controller: userNameController,
                              style: const TextStyle(
                                  color: AppColors.secondaryColor),
                              decoration: InputDecoration(
                                  fillColor: AppColors.background,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: AppColors.primaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  )),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Text(
                              "Şifre",
                              style: TextStyle(
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 24),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextField(
                              controller: passwordController,
                              obscureText: true,
                              style: const TextStyle(
                                  color: AppColors.secondaryColor),
                              decoration: InputDecoration(
                                  fillColor: AppColors.background,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: AppColors.primaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  )),
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
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: FilledButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  AppColors.primaryColor),
                            ),
                            onPressed: _handleLogin,
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                "Giriş",
                                style: TextStyle(
                                    color: AppColors.secondaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
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
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                          AppColors.primaryColor),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpPage()),
                                  );
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                    "Kayıt",
                                    style: TextStyle(
                                        color: AppColors.secondaryColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                )))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.1, // Add bottom spacing
              ),
            ],
          ),
        ),
      ),
    );
  }
}
