import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSwatch().copyWith(primary: Colors.red),
      ),
      home: const MovieHomePage(),
    );
  }
}

class Movie {
  final String title;
  final String image;
  final String genre;
  final String description;
  double rating;

  Movie(this.title, this.image, this.genre, this.description, this.rating);
}

class MovieHomePage extends StatefulWidget {
  const MovieHomePage({super.key});

  @override
  State<MovieHomePage> createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<MovieHomePage> {
  final List<Movie> allMovies = [
    // Sci-Fi Movies
    Movie(
      'Inception',
      'assets/images/inception.jpg',
      'Sci-Fi',
      'A thief steals dreams.',
      4.8,
    ),
    Movie(
      'The Matrix',
      'assets/images/matrix.jpg',
      'Sci-Fi',
      'Virtual reality world.',
      4.7,
    ),
    Movie(
      'Tenet',
      'assets/images/tenet.jpg',
      'Sci-Fi',
      'Time inversion mission.',
      4.6,
    ),
    Movie(
      'Edge of Tomorrow',
      'assets/images/edge.jpg',
      'Sci-Fi',
      'Time loop war.',
      4.5,
    ),
    Movie(
      'Blade Runner 2049',
      'assets/images/bladerunner.jpg',
      'Sci-Fi',
      'Cyborg detective.',
      4.4,
    ),
    Movie(
      'Avatar',
      'assets/images/avatar.jpg',
      'Sci-Fi',
      'Alien world of Pandora.',
      4.8,
    ),
    Movie(
      'Gravity',
      'assets/images/gravity.jpg',
      'Sci-Fi',
      'Lost in space.',
      4.3,
    ),
    Movie(
      'Dune',
      'assets/images/dune.jpg',
      'Sci-Fi',
      'Desert planet politics.',
      4.6,
    ),
    Movie(
      'Arrival',
      'assets/images/arrival.jpg',
      'Sci-Fi',
      'Alien communication.',
      4.7,
    ),
    Movie(
      'Oblivion',
      'assets/images/oblivion.jpg',
      'Sci-Fi',
      'Post-apocalyptic Earth.',
      4.2,
    ),

    // Adventure Movies
    Movie(
      'Interstellar',
      'assets/images/interstellar.jpg',
      'Adventure',
      'Journey through space.',
      4.7,
    ),
    Movie(
      'The Revenant',
      'assets/images/revenant.jpg',
      'Adventure',
      'Survival in wilderness.',
      4.6,
    ),
    Movie(
      'Jumanji',
      'assets/images/jumanji.jpg',
      'Adventure',
      'Game world adventure.',
      4.4,
    ),
    Movie(
      'Life of Pi',
      'assets/images/lifeofpi.jpg',
      'Adventure',
      'Boy and tiger survive.',
      4.5,
    ),
    Movie(
      'Jurassic Park',
      'assets/images/jurassic.jpg',
      'Adventure',
      'Dinosaurs return.',
      4.6,
    ),
    Movie(
      'Pirates of the Caribbean',
      'assets/images/pirates.jpg',
      'Adventure',
      'Pirate quest.',
      4.5,
    ),
    Movie(
      'The Hobbit',
      'assets/images/hobbit.jpg',
      'Adventure',
      'Dwarf treasure journey.',
      4.3,
    ),
    Movie(
      'King Kong',
      'assets/images/kingkong.jpg',
      'Adventure',
      'Giant ape captured.',
      4.4,
    ),
    Movie(
      'Cast Away',
      'assets/images/castaway.jpg',
      'Adventure',
      'Man stranded on island.',
      4.5,
    ),
    Movie(
      'Up',
      'assets/images/up.jpg',
      'Adventure',
      'House flies with balloons.',
      4.6,
    ),

    // Drama Movies
    Movie('Joker', 'assets/images/joker.jpg', 'Drama', 'Origin of Joker.', 4.6),
    Movie(
      'The Pursuit of Happyness',
      'assets/images/happyness.jpg',
      'Drama',
      'Struggle to success.',
      4.8,
    ),
    Movie(
      'Forrest Gump',
      'assets/images/gump.jpg',
      'Drama',
      'Life journey of simple man.',
      4.9,
    ),
    Movie(
      'The Shawshank Redemption',
      'assets/images/shawshank.jpg',
      'Drama',
      'Hope in prison.',
      5.0,
    ),
    Movie(
      'A Beautiful Mind',
      'assets/images/beautifulmind.jpg',
      'Drama',
      'Genius with schizophrenia.',
      4.7,
    ),
    Movie(
      'The Green Mile',
      'assets/images/greenmile.jpg',
      'Drama',
      'Miraculous prisoner.',
      4.8,
    ),
    Movie(
      'Fight Club',
      'assets/images/fightclub.jpg',
      'Drama',
      'Split personality.',
      4.7,
    ),
    Movie(
      '12 Years a Slave',
      'assets/images/slave.jpg',
      'Drama',
      'Fight for freedom.',
      4.6,
    ),
    Movie('Room', 'assets/images/room.jpg', 'Drama', 'Trapped in a room.', 4.5),
    Movie(
      'Moonlight',
      'assets/images/moonlight.jpg',
      'Drama',
      'Life of a young man.',
      4.4,
    ),

    // Action Movies
    Movie(
      'Avengers: Endgame',
      'assets/images/endgame.jpg',
      'Action',
      'Final battle.',
      4.5,
    ),
    Movie(
      'Mad Max: Fury Road',
      'assets/images/madmax.jpg',
      'Action',
      'Post-apocalyptic chaos.',
      4.6,
    ),
    Movie(
      'John Wick',
      'assets/images/johnwick.jpg',
      'Action',
      'Revenge of assassin.',
      4.7,
    ),
    Movie(
      'The Dark Knight',
      'assets/images/darkknight.jpg',
      'Action',
      'Joker vs Batman.',
      5.0,
    ),
    Movie(
      'Gladiator',
      'assets/images/gladiator.jpg',
      'Action',
      'Roman warrior revenge.',
      4.8,
    ),
    Movie(
      'Skyfall',
      'assets/images/skyfall.jpg',
      'Action',
      'James Bond returns.',
      4.6,
    ),
    Movie(
      'Mission: Impossible – Fallout',
      'assets/images/mi.jpg',
      'Action',
      'Spy thriller.',
      4.5,
    ),
    Movie(
      'Black Panther',
      'assets/images/panther.jpg',
      'Action',
      'Wakanda fights back.',
      4.7,
    ),
    Movie(
      'The Raid',
      'assets/images/raid.jpg',
      'Action',
      'Police in criminal tower.',
      4.6,
    ),
    Movie(
      'Logan',
      'assets/images/logan.jpg',
      'Action',
      'Old Wolverine’s last stand.',
      4.7,
    ),
  ];

  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadSavedRatings();
  }

  Future<void> _loadSavedRatings() async {
    final prefs = await SharedPreferences.getInstance();
    for (var movie in allMovies) {
      final savedRating = prefs.getDouble(movie.title);
      if (savedRating != null) {
        movie.rating = savedRating;
      }
    }
    setState(() {});
  }

  void _saveRating(String title, double rating) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble(title, rating);
  }

  void _navigateToGenreScreen(String genre) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder:
            (_, __, ___) =>
                GenreMoviesScreen(genre: genre, allMovies: allMovies),
        transitionsBuilder:
            (_, animation, __, child) => SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Movie> filteredMovies =
        allMovies.where((movie) {
          return movie.title.toLowerCase().contains(searchQuery.toLowerCase());
        }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Ratings'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search by movie name...',
                hintStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.search, color: Colors.red),
                filled: true,
                fillColor: Colors.black45,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
              ),
              style: const TextStyle(color: Colors.white),
              onChanged: (value) => setState(() => searchQuery = value),
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children:
                  ['All', 'Sci-Fi', 'Adventure', 'Drama', 'Action'].map((
                    genre,
                  ) {
                    return GestureDetector(
                      onTap: () => _navigateToGenreScreen(genre),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 10,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          genre,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMovies.length,
              itemBuilder: (context, index) {
                final movie = filteredMovies[index];
                return MovieCard(
                  movie: movie,
                  onRatingUpdate: (rating) {
                    setState(() => movie.rating = rating);
                    _saveRating(movie.title, rating);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class GenreMoviesScreen extends StatefulWidget {
  final String genre;
  final List<Movie> allMovies;

  const GenreMoviesScreen({
    super.key,
    required this.genre,
    required this.allMovies,
  });

  @override
  State<GenreMoviesScreen> createState() => _GenreMoviesScreenState();
}

class _GenreMoviesScreenState extends State<GenreMoviesScreen> {
  late List<Movie> genreMovies;

  @override
  void initState() {
    super.initState();
    genreMovies =
        widget.genre == 'All'
            ? widget.allMovies
            : widget.allMovies
                .where((movie) => movie.genre == widget.genre)
                .toList();
    _loadSavedRatings();
  }

  Future<void> _loadSavedRatings() async {
    final prefs = await SharedPreferences.getInstance();
    for (var movie in genreMovies) {
      final savedRating = prefs.getDouble(movie.title);
      if (savedRating != null) {
        movie.rating = savedRating;
      }
    }
    setState(() {});
  }

  void _saveRating(String title, double rating) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble(title, rating);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.genre} Movies'),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        itemCount: genreMovies.length,
        itemBuilder: (context, index) {
          final movie = genreMovies[index];
          return MovieCard(
            movie: movie,
            onRatingUpdate: (rating) {
              setState(() => movie.rating = rating);
              _saveRating(movie.title, rating);
            },
          );
        },
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;
  final Function(double) onRatingUpdate;

  const MovieCard({
    super.key,
    required this.movie,
    required this.onRatingUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 220,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent.withOpacity(0.7),
                        blurRadius: 25,
                        spreadRadius: 3,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.asset(
                    movie.image,
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  movie.genre,
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 4),
                Text(
                  movie.description,
                  style: const TextStyle(color: Colors.white54),
                ),
                const SizedBox(height: 8),
                RatingBar.builder(
                  initialRating: movie.rating,
                  minRating: 1,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 24.0,
                  direction: Axis.horizontal,
                  itemBuilder:
                      (context, _) =>
                          const Icon(Icons.star, color: Colors.white),
                  onRatingUpdate: onRatingUpdate,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
