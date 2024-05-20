import 'package:first_project/app_colors.dart';
import 'package:first_project/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                          onPressed: () {},
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
                                      builder: (context) => const LoginPage()),
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
          ],
        ),
      ),
    );
  }
}
