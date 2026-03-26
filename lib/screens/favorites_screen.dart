import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/songs_provider.dart';
import 'song_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SongsProvider>(
      builder: (context, songsProvider, _) {
        final favoriteSongs = songsProvider.getFavoriteSongs();

        return Scaffold(
          appBar: AppBar(
            title: const Text('❤️ Favorites'),
            elevation: 0,
          ),
          body: favoriteSongs.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      const Text('No favorites yet'),
                      const SizedBox(height: 8),
                      Text(
                        'Add songs to your favorites to see them here',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: favoriteSongs.length,
                  itemBuilder: (context, index) {
                    final song = favoriteSongs[index];

                    return ListTile(
                      leading: const Icon(Icons.music_note),
                      title: Text('🎶 ${song.title}'),
                      subtitle: Text(song.author),
                      trailing: IconButton(
                        icon: const Icon(Icons.favorite, color: Colors.red),
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
        );
      },
    );
  }
}
