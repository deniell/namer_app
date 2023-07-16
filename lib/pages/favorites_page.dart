import 'package:flutter/material.dart';
import 'package:namer_app/core/app_state.dart';
import 'package:provider/provider.dart';


class FavoritesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var appState = context.watch<AppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Text('You have '
              '${appState.favorites.length} favorites:'),
        ),
        Expanded(
          // Make better use of wide windows with a grid.
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: GridView(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 450,
                childAspectRatio: 450 / 80,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5
              ),
              children: [
                for (var pair in appState.favorites)
                  Container(
                    color: theme.colorScheme.inversePrimary,
                    child: ListTile(
                        leading: Icon(Icons.favorite, color: Colors.pink),
                        title: Text(
                          pair.asPascalCase,
                          semanticsLabel: pair.asPascalCase,
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete_outline, semanticLabel: 'Delete'),
                          color: theme.colorScheme.primary,
                          onPressed: () {
                            appState.removeFavorite(pair);
                          },
                        ),
                      ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}