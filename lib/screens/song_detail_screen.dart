import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/songs_provider.dart';

class SongDetailScreen extends StatelessWidget {
  final int songId;

  const SongDetailScreen({Key? key, required this.songId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SongsProvider>(
      builder: (context, songsProvider, _) {
        final song = songsProvider.getSongById(songId);
        if (song == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Song Not Found')),
            body: const Center(child: Text('Song not found')),
          );
        }

        final isFavorite = songsProvider.favorites.contains(song.id);

        return Scaffold(
          appBar: AppBar(
            title: Text(song.title),
            actions: [
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
                onPressed: () {
                  songsProvider.toggleFavorite(song.id);
                },
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  Share.share(
                    '🎵 ${song.title}\n\nBy: ${song.author}\n\n${song.lyrics}',
                    subject: 'Praise the LORD - ${song.title}',
                  );
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Song Title
                Text(
                  song.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                // Author
                Text(
                  'By: ${song.author}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                ),
                const SizedBox(height: 24),
                // Lyrics
                Text(
                  song.lyrics,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: songsProvider.fontSize.toDouble(),
                        height: 1.6,
                      ),
                ),
                // Chords if available
                if (song.chords != null && song.chords!.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),
                  Text(
                    'Chords',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    song.chords!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontFamily: 'monospace',
                        ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
