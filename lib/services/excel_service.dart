import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show rootBundle;

class ExcelService {
  static String _trimText(String? text) {
    return text?.trim() ?? '';
  }

  static String _trimArabicText(String? text) {
    if (text == null) return '';
    
    // Define all possible whitespace characters
    final whitespaceChars = RegExp(r'[\s\u00A0\u1680\u180E\u2000-\u200B\u2028\u2029\u202F\u205F\u3000\uFEFF]');
    
    // Trim start
    var startIndex = 0;
    while (startIndex < text.length && whitespaceChars.hasMatch(text[startIndex])) {
      startIndex++;
    }
    
    // Trim end
    var endIndex = text.length;
    while (endIndex > startIndex && whitespaceChars.hasMatch(text[endIndex - 1])) {
      endIndex--;
    }
    
    // Return trimmed string
    return text.substring(startIndex, endIndex);
  }

  static Future<List<Map<String, String>>> getQuranVerses() async {
    final bytes = await rootBundle.load('assets/al_mathurat_database.xlsx');
    final excel = Excel.decodeBytes(bytes.buffer.asUint8List());

    final quranSheet = excel.tables['Quran'];
    if (quranSheet == null) {
      throw Exception('Sheet "Quran" not found in the Excel file');
    }

    final List<Map<String, String>> verses = [];

    for (var row in quranSheet.rows.skip(1)) { // Skip header row
      if (row.length >= 4 ) {
        verses.add({
          'type': 'Quran',
          'arabic': _trimArabicText(row[2]?.value?.toString()),
          'transliteration': _trimText(row[3]?.value?.toString()),
          'translation': _trimText(row[4]?.value?.toString()),
        });
      }
    }

    return verses;
  }

  static Future<List<Map<String, String>>> getMorningAdhkar() async {
    final bytes = await rootBundle.load('assets/al_mathurat_database.xlsx');
    final excel = Excel.decodeBytes(bytes.buffer.asUint8List());

    final morningAdhkarSheet = excel.tables['Morning-Adhkar'];
    if (morningAdhkarSheet == null) {
      throw Exception('Sheet "Morning-Adhkar" not found in the Excel file');
    }

    final List<Map<String, String>> adhkar = [];

    for (var row in morningAdhkarSheet.rows.skip(1)) { // Skip header row
      if (row.length >= 4) {
        adhkar.add({
          'type': 'Adhkar',
          'arabic': _trimArabicText(row[1]?.value?.toString()),
          'transliteration': _trimText(row[2]?.value?.toString()),
          'translation': _trimText(row[3]?.value?.toString()),
        });
      }
    }

    return adhkar;
  }

  static Future<List<Map<String, String>>> getEveningAdhkar() async {
    final bytes = await rootBundle.load('assets/al_mathurat_database.xlsx');
    final excel = Excel.decodeBytes(bytes.buffer.asUint8List());

    final eveningAdhkarSheet = excel.tables['Evening-Adhkar'];
    if (eveningAdhkarSheet == null) {
      throw Exception('Sheet "Evening-Adhkar" not found in the Excel file');
    }

    final List<Map<String, String>> adhkar = [];

    for (var row in eveningAdhkarSheet.rows.skip(1)) { // Skip header row
      if (row.length >= 4) {
        adhkar.add({
          'type': 'Adhkar',
          'arabic': _trimArabicText(row[1]?.value?.toString()),
          'transliteration': _trimText(row[2]?.value?.toString()),
          'translation': _trimText(row[3]?.value?.toString()),
        });
      }
    }

    return adhkar;
  }

  static Future<List<Map<String, String>>> getGeneralAdhkar() async {
    final bytes = await rootBundle.load('assets/al_mathurat_database.xlsx');
    final excel = Excel.decodeBytes(bytes.buffer.asUint8List());

    final generalAdhkarSheet = excel.tables['General'];
    if (generalAdhkarSheet == null) {
      throw Exception('Sheet "General" not found in the Excel file');
    }

    final List<Map<String, String>> adhkar = [];

    for (var row in generalAdhkarSheet.rows.skip(1)) { // Skip header row
      if (row.length >= 4) {
        adhkar.add({
          'type': 'Adhkar',
          'arabic': _trimArabicText(row[1]?.value?.toString()),
          'transliteration': _trimText(row[2]?.value?.toString()),
          'translation': _trimText(row[3]?.value?.toString()),
        });
      }
    }

    return adhkar;
  }

  static Future<List<Map<String, String>>> getAllMorningContent() async {
    final quranVerses = await getQuranVerses();
    final morningAdhkar = await getMorningAdhkar();
    final generalAdhkar = await getGeneralAdhkar();
    return [...quranVerses, ...morningAdhkar, ...generalAdhkar];
  }

  static Future<List<Map<String, String>>> getAllEveningContent() async {
    final quranVerses = await getQuranVerses();
    final eveningAdhkar = await getEveningAdhkar();
    final generalAdhkar = await getGeneralAdhkar();
    return [...quranVerses, ...eveningAdhkar, ...generalAdhkar];
  }
}