import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HadithDaily extends StatefulWidget {
  const HadithDaily({super.key});

  @override
  _HadithDailyState createState() => _HadithDailyState();
}

class _HadithDailyState extends State<HadithDaily> {
  String hadith = '';
  String hadithRefNo = '';
  DateTime currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    fetchHadith();
  }

  Future<void> fetchHadith() async {
    setState(() {
      currentTime = DateTime.now();
    });

    final prefs = await SharedPreferences.getInstance();
    final lastFetchDate = prefs.getString('lastHadithFetchDate');
    final currentDate = DateTime.now().toIso8601String().split('T')[0];

    if (lastFetchDate != currentDate) {
      try {
        final response = await http.get(
            Uri.parse('https://random-hadith-generator.vercel.app/bukhari/'));
        if (response.statusCode == 200) {
          final data = json.decode(response.body)['data'];
          setState(() {
            hadith = data['hadith_english'];
            hadithRefNo = data['refno'];
          });
          await prefs.setString('lastHadithFetchDate', currentDate);
          await prefs.setString('cachedHadith', hadith);
          await prefs.setString('cachedHadithRefNo', hadithRefNo);
        } else {
          throw Exception('Failed to load hadith');
        }
      } catch (e) {
        print('Error fetching hadith: $e');
        // If there's an error, try to load cached hadith
        setState(() {
          hadith = prefs.getString('cachedHadith') ?? '';
          hadithRefNo = prefs.getString('cachedHadithRefNo') ?? '';
        });
      }
    } else {
      setState(() {
        hadith = prefs.getString('cachedHadith') ?? '';
        hadithRefNo = prefs.getString('cachedHadithRefNo') ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daily Hadith',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.teal.shade700,
        elevation: 4,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/hadith_daily.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.white.withOpacity(0.9),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (hadith.isNotEmpty && hadithRefNo.isNotEmpty)
                        Column(
                          children: [
                            Text(
                              hadith,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black87),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Reference: $hadithRefNo',
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black54),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      else
                        const Text(
                          'No hadith available. Please try again later.',
                          style: TextStyle(fontSize: 18, color: Colors.black87),
                          textAlign: TextAlign.center,
                        ),
                      const SizedBox(height: 16),
                      Text(
                        'Last updated: ${currentTime.toString().split('.')[0]}',
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}