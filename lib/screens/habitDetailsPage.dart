import 'package:flutter/material.dart';

class HabitDetailsPage extends StatelessWidget {
  static const routeName = '/habit-details';
  final String name;
  final String description;
  final String reward;
  final String startDate;

  const HabitDetailsPage({
    super.key,
    required this.name,
    required this.description,
    required this.reward,
    required this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFF23272F),
        appBar: AppBar(
          title: const Text('تفاصيل العادة'),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(70, 113, 98, 167),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection('اسم العادة', name),
              _buildSection('الوصف', description),
              _buildSection('المكافأة', reward),
              _buildSection('تاريخ البدء', startDate),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Text(
              content,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
