import 'dart:developer';

import 'package:first_project/app_colors.dart';
import 'package:first_project/database_service.dart';
import 'package:first_project/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final DatabaseService _databaseService = DatabaseService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  void _showSuccessDialog(String errorTitle, String errorDescription) {
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
                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()),
                                  );
              },
            ),
          ],
        );
      },
    );
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
                height: 24,
              ),
              const Text(
                "Kayıt Ol",
                style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 46,
                    fontWeight: FontWeight.w500),
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
                            const SizedBox(
                              height: 16,
                            ),
                            const Text(
                              "E-mail",
                              style: TextStyle(
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 24),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextField(
                              controller: emailController,
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
                            onPressed: () async {
                              try{
                                await _databaseService.addUser(
                                  userNameController.text,
                                  passwordController.text,
                                  emailController.text,
                                  "User");
                                  List<Map<String,dynamic>> result = await _databaseService.getAllUsers();
                                  log(result.toString());
                                  _showSuccessDialog("Kayıt Başarılı","Login Sayfasına git");
                                
                              }catch(e){
                                  _showErrorDialog("Kayıt Başarısız","Bu Hesap Zaten var");
                                  log(e.toString());

                              }
                              
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
                                            const LoginPage()),
                                  );
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                    "Giriş",
                                    style: TextStyle(
                                        color: AppColors.secondaryColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                )))
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height:
                    MediaQuery.of(context).size.height * 0.1, // Add top spacing
              ),
            ],
          ),
        ),
      ),
    );
  }
}
