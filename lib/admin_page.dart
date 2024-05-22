import 'package:first_project/login_page.dart';
import 'package:flutter/material.dart';
import 'package:first_project/app_colors.dart';
import 'package:first_project/database_service.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final DatabaseService _databaseService = DatabaseService();
  final TextEditingController bookNameController = TextEditingController();
  final TextEditingController bookAuthorController = TextEditingController();
  final TextEditingController bookCategoryController = TextEditingController();

  void _addBook() async {
    final String bookName = bookNameController.text;
    final String bookAuthor = bookAuthorController.text;
    final String bookCategory = bookCategoryController.text;

    if (bookName.isEmpty || bookAuthor.isEmpty || bookCategory.isEmpty) {
      _showErrorDialog("Hata", "Lütfen tüm alanları doldurun.");
      return;
    }

    try {
      await _databaseService.addBook(bookName, bookAuthor, bookCategory);
      _showSuccessDialog("Başarılı", "Kitap başarıyla eklendi.");
    } catch (e) {
      _showErrorDialog("Hata", "Aynı isimde kitap zaten var");
    }
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

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (Route<dynamic> route) => false,
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
                "assets/vectors/logo.svg",
                color: AppColors.primaryColor,
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                "Kitap Ekle",
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
                              "Kitap Adı",
                              style: TextStyle(
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextField(
                              controller: bookNameController,
                              style: const TextStyle(
                                color: AppColors.secondaryColor,
                              ),
                              decoration: InputDecoration(
                                fillColor: AppColors.background,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: AppColors.primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Text(
                              "Yazar Adı",
                              style: TextStyle(
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextField(
                              controller: bookAuthorController,
                              style: const TextStyle(
                                color: AppColors.secondaryColor,
                              ),
                              decoration: InputDecoration(
                                fillColor: AppColors.background,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: AppColors.primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Text(
                              "Kategori",
                              style: TextStyle(
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextField(
                              controller: bookCategoryController,
                              style: const TextStyle(
                                color: AppColors.secondaryColor,
                              ),
                              decoration: InputDecoration(
                                fillColor: AppColors.background,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: AppColors.primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
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
                    child: FilledButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          AppColors.primaryColor,
                        ),
                      ),
                      onPressed: _addBook,
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "Kitap Ekle",
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
