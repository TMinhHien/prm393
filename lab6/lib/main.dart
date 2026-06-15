import 'package:flutter/material.dart';

void main() {
  runApp(const MovieBrowserApp());
}

class Movie {
  const Movie({
    required this.title,
    required this.year,
    required this.genres,
    required this.posterUrl,
    required this.rating,
  });

  final String title;
  final int year;
  final List<String> genres;
  final String posterUrl;
  final double rating;
}

const List<Movie> allMovies = [
  Movie(
    title: 'Interstellar',
    year: 2014,
    genres: ['Sci-Fi', 'Drama', 'Adventure'],
    posterUrl: 'https://picsum.photos/seed/interstellar/360/520',
    rating: 8.7,
  ),
  Movie(
    title: 'Mad Max: Fury Road',
    year: 2015,
    genres: ['Action', 'Adventure', 'Thriller'],
    posterUrl: 'https://picsum.photos/seed/furyroad/360/520',
    rating: 8.1,
  ),
  Movie(
    title: 'The Grand Budapest Hotel',
    year: 2014,
    genres: ['Comedy', 'Drama', 'Adventure'],
    posterUrl: 'https://picsum.photos/seed/grandbudapest/360/520',
    rating: 8.1,
  ),
  Movie(
    title: 'Arrival',
    year: 2016,
    genres: ['Sci-Fi', 'Drama', 'Thriller'],
    posterUrl: 'https://picsum.photos/seed/arrival/360/520',
    rating: 7.9,
  ),
  Movie(
    title: 'Knives Out',
    year: 2019,
    genres: ['Comedy', 'Drama', 'Thriller'],
    posterUrl: 'https://picsum.photos/seed/knivesout/360/520',
    rating: 7.9,
  ),
  Movie(
    title: 'Top Gun: Maverick',
    year: 2022,
    genres: ['Action', 'Drama'],
    posterUrl: 'https://picsum.photos/seed/maverick/360/520',
    rating: 8.2,
  ),
];

class MovieBrowserApp extends StatelessWidget {
  const MovieBrowserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Browser',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2F6FED),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F7FB),
      ),
      home: const MovieBrowserPage(),
    );
  }
}

class MovieBrowserPage extends StatefulWidget {
  const MovieBrowserPage({super.key});

  @override
  State<MovieBrowserPage> createState() => _MovieBrowserPageState();
}

class _MovieBrowserPageState extends State<MovieBrowserPage> {
  final TextEditingController _searchController = TextEditingController();
  final Set<String> selectedGenres = <String>{};
  final List<String> genres = const [
    'Action',
    'Drama',
    'Comedy',
    'Sci-Fi',
    'Thriller',
    'Adventure',
  ];

  String searchQuery = '';
  String sortBy = 'A-Z';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Movie> get visibleMovies {
    final query = searchQuery.trim().toLowerCase();

    final movies = allMovies.where((movie) {
      final matchesSearch = movie.title.toLowerCase().contains(query);
      final matchesGenre =
          selectedGenres.isEmpty ||
          movie.genres.any((genre) => selectedGenres.contains(genre));
      return matchesSearch && matchesGenre;
    }).toList();

    switch (sortBy) {
      case 'Z-A':
        movies.sort((a, b) => b.title.compareTo(a.title));
        break;
      case 'Year':
        movies.sort((a, b) => b.year.compareTo(a.year));
        break;
      case 'Rating':
        movies.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'A-Z':
      default:
        movies.sort((a, b) => a.title.compareTo(b.title));
    }

    return movies;
  }

  void _clearFilters() {
    setState(() {
      searchQuery = '';
      selectedGenres.clear();
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 800;
            final horizontalPadding = isWide ? 32.0 : 18.0;
            final movies = visibleMovies;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    24,
                    horizontalPadding,
                    16,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Find a Movie',
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF172033),
                              ),
                        ),
                        const SizedBox(height: 18),
                        TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            setState(() => searchQuery = value);
                          },
                          decoration: InputDecoration(
                            hintText: 'Search movies...',
                            prefixIcon: const Icon(Icons.search),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        _GenreFilter(
                          genres: genres,
                          selectedGenres: selectedGenres,
                          onSelected: (genre, selected) {
                            setState(() {
                              if (selected) {
                                selectedGenres.add(genre);
                              } else {
                                selectedGenres.remove(genre);
                              }
                            });
                          },
                        ),
                        const SizedBox(height: 18),
                        _SortBar(
                          sortBy: sortBy,
                          selectedCount: selectedGenres.length,
                          hasFilters:
                              selectedGenres.isNotEmpty ||
                              searchQuery.trim().isNotEmpty,
                          onSortChanged: (value) {
                            if (value != null) {
                              setState(() => sortBy = value);
                            }
                          },
                          onClear: _clearFilters,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${movies.length} movie${movies.length == 1 ? '' : 's'} found',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: const Color(0xFF657084)),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: movies.isEmpty
                      ? const Center(
                          child: Text(
                            'No movies match your filters.',
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      : isWide
                      ? GridView.count(
                          padding: EdgeInsets.fromLTRB(
                            horizontalPadding,
                            0,
                            horizontalPadding,
                            28,
                          ),
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.8,
                          children: movies
                              .map((movie) => MovieCard(movie: movie))
                              .toList(),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.fromLTRB(
                            horizontalPadding,
                            0,
                            horizontalPadding,
                            24,
                          ),
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 14),
                              child: MovieCard(movie: movies[index]),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _GenreFilter extends StatelessWidget {
  const _GenreFilter({
    required this.genres,
    required this.selectedGenres,
    required this.onSelected,
  });

  final List<String> genres;
  final Set<String> selectedGenres;
  final void Function(String genre, bool selected) onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: genres.map((genre) {
        return ChoiceChip(
          label: Text(genre),
          selected: selectedGenres.contains(genre),
          onSelected: (selected) => onSelected(genre, selected),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        );
      }).toList(),
    );
  }
}

class _SortBar extends StatelessWidget {
  const _SortBar({
    required this.sortBy,
    required this.selectedCount,
    required this.hasFilters,
    required this.onSortChanged,
    required this.onClear,
  });

  final String sortBy;
  final int selectedCount;
  final bool hasFilters;
  final ValueChanged<String?> onSortChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: sortBy,
              items: const [
                DropdownMenuItem(value: 'A-Z', child: Text('A-Z')),
                DropdownMenuItem(value: 'Z-A', child: Text('Z-A')),
                DropdownMenuItem(value: 'Year', child: Text('Year')),
                DropdownMenuItem(value: 'Rating', child: Text('Rating')),
              ],
              onChanged: onSortChanged,
            ),
          ),
        ),
        Chip(
          avatar: const Icon(Icons.local_offer_outlined, size: 18),
          label: Text('$selectedCount selected'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        OutlinedButton.icon(
          onPressed: hasFilters ? onClear : null,
          icon: const Icon(Icons.clear, size: 18),
          label: const Text('Clear Filters'),
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 520;
        final posterWidth = isCompact ? 112.0 : 150.0;
        final posterHeight = isCompact ? 158.0 : 198.0;

        return Card(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          clipBehavior: Clip.antiAlias,
          child: Row(
            children: [
              SizedBox(
                width: posterWidth,
                height: posterHeight,
                child: Image.network(
                  movie.posterUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFFE2E6EF),
                      child: const Icon(Icons.movie, size: 42),
                    );
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF172033),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${movie.year}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF657084),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: movie.genres.map((genre) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEAF0FF),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              genre,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF2F57B7),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Color(0xFFFFB020),
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            movie.rating.toStringAsFixed(1),
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF172033),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
