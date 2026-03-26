/// Banglish (English transliteration of Bengali) search utility
class BanglishConverter {
  static const Map<String, String> banglishToBengali = {
    'a': 'অ',
    'aa': 'আ',
    'i': 'ই',
    'ii': 'ঈ',
    'u': 'উ',
    'uu': 'ঊ',
    'ri': 'ঋ',
    'e': 'এ',
    'oi': 'ঐ',
    'o': 'ও',
    'ou': 'ঔ',
    'ka': 'ক',
    'kha': 'খ',
    'ga': 'গ',
    'gha': 'ঘ',
    'nga': 'ঙ',
    'cha': 'চ',
    'chha': 'ছ',
    'ja': 'জ',
    'jha': 'ঝ',
    'nya': 'ঞ',
    'ta': 'ট',
    'tha': 'ঠ',
    'da': 'ড',
    'dha': 'ঢ',
    'na': 'ণ',
    'tta': 'ত',
    'ttha': 'থ',
    'dda': 'দ',
    'ddha': 'ধ',
    'nna': 'ন',
    'pa': 'প',
    'pha': 'ফ',
    'ba': 'ব',
    'bha': 'ভ',
    'ma': 'ম',
    'ya': 'য',
    'ra': 'র',
    'la': 'ল',
    'sha': 'শ',
    'ssa': 'ষ',
    'sa': 'স',
    'ha': 'হ',
    'amar': 'আমার',
    'prabhу': 'প্রভু',
    'gaan': 'গান',
    'bhakti': 'ভক্তি',
    'dhan': 'ধন্য',
  };

  /// Convert Banglish text to Bengali
  static String convertBanglishToBengali(String banglish) {
    String result = banglish.toLowerCase();
    
    // Sort keys by length (longest first) to handle multi-character mappings
    final sortedKeys = banglishToBengali.keys.toList()
      ..sort((a, b) => b.length.compareTo(a.length));
    
    for (final key in sortedKeys) {
      result = result.replaceAll(key, banglishToBengali[key]!);
    }
    
    return result;
  }

  /// Check if text matches search query (supports both Bengali and Banglish)
  static bool matchesSearch(String text, String query) {
    if (text.isEmpty || query.isEmpty) return false;
    
    final textLower = text.toLowerCase();
    final queryLower = query.toLowerCase();
    
    // Direct match (for Bengali or English)
    if (textLower.contains(queryLower)) return true;
    
    // Convert Banglish to Bengali and match
    final bengaliQuery = convertBanglishToBengali(queryLower);
    if (textLower.contains(bengaliQuery)) return true;
    
    return false;
  }
}
