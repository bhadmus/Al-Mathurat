import 'package:flutter/material.dart';
import '../main.dart';
import 'morning_adhkar.dart';
import 'evening_adhkar.dart';
import 'hadith_daily.dart';
import '../widgets/time_display.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Al-Mathurat',
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
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: DateTimeDisplay(),
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double tileSize = constraints.maxWidth * 0.4;
                    return Center(
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildMenuButton(
                            context,
                            'Hadith Daily',
                            'assets/images/hadith_daily.png',
                            const HadithDaily(),
                            tileSize,
                          ),
                          _buildMenuButton(
                            context,
                            'Morning Adhkar',
                            'assets/images/morning_background.png',
                            const MorningAdhkar(),
                            tileSize,
                          ),
                          _buildMenuButton(
                            context,
                            'Evening Adhkar',
                            'assets/images/evening_background.png',
                            const EveningAdhkar(),
                            tileSize,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String title,
      String backgroundImage, Widget destination, double size) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
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
        ),
      ),
    );
  }
}