import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/song.dart';
import '../utils/banglish.dart';

class SongsProvider extends ChangeNotifier {
  List<Song> _allSongs = [];
  List<Song> _filteredSongs = [];
  Set<int> _favorites = {};
  bool _isLoading = true;
  String _searchQuery = '';
  int _fontSize = 16;
  bool _isDarkMode = false;

  // Getters
  List<Song> get allSongs => _allSongs;
  List<Song> get filteredSongs => _filteredSongs;
  Set<int> get favorites => _favorites;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;
  int get fontSize => _fontSize;
  bool get isDarkMode => _isDarkMode;

  SongsProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Load songs from assets
      final jsonString = await rootBundle.loadString('assets/songs.json');
      final jsonData = jsonDecode(jsonString) as List<dynamic>;
      
      _allSongs = jsonData
          .map((item) => Song.fromJson(item as Map<String, dynamic>))
          .toList();
      
      _filteredSongs = _allSongs;

      // Load favorites from SharedPreferences
      await _loadFavorites();
      
      // Load settings
      await _loadSettings();
    } catch (e) {
      print('Error loading songs: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoriteIds = prefs.getStringList('favorites') ?? [];
      _favorites = favoriteIds.map((id) => int.parse(id)).toSet();
    } catch (e) {
      print('Error loading favorites: $e');
    }
  }

  Future<void> _loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _fontSize = prefs.getInt('fontSize') ?? 16;
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    } catch (e) {
      print('Error loading settings: $e');
    }
  }

  Future<void> _saveFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoriteIds = _favorites.map((id) => id.toString()).toList();
      await prefs.setStringList('favorites', favoriteIds);
    } catch (e) {
      print('Error saving favorites: $e');
    }
  }

  void search(String query) {
    _searchQuery = query;
    
    if (query.isEmpty) {
      _filteredSongs = _allSongs;
    } else {
      _filteredSongs = _allSongs.where((song) {
        return BanglishConverter.matchesSearch(song.title, query) ||
               BanglishConverter.matchesSearch(song.author, query);
      }).toList();
    }
    
    notifyListeners();
  }

  void toggleFavorite(int songId) async {
    if (_favorites.contains(songId)) {
      _favorites.remove(songId);
    } else {
      _favorites.add(songId);
    }
    
    await _saveFavorites();
    notifyListeners();
  }

  List<Song> getFavoriteSongs() {
    return _allSongs.where((song) => _favorites.contains(song.id)).toList();
  }

  Future<void> setFontSize(int size) async {
    _fontSize = size;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('fontSize', size);
    notifyListeners();
  }

  Future<void> setDarkMode(bool isDark) async {
    _isDarkMode = isDark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);
    notifyListeners();
  }

  Song? getSongById(int id) {
    try {
      return _allSongs.firstWhere((song) => song.id == id);
    } catch (e) {
      return null;
    }
  }
}
