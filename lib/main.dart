import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigation Rail',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _isExtended = true;

  final List<RecipeCategory> _categories = [
    RecipeCategory(
      name: 'Breakfast',
      subcategories: [
        RecipeSubcategory(name: 'American'),
        RecipeSubcategory(name: 'Sandwiches'),
        RecipeSubcategory(name: 'Indian'),
      ],
    ),
    RecipeCategory(
      name: 'Lunch',
      subcategories: [
        RecipeSubcategory(name: 'Salads'),
        RecipeSubcategory(name: 'Rice Meal'),
        RecipeSubcategory(name: 'Soups'),
      ],
    ),
    RecipeCategory(
      name: 'Dinner',
      subcategories: [
        RecipeSubcategory(name: 'Mexican'),
        RecipeSubcategory(name: 'Chinese'),
        RecipeSubcategory(name: 'Italian'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Rail'),
      ),
      body: 
      Row(
        children: [
          NavigationRail(
            destinations: _buildNavigationDestinations(),
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            elevation: 10,
            indicatorColor: Colors.lightBlueAccent.shade100,
            useIndicator: true,
            extended: _isExtended,
            //labelType: NavigationRailLabelType.selected,
            leading: IconButton(
              icon: Icon(_isExtended ? Icons.arrow_back : Icons.menu),
              onPressed: () {
                setState(() {
                  _isExtended = !_isExtended;
                });
              },
            ),
            trailing: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {},
            ),
          ),
          const VerticalDivider(width: 5,),
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  List<NavigationRailDestination> _buildNavigationDestinations() {
    // return _categories.map((category) {
    //   return NavigationRailDestination(
    //     icon: Icon(Icons.restaurant),
    //     label: Text(category.name),
    //   );
    // }).toList();
    return [
      const NavigationRailDestination(
        icon: Icon(Icons.breakfast_dining_sharp),
        label: Text('Breakfast'),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.lunch_dining),
        label: Text('Lunch'),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.restaurant),
        label: Text('Dinner'),
      ),
    ];
  }

  Widget _buildContent() {
    final selectedCategory = _categories[_selectedIndex];
    return ListView.builder(
      itemCount: selectedCategory.subcategories.length,
      itemBuilder: (context, index) {
        final subcategory = selectedCategory.subcategories[index];
        return ListTile(
          title: Text(subcategory.name),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    RecipeListScreen(subcategory: subcategory),
              ),
            );
          },
        );
      },
    );
  }
}

class RecipeCategory {
  final String name;
  final List<RecipeSubcategory> subcategories;

  RecipeCategory({required this.name, required this.subcategories});
}

class RecipeSubcategory {
  final String name;

  RecipeSubcategory({required this.name});
}

class RecipeListScreen extends StatelessWidget {
  final RecipeSubcategory subcategory;

  RecipeListScreen({required this.subcategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subcategory.name),
      ),
      body: Center(
        child: Text('Recipe list for ${subcategory.name}'),
      ),
    );
  }
}
