# anim_bottom_nav

Package Bottom Navigation Bar Animation

|              App Display             | 
| :----------------------------------: | 
| <a  target="_blank"><img src="https://user-images.githubusercontent.com/37551474/120936818-95b5f200-c712-11eb-8fda-e92cd9a466e0.gif" width="220"></a> | 

## Usage

```dart
bottomNavigationBar:CustomBottomNavigationBar(
        onPressed: (index) => print('$index'),
        initialIndex: 2,
        iconClickColor: Colors.white,
        iconUnclickColor: Colors.red,
        clickColor: Colors.orange,
        backgroundColor: Colors.blue,
        labelColor: Colors.black,
        actions: [
          NavigationAction(
            icon: Icon(Icons.maps_home_work),
            label: 'Person',
          ),
          NavigationAction(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
          NavigationAction(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationAction(
            icon: Icon(Icons.details_outlined),
            label: 'Detail',
          ),
          NavigationAction(
            icon: Icon(Icons.maps_ugc),
            label: 'Map',
          ),
        ],
      ),
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
