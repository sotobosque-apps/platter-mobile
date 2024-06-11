import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:platter/change_notifiers/AppNotifier.dart';
import 'package:platter/change_notifiers/AppStatusNotifier.dart';
import 'package:platter/change_notifiers/AuthNotifier.dart';
import 'package:platter/change_notifiers/FirebaseAuthNotifier.dart';
import 'package:platter/change_notifiers/UserSessionNotifier.dart';
import 'package:platter/common_background.dart';
import 'package:platter/components/loadingScreen.dart';
import 'package:platter/footer/footer.dart';
import 'package:platter/head/comments_review_header.dart';
import 'package:platter/head/content_review_header.dart';
import 'package:platter/head/empty_header.dart';
import 'package:platter/head/header.dart';
import 'package:platter/head/home_header.dart';
import 'package:platter/head/input_header.dart';
import 'package:platter/head/search_header.dart';
import 'package:platter/mobile_constants.dart';
import 'package:platter/page.dart';
import 'package:platter/pages/collection.dart';
import 'package:platter/pages/comments_section.dart';
import 'package:platter/pages/content_review.dart';
import 'package:platter/pages/galleryview.dart';
import 'package:platter/pages/home.dart';
import 'package:platter/pages/home_search.dart';
import 'package:platter/pages/input_screen.dart';
import 'package:platter/pages/onboard_first_stage.dart';
import 'package:platter/pages/product_matches.dart';
import 'package:platter/pages/profile.dart';
import 'package:platter/pages/recent_history.dart';
import 'package:platter/pages/search_results.dart';
import 'package:platter/pages/sign_in.dart';
import 'package:platter/pages/sign_in_password.dart';
import 'package:platter/pages/sign_up.dart';
import 'package:platter/pages/sign_up_final_stage.dart';
import 'package:platter/pages/sign_up_first_stage.dart';
import 'package:platter/pages/trendy_content.dart';
import 'package:platter/test_suite.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:dotenv/dotenv.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
dynamic env = {};

void main() async {
  env = DotEnv(includePlatformEnvironment: false)..load(['.env']);
  await Future.delayed(const Duration(seconds: 3));
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (c) => AppStatusNotifier()),
    ChangeNotifierProvider(create: (c) => AppNotifier()),
    ChangeNotifierProvider(create: (c) => AuthNotifier()),
    ChangeNotifierProvider(create: (c) => FirebaseAuthNotifier()),
    ChangeNotifierProvider(create: (c) => UserSessionNotifier()),
  ], child: const MyApp()));
}

class MyRouteObserver extends NavigatorObserver {
  bool enableyDefOnNextPush = false;

  @override
  void didPush(Route route, Route? previousRoute) {
    // TODO: implement didPush
    super.didPush(route, previousRoute);
    final args = route.settings.arguments as Map?;
    final y = Provider.of<UserSessionNotifier>(
        navigatorGrandKey.currentContext!,
        listen: false);
    final ydef = y.sessionOn;

    var notifier = Provider.of<AppStatusNotifier>(
        navigatorGrandKey.currentContext!,
        listen: false);
    notifier.setRouteArgs(args);

    if (route.settings.name == "loading") {
      String _route = args?["route"] ?? "sign_in_password";

      y.logOff();
      // print("calling delayed");

      String check = args?["CONTENT_ERROR_CHECK"] ?? "";

      Future.delayed(const Duration(seconds: 3), () {
        if (check.isNotEmpty) {
          print("notifier.data(check)");
          print(notifier.data(check));
          if (notifier.data(check).containsKey("error") == false && notifier.data(check).isNotEmpty) {
            navigatorGrandKey.currentState!.pushNamedAndRemoveUntil(
                _route, (route) => false,
                arguments: route.settings.arguments);
          } else {
            navigatorGrandKey.currentState!.pushNamedAndRemoveUntil(
                args?["_route"] ?? 'sign_in', (route) => false,
                arguments: route.settings.arguments);
          }
        } else {
          navigatorGrandKey.currentState!.pushNamedAndRemoveUntil(
              _route, (route) => false,
              arguments: route.settings.arguments);
        }
      }).whenComplete(() {
        if (ydef == true) {
          y.setLoginTrue();
        }
      });
    } else if (enableyDefOnNextPush) {
      y.setLoginTrue();
      enableyDefOnNextPush = false;
    }

    if (route.settings.name == "gallery") {
      enableyDefOnNextPush = true;
      y.logOff();
    }

    if (route.settings.name == "home") {
      Provider.of<UserSessionNotifier>(navigatorGrandKey.currentContext!,
              listen: false)
          .setLoginTrue();
    }
    // print('Route pushed: ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    final y = Provider.of<UserSessionNotifier>(
        navigatorGrandKey.currentContext!,
        listen: false);
    if (enableyDefOnNextPush) {
      y.setLoginTrue();
      enableyDefOnNextPush = false;
    }
    // This method will be called whenever a route is popped.
    // print('Route popped from: ${route.settings.name}');
    // print('Route popped to: ${previousRoute?.settings.name}');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final white = Colors.white;
    final routes = {
      "test": (context) => Scaffold(
            backgroundColor: white,
            drawerScrimColor: white,
            body: const CommonBackground(child: TestSuite()),
          ),
      "suited_trendy_content": (context) => const Scaffold(
            extendBodyBehindAppBar: true,
            appBar: const SearchHeader(),
            body: CommonBackground(
              child: TrendyContent(),
            ),
          ),
      "suited_untrendy_content": (context) => const Scaffold(
            extendBodyBehindAppBar: true,
            appBar: const SearchHeader(),
            body: CommonBackground(
              child: TrendyContent(
                trendy: false,
              ),
            ),
          ),
      "loading": (context) => Scaffold(
          backgroundColor: Colors.amber.shade300, body: const LoadingScreen()),
      "comments_section": (context) => Scaffold(
          backgroundColor: white,
          appBar: const CommentsReviewHeader(),
          extendBodyBehindAppBar: true,
          body: const CommonBackground(child: CommentsSection())),
      "input": (context) => Scaffold(
          backgroundColor: white,
          appBar: const InputHeader(),
          extendBodyBehindAppBar: true,
          body: const CommonBackground(child: InputScreen())),
      "sign_up_final_stage": (context) => Scaffold(
          backgroundColor: white,
          body: const CommonBackground(child: SignUpFinalStage())),
      "sign_up_first_stage": (context) => Scaffold(
          backgroundColor: white,
          body: const CommonBackground(child: SignUpFirstStage())),
      "sign_up": (context) => Scaffold(
          backgroundColor: white,
          body: const CommonBackground(child: SignUp())),
      "gallery": (context) => Scaffold(
            backgroundColor: Colors.black,
            body: CommonBackground(
              child: galleryView(),
            ),
          ),
      "onboard_first_stage": (context) => Scaffold(
          backgroundColor: Colors.black,
          body: const CommonBackground(
            child: OnboardFirstStage(
              routeName: 'onboard_second_stage',
              display:
                  'Join our community and experience the power of cooking together. Download now to connect with loved ones through shared meals and fulfill each other\'s needs for nourishment and companionship.',
            ),
          )),
      "onboard_second_stage": (context) => Scaffold(
          backgroundColor: Colors.black,
          body: const CommonBackground(
            child: OnboardFirstStage(
              routeName: 'onboard_final_stage',
              title: 'Your ultimate kitchen companion',
              url:
                  'https://images.pexels.com/photos/2888104/pexels-photo-2888104.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
              display:
                  'Embark on a culinary adventure with our app! Whether you\'re a beginner or a seasoned cook, there\'s something for everyone. Start your cooking journey now!',
            ),
          )),
      "onboard_final_stage": (context) => Scaffold(
          backgroundColor: Colors.black,
          body: const CommonBackground(
            child: OnboardFirstStage(
              routeName: 'sign_in',
              url:
                  'https://images.pexels.com/photos/4994136/pexels-photo-4994136.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
              title: 'Learn with cool dishes',
              display:
                  'impress your friends and family with mouthwatering dishes? Get started by downloading our app and discover endless cooking possibilities!',
            ),
          )),
      "home": (context) {
        return Scaffold(
          backgroundColor: white,
          extendBodyBehindAppBar: true,
          appBar: const HomeHeader(),
          body: const CommonBackground(child: Homepage()),
        );
      },
      "searcher": (context) => Scaffold(
            backgroundColor: white,
            extendBodyBehindAppBar: true,
            appBar: const SearchHeader(),
            body: CommonBackground(child: HomeSearch()),
          ),
      "searcher_results": (context) => Scaffold(
            backgroundColor: white,
            extendBodyBehindAppBar: true,
            appBar: SearchHeader(),
            body: CommonBackground(child: SearchResults()),
          ),
      "library": (context) => Scaffold(
          backgroundColor: white,
          extendBodyBehindAppBar: true,
          appBar: const Header(),
          body: const CommonBackground(child: Library())),
      "recent_history": (context) => Scaffold(
          backgroundColor: white,
          extendBodyBehindAppBar: true,
          appBar: const Header(),
          body: const CommonBackground(child: RecentHistory())),
      "product_matches": (context) => Scaffold(
          backgroundColor: white,
          extendBodyBehindAppBar: true,
          appBar: const SearchHeader(),
          body: const CommonBackground(child: ProductMatches())),
      "content_review": (context) => Scaffold(
          backgroundColor: white,
          extendBodyBehindAppBar: true,
          appBar: const ContentReviewHeader(),
          body: const CommonBackground(child: ContentReview())),
      "profile": (context) => Scaffold(
          backgroundColor: white,
          extendBodyBehindAppBar: true,
          appBar: const SearchHeader(),
          body: const CommonBackground(child: Profile())),
      "sign_in": (context) => Scaffold(
          backgroundColor: white,
          extendBodyBehindAppBar: true,
          appBar: const Header(),
          body: const CommonBackground(child: SignIn())),
      "sign_in_password": (context) => Scaffold(
          backgroundColor: white,
          extendBodyBehindAppBar: true,
          appBar: const Header(),
          body: const CommonBackground(child: SignInPassword())),
    };
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorGrandKey,
      initialRoute: "onboard_first_stage",
      // initialRoute: "home",
      navigatorObservers: [MyRouteObserver()],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      builder: (context, child) {
        return FutureBuilder(
          future: Future.wait([
            precacheImage(
                const NetworkImage(
                    "https://images.pexels.com/photos/9750949/pexels-photo-9750949.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                context),
            precacheImage(
                const NetworkImage(
                    "https://images.pexels.com/photos/2888104/pexels-photo-2888104.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                context),
            precacheImage(
                const NetworkImage(
                    "https://images.pexels.com/photos/4994136/pexels-photo-4994136.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                context)
          ]),
          builder: (context, c) => Stack(
            fit: StackFit.passthrough,
            children: [
              Scaffold(
                body: child!,
                bottomNavigationBar: const Footer(),
              ),
              IgnorePointer(
                child: Image(
                  image: const AssetImage(
                      "assets/backgrounds/Rectangle 828079.png"),
                  fit: BoxFit.fill,
                  color: white.withOpacity(0.0125 * 0.25),
                  colorBlendMode: BlendMode.modulate,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const SignIn()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(color: Colors.black);
  }
}
