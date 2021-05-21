import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:glyphicon/glyphicon.dart';
import 'package:panda/Models/AuthState.dart';
import 'package:panda/Pages/IntroPages/StartPage.dart';
import 'package:panda/Pages/pages.dart';
import 'package:panda/Providers/DBProvider.dart';
import 'package:panda/widgets/Logo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Panda',
      theme: ThemeData(
        fontFamily: 'worksans',
        primaryColor: Color(0xffC2E7C8),
        cardColor: Color(0xffE4F6FA),
        floatingActionButtonTheme: FloatingActionButtonThemeData().copyWith(
            backgroundColor: Color(0xff02446C),
            splashColor: Color(0xffC2E7C8),
            hoverColor: Color(0xffC2E7C8)),
        buttonColor: Color(0xff131313),
        bottomNavigationBarTheme: BottomNavigationBarThemeData().copyWith(
            selectedItemColor: Color(0xffC2E7C8),
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Color(0xffffffff)),
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: InitialPage(),
    );
  }
}

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  bool isFirstStart = true;
  bool loading = true;
  AuthState authState;
  @override
  void initState() {
    super.initState();
    getAutState();
  }

  getAutState() async {
    if (await DBProvider.helper.databaseExists()) {
      authState = await DBProvider.helper.getAuthState();
    } else {
      DBProvider.helper.initialize();
      authState = null;
    }
    if (authState == null) {
      setState(() {
        isFirstStart = true;
        loading = false;
      });
      print("App started first time ");
    } else {
      setState(() {
        isFirstStart = false;
        loading = false;
      });
      print("Signed in with username: " + authState.username ?? "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : isFirstStart
            ? StartPage(
                onDone: () {
                  setState(() {
                    loading = false;
                    isFirstStart = false;
                  });
                },
              )
            : Navigation(
                authState: authState,
              );
  }
}

class Navigation extends StatefulWidget {
  final AuthState authState;
  const Navigation({Key key, this.authState}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  bool buttonsShown = false;
  List<Widget> _widgetOptions = [Home(), SettingsPage()];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Scaffold(
            body: Stack(children: [
              Column(mainAxisSize: MainAxisSize.max, children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300.0,
                  decoration: BoxDecoration(
                    color: Color(0xff02446C),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 140, child: Logo()),
                        Text(
                          "Welkom " + (widget.authState?.username ?? ""),
                          style: TextStyle(fontSize: 32.0, color: Colors.white),
                        ),
                        Text(
                          "Hieronder zie je jouw voortgang.",
                          style: TextStyle(fontSize: 18.0, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                _widgetOptions.elementAt(_selectedIndex)
              ]),
              if (buttonsShown)
                Positioned(
                  bottom: 30,
                  right: 0,
                  left: 0,
                  child: Center(
                    child: Container(
                      height: 40,
                      width: 200,
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton(
                            heroTag: "Actvityselection",
                            onPressed: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ActivitySelectionPage()),
                              )
                            },
                            child: Container(
                              width: 100.0,
                              height: 100.0,
                              child: Icon(
                                Glyphicon.lightning_charge,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          FloatingActionButton(
                            heroTag: "GoalCreate",
                            onPressed: () => {},
                            child: Icon(
                              Glyphicon.flag,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
            ]),
            floatingActionButton: FloatingActionButton(
              child: Icon(
                Glyphicon.plus,
                color: Color(0xffffffff),
              ),
              onPressed: () {
                setState(() {
                  buttonsShown = !buttonsShown;
                });
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              shape: CircularNotchedRectangle(),
              color: Color(0xff02446C),
              child: Container(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: _selectedIndex == 0
                          ? Colors.white24
                          : Colors.transparent,
                      child: IconButton(
                          onPressed: () {
                            _onItemTap(0);
                          },
                          icon: Icon(Glyphicon.house, color: Colors.white)),
                    ),
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: _selectedIndex == 1
                          ? Colors.white24
                          : Colors.transparent,
                      child: IconButton(
                          onPressed: () {
                            _onItemTap(1);
                          },
                          icon: Icon(Glyphicon.gear, color: Colors.white)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

// showSelectedLabels: true,
// showUnselectedLabels: false,
// backgroundColor: Color(0xff131313),
// elevation: 0.0,
// items: [
//   BottomNavigationBarItem(
//     icon: Icon(
//       Glyphicon.house,
//     ),
//     label: "Home",
//     backgroundColor: Theme.of(context).buttonColor,
//   ),
//   BottomNavigationBarItem(
//     icon: Icon(
//       Glyphicon.gear,
//     ),
//     label: "Settings",
//     backgroundColor: Theme.of(context).buttonColor,
//   ),
// ],
// currentIndex: _selectedIndex,
// onTap: _onItemTap,
