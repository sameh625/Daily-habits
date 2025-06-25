import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'addHabitPage.dart';
import 'habitDetailsPage.dart';

class HabbitListPage extends StatefulWidget {
  static const routeName = '/habits';

  const HabbitListPage({super.key});

  @override
  State<HabbitListPage> createState() => _HabbitListPageState();
}

class _HabbitListPageState extends State<HabbitListPage> {
  final List<String> _habits = [];
  final List<String> _startDates = [];
  final List<String> _descriptions = [];
  final List<String> _rewards = [];

  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadHabits();
  }

  Future<void> _loadHabits() async {
    _prefs = await SharedPreferences.getInstance();
    final habitsJson = _prefs.getString('habits') ?? '[]';
    final datesJson = _prefs.getString('dates') ?? '[]';
    final descriptionsJson = _prefs.getString('descriptions') ?? '[]';
    final rewardsJson = _prefs.getString('rewards') ?? '[]';

    setState(() {
      _habits.clear();
      _startDates.clear();
      _descriptions.clear();
      _rewards.clear();

      _habits.addAll(List<String>.from(json.decode(habitsJson)));
      _startDates.addAll(List<String>.from(json.decode(datesJson)));
      _descriptions.addAll(List<String>.from(json.decode(descriptionsJson)));
      _rewards.addAll(List<String>.from(json.decode(rewardsJson)));
    });
  }

  Future<void> _saveHabits() async {
    await _prefs.setString('habits', json.encode(_habits));
    await _prefs.setString('dates', json.encode(_startDates));
    await _prefs.setString('descriptions', json.encode(_descriptions));
    await _prefs.setString('rewards', json.encode(_rewards));
  }

  void _showHabitDetails(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => HabitDetailsPage(
              name: _habits[index],
              description: _descriptions[index],
              reward: _rewards[index],
              startDate: _startDates[index],
            ),
      ),
    );
  }

  Future<void> _navigateToAddHabit() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddHabitPage()),
    );

    if (result != null && result is Map<String, String>) {
      setState(() {
        _habits.add(result['habit']!);
        _startDates.add(result['date']!);
        _descriptions.add(result['description'] ?? '');
        _rewards.add(result['reward'] ?? '');
        _saveHabits();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF23272F),
      appBar: AppBar(
        title: const Text('قائمة العادات'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(70, 113, 98, 167),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddHabit,
        backgroundColor: Colors.white.withOpacity(0.12),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: const Text(
              "العادات اليومية",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _habits.length,
              itemBuilder:
                  (context, i) => Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: ListTile(
                      title: Text(
                        _habits[i],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        'تاريخ البدء: ${_startDates[i]}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.info_outline,
                              color: Colors.blue,
                            ),
                            onPressed: () => _showHabitDetails(i),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _habits.removeAt(i);
                                _startDates.removeAt(i);
                                _descriptions.removeAt(i);
                                _rewards.removeAt(i);
                                _saveHabits();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
