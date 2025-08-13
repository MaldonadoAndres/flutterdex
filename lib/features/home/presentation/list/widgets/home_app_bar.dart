import 'package:flutter/material.dart';
import 'package:pokedex/app/router/pokemon_router.gr.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    required this.onSearch,
    required this.onCancelSearch,
  });
  final Function(String) onSearch;
  final Function() onCancelSearch;

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeAppBarState extends State<HomeAppBar> {
  bool isSearching = false;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: !isSearching
          ? const Text(
              'FlutterDex',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )
          : TextField(
              onChanged: (value) {
                widget.onSearch(value);
              },
              decoration: InputDecoration(
                hintText: 'Search Pokémon',
                hintStyle: const TextStyle(fontSize: 18, color: Colors.white70),
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        widget.onCancelSearch();
                        setState(() {
                          isSearching = false;
                        });
                      },
                      icon: const Icon(Icons.close, color: Colors.white70),
                    ),
                  ],
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
              ),
              style: const TextStyle(fontSize: 18, color: Colors.white),
              textAlignVertical: TextAlignVertical.center,
            ),
      centerTitle: true,
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
      actions: !isSearching
          ? [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => setState(() {
                  isSearching = true;
                }),
              ),
              IconButton(
                icon: const Icon(Icons.favorite_outline),
                onPressed: () => const FavoritesRoute().push(context),
              ),
            ]
          : null,
    );
  }
}
