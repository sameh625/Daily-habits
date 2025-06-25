import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DailyHabits extends StatefulWidget {
  const DailyHabits({super.key});

  @override
  State<DailyHabits> createState() => _DailyHabitsState();
}

class _DailyHabitsState extends State<DailyHabits> {
  final List<String> _habits = [];
  late SharedPreferences _prefs;
  Future<void> _loadHabits() async {
    _prefs = await SharedPreferences.getInstance();
    final habitsJson = _prefs.getString('habits') ?? '[]';

    setState(() {
      _habits.clear();
      _habits.addAll(List<String>.from(json.decode(habitsJson))); 
      _prefs.setString('DailyHabits', json.encode(_habits));
    });

    // عرض رسالة للمستخدم
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم تحميل العادات بنجاح'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.blue,
        ),
      );
    }
  }

  Future<void> _loadDailyHabits() async {
    _prefs = await SharedPreferences.getInstance();
    final habitsJson = _prefs.getString('DailyHabits') ?? '[]';

    setState(() {
      _habits.clear();
      _habits.addAll(List<String>.from(json.decode(habitsJson)));
    });
  }

  // Remove a habit and save
  void _removeHabit(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('أحسنت! لقد أكملت "${_habits[index]}"'),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
    setState(() {
      _habits.removeAt(index);
      _prefs.setString('DailyHabits', json.encode(_habits));
    });
  }

  @override
  void initState() {
    super.initState();
    _loadDailyHabits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF23272F), // Match Homepage background
      appBar: AppBar(
        title: const Text('العادات اليومية'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(70, 113, 98, 167),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadHabits,
        backgroundColor: Colors.white.withOpacity(0.12),
        foregroundColor: Colors.white,
        child: const Icon(Icons.download),
        tooltip: 'تحميل كل العادات',
      ),
      body: Column(
        children: [
          Expanded(
            child:
                _habits.isEmpty
                    ? const Center(
                      child: Text(
                        'قمت بعمل كل العادات اليومية',
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                    : ListView.builder(
                      itemCount: _habits.length,
                      itemBuilder:
                          (context, i) => ListTile(
                            title: Text(
                              _habits[i],
                              style: const TextStyle(color: Colors.white),
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.check_circle_outline,
                                color: Colors.green,
                              ),
                              onPressed: () => _removeHabit(i),
                            ),
                          ),
                    ),
          ),
        ],
      ),
    );
  }
}
