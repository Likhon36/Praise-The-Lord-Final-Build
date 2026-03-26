import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/songs_provider.dart';
import 'song_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SongsProvider>(
      builder: (context, songsProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('🎵 Praise the LORD'),
            subtitle: const Text('Bengali Christian Hymns'),
            elevation: 0,
          ),
          body: Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    songsProvider.search(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search (Bengali or Banglish)...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              songsProvider.search('');
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              // Song List
              Expanded(
                child: songsProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : songsProvider.filteredSongs.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.music_note, size: 64, color: Colors.grey),
                                const SizedBox(height: 16),
                                const Text('No songs found'),
                                const SizedBox(height: 8),
                                Text(
                                  'Try searching in Bengali or Banglish\n(e.g., "amar", "prabhу")',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: songsProvider.filteredSongs.length,
                            itemBuilder: (context, index) {
                              final song = songsProvider.filteredSongs[index];
                              final isFavorite = songsProvider.favorites.contains(song.id);

                              return ListTile(
                                leading: const Icon(Icons.music_note),
                                title: Text('🎶 ${song.title}'),
                                subtitle: Text(song.author),
                                trailing: IconButton(
                                  icon: Icon(
                                    isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: isFavorite ? Colors.red : null,
                                  ),
                                  onPressed: () {
                                    songsProvider.toggleFavorite(song.id);
                                  },
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => SongDetailScreen(songId: song.id),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
              ),
            ],
          ),
        );
      },
    );
  }
}
