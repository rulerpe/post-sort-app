import 'package:english_words/english_words.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:DuXin/pages/camera_page.dart';
import 'package:DuXin/pages/home_page.dart';
import 'package:DuXin/pages/login_signup_page.dart';
import 'package:DuXin/pages/summary_page.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';
import 'amplifyconfiguration.dart';
import './url_strategy/url_strategy.dart';
import 'package:provider/provider.dart';
import './summary_page_arg_providar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

// import 'package:flutter_web_plugins/flutter_web_plugins.dart';
// import 'package:camera/camera.dart';

// import 'dart:async';
// import 'dart:io';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final cameras = await availableCameras();
//   final firstCamera = cameras.first;

//   runApp(
//     MaterialApp(
//       theme: ThemeData.dark(),
//       home: MyApp( camera:firstCamera)
//     )
//   )
// }

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => MyAppState(),
//       child: MaterialApp(
//         title: 'Namer App',
//         theme: ThemeData(
//           useMaterial3: true,
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
//         ),
//         home: MyHomePage(),
//       ),
//     );
//   }
// }

// class MyAppState extends ChangeNotifier {
//   var current = WordPair.random();

//   void getNext() {
//     current = WordPair.random();
//     notifyListeners();
//   }

//   var favorites = <WordPair>[];

//   void toggleFavorite() {
//     if (favorites.contains(current)) {
//       favorites.remove(current);
//     } else {
//       favorites.add(current);
//     }
//     notifyListeners();
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   var selectedIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     Widget page;
//     switch (selectedIndex) {
//       case 0:
//         page = GeneratorPage();
//         break;
//       case 1:
//         page = FavoritePage();
//         break;
//       default:
//         throw UnimplementedError("no widget for $selectedIndex");
//     }
//     return LayoutBuilder(builder: (context, constraints) {
//       return Scaffold(
//         body: Row(
//           children: [
//             SafeArea(
//               child: NavigationRail(
//                 extended: constraints.maxWidth >= 600,
//                 destinations: [
//                   NavigationRailDestination(
//                     icon: Icon(Icons.home),
//                     label: Text('Home'),
//                   ),
//                   NavigationRailDestination(
//                     icon: Icon(Icons.favorite),
//                     label: Text('Favorites'),
//                   ),
//                 ],
//                 selectedIndex: selectedIndex,
//                 onDestinationSelected: (value) {
//                   setState(() {
//                     selectedIndex = value;
//                   });
//                 },
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 color: Theme.of(context).colorScheme.primaryContainer,
//                 child: page,
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }

// class FavoritePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var appState = context.watch<MyAppState>();
//     var favorites = appState.favorites;
//     if (favorites.isEmpty) {
//       return Center(
//         child: Text('No favorites yet.'),
//       );
//     }
//     return ListView(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(20),
//           child: Text('You have '
//               '${appState.favorites.length} favorites:'),
//         ),
//         for (var pair in favorites)
//           ListTile(
//               leading: Icon(Icons.favorite),
//               title: Text(
//                 pair.asLowerCase,
//               )),
//       ],
//     );
//   }
// }

// class GeneratorPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var appState = context.watch<MyAppState>();
//     var pair = appState.current;

//     IconData icon;
//     if (appState.favorites.contains(pair)) {
//       icon = Icons.favorite;
//     } else {
//       icon = Icons.favorite_border;
//     }

//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           BigCard(pair: pair),
//           SizedBox(height: 10),
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ElevatedButton.icon(
//                 onPressed: () {
//                   appState.toggleFavorite();
//                 },
//                 icon: Icon(icon),
//                 label: Text('Like'),
//               ),
//               SizedBox(width: 10),
//               ElevatedButton(
//                 onPressed: () {
//                   appState.getNext();
//                 },
//                 child: Text('Next'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class BigCard extends StatelessWidget {
//   const BigCard({
//     super.key,
//     required this.pair,
//   });

//   final WordPair pair;

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final style = theme.textTheme.displayMedium!.copyWith(
//       color: theme.colorScheme.onPrimary,
//     );
//     return Card(
//       color: theme.colorScheme.primary,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(
//           pair.asLowerCase,
//           style: style,
//           semanticsLabel: "${pair.first} ${pair.second}",
//         ),
//       ),
//     );
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setCustomUrlStrategy();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAtORH9WegXFON540Fns7h7Z7bEVkhqEm0",
          authDomain: "duxin-617c5.firebaseapp.com",
          projectId: "duxin-617c5",
          storageBucket: "duxin-617c5.appspot.com",
          messagingSenderId: "757621203313",
          appId: "1:757621203313:web:9f8b73b412bd85829d96d0",
          measurementId: "G-7MF6TYZP9Z"));
  runApp(ChangeNotifierProvider(
      // create global state
      create: (context) => SummaryPageArgumentsProvider(),
      child: MyApp()));
  _configureAmplify();
}

void _configureAmplify() async {
  Amplify.addPlugins([AmplifyAPI()]);

  try {
    await Amplify.configure(amplifyconfig);
    print("Successfully configured Amplify 🎉");
  } catch (e) {
    print("Could not configure Amplify: $e");
  }
}

class MyApp extends StatelessWidget {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "DuXin",
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.white, // used by AppBar
          secondary:
              Colors.white, // used by FloatingActionButtons and ButtonText
        ),
        fontFamily: 'Roboto',

        // Define the default `ElevatedButton` theme.
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0))),
        ),
        // AppBar theme
        appBarTheme: AppBarTheme(
          color: Colors.blue,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          iconTheme: IconThemeData(
            color: Colors.white, // Here's the navigation arrow color
          ),
        ),

        // CircularProgressIndicator theme
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: Colors.blue, // CircularProgressIndicator color
        ),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => HomePage(analytics: analytics),
        "/camera": (context) => CameraPage(),
        "/login": (context) => LoginSignUpPage(),
        "/summary": (context) => SummaryPage()
      },
    );
  }
}
