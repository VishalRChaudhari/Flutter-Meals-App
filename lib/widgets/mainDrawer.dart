import 'package:flutter/material.dart';


class MainDawer extends StatelessWidget {
  const MainDawer({super.key,required this.onSelectScreen});

  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8)
              ], end: Alignment.bottomRight, begin: Alignment.topLeft),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.fastfood,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text('Cookind it',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary)),
              ],
            ),
          ),
          ListTile(
            title: Text('Meals',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground)),
            leading: const Icon(
              Icons.restaurant,
              size: 30,
            ),
            onTap: () {
              onSelectScreen('meal');
            },
          ),
          ListTile(
            title: Text('Filters',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground)),
            leading: const Icon(
              Icons.settings,
              size: 30,
            ),
            onTap: () {
              onSelectScreen('filters');
            },
          ),
        ],
      ),
    );
  }
}
