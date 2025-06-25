import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/screens/dailyHabits.dart';

class Homepage extends StatelessWidget {
  static const routeName = "/";

  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await _showExitConfirmationDialog(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الصفحة الرئيسية'),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(
            70,
            113,
            98,
            167,
          ), // Darker bar color
        ),
        backgroundColor: const Color(0xFF23272F), // Softer dark blue-grey
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const DailyHabits(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.06),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                  elevation: 0,
                ),
                child: const Text('العادات اليومية'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/habits');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.12),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 3,
                    vertical: 15,
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                  elevation: 0,
                ),
                child: const Text('عرض العادات'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/settings');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey.withOpacity(0.7),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                  elevation: 0,
                ),
                child: const Text('الإعدادات'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  bool shouldExit = await _showExitConfirmationDialog(context);
                  if (shouldExit) {
                    SystemNavigator.pop();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.withOpacity(0.8),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                  elevation: 0,
                ),
                child: const Text('خروج'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _showExitConfirmationDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('تأكيد الخروج'),
                content: const Text('هل تريد الخروج من التطبيق؟'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('إلغاء'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('خروج'),
                  ),
                ],
              ),
        ) ??
        false;
  }
}
