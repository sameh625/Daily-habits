import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = '/settings';

  const SettingsPage({super.key});

  void _showRatingDialog(BuildContext context) {
    int _rating = -1;

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setState) => AlertDialog(
                  backgroundColor: const Color(0xFF23272F),
                  title: const Text(
                    'قيم التطبيق',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.right,
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'ما رأيك في التطبيق؟',
                        style: TextStyle(color: Colors.white70),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          5,
                          (index) => IconButton(
                            icon: Icon(
                              index < _rating ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                              size: 32,
                            ),
                            onPressed: () {
                              setState(() {
                                _rating = index + 1;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('إلغاء'),
                    ),
                    TextButton(
                      onPressed:
                          _rating > 0
                              ? () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'شكراً لتقييمك! ($_rating نجوم)',
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                Navigator.pop(context);
                              }
                              : null,
                      child: const Text('تأكيد'),
                    ),
                  ],
                ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF23272F),
      appBar: AppBar(
        title: const Text('الإعدادات'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(70, 113, 98, 167),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.info_outline,
                      color: Colors.white70,
                    ),
                    title: const Text(
                      'حول التطبيق',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              backgroundColor: const Color(0xFF23272F),
                              title: const Text(
                                'حول التطبيق',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.right,
                              ),
                              content: const Text(
                                'تطبيق العادات اليومية يساعدك على تتبع وتنظيم عاداتك اليومية بطريقة سهلة وفعالة',
                                style: TextStyle(color: Colors.white70),
                                textAlign: TextAlign.right,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('حسناً'),
                                ),
                              ],
                            ),
                      );
                    },
                  ),
                  const Divider(color: Colors.white24),
                  ListTile(
                    leading: const Icon(
                      Icons.email_outlined,
                      color: Colors.white70,
                    ),
                    title: const Text(
                      'تواصل معنا',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              backgroundColor: const Color(0xFF23272F),
                              title: const Text(
                                'تواصل معنا',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.right,
                              ),
                              content: const Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    ':البريد الإلكتروني',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    'dailyTracker@gmail.com',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    ':رقم الهاتف',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    '01277775013',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('حسناً'),
                                ),
                              ],
                            ),
                      );
                    },
                  ),
                  const Divider(color: Colors.white24),
                  ListTile(
                    leading: const Icon(
                      Icons.star_outline,
                      color: Colors.white70,
                    ),
                    title: const Text(
                      'قيم التطبيق',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onTap: () => _showRatingDialog(context),
                  ),
                  const Divider(color: Colors.white24),
                  ListTile(
                    leading: const Icon(
                      Icons.info_outline,
                      color: Colors.white70,
                    ),
                    title: const Text(
                      'رقم الاصدار',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    subtitle: const Text(
                      '1.0.0',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
