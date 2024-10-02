import 'package:flutter/material.dart';
import '../services/excel_service.dart';
import '../utils/arabic_text_style.dart';

class MorningAdhkar extends StatelessWidget {
  const MorningAdhkar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final baseFontSize = screenSize.width * 0.04; // 4% of screen width

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Morning Adhkar',
          style: TextStyle(
            color: Colors.white,
            fontSize: baseFontSize * 1.2,
            fontWeight: FontWeight.bold,
            shadows: const [
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.teal.shade700,
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: ExcelService.getAllMorningContent(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromRGBO(0, 77, 64, 1),
                    Color.fromARGB(255, 70, 163, 119),
                    Color.fromARGB(255, 6, 85, 51),
                    Color.fromARGB(255, 13, 234, 175),
                  ],
                ),
              ),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: screenSize.height * 0.02,
                      horizontal: screenSize.width * 0.04,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          item['arabic']!,
                          style: ArabicTextStyle.mirza(
                            fontSize: baseFontSize * 1.8,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(height: screenSize.height * 0.015),
                        Text(
                          item['transliteration']!,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: baseFontSize * 1.0,
                            fontStyle: FontStyle.italic,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: screenSize.height * 0.015),
                        Text(
                          item['translation']!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: baseFontSize * 1.0,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        Divider(
                          color: Colors.white30,
                          thickness: 1,
                          height: 1,
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}