import 'package:car_qr/Models/car.dart';
import 'package:car_qr/Models/historyModel.dart';
import 'package:car_qr/Providers/auth.dart';
import 'package:car_qr/Providers/available_cars_model.dart';
import 'package:car_qr/Providers/history_provider.dart';
import 'package:car_qr/Screens/myappbar.dart';
import 'package:flutter/material.dart';
import 'package:car_qr/Screens/car_description.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:car_qr/Screens/admin_cars_screen.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:car_qr/Screens/wrapper.dart';
import 'package:car_qr/Models/user.dart';
import 'package:car_qr/Screens/admin_showrooms.dart';
import 'package:car_qr/Models/showrooms.dart';
import 'Models/showrooms.dart';
import 'Screens/ad_sh_carlist.dart';
import 'Screens/admin_showrooms.dart';
import 'Screens/carlist.dart';
import 'Screens/carshowroomadmin.dart';
import 'Screens/manage_showroom.dart';
import 'Screens/history.dart';
import 'Widgets/app_drawer.dart';

void main() {
  runApp(MyApp2());
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

class testApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AvailableCarsModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cars',
        theme: ThemeData.light(),
        home: AdminCarsPanal(),
      ),
    );
  }
}

class Nav extends StatelessWidget {
  final User user;
  Nav({@required this.user});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CarShowrooms>(
          create: (_) => CarShowrooms(user: user),
        ),
        ChangeNotifierProvider<AvailableCarsModel>(
          create: (_) => AvailableCarsModel(),
        ),
        ChangeNotifierProvider<HistoryProvider>(
          create: (_) => HistoryProvider(),
        ),
      ],
      child: MaterialApp(
        routes: {
          '/': (ctx) => MyApp(
                user: user,
              ),
          Carshowroomadmin.routeName: (ctx) => Carshowroomadmin(),
          AdminShowroomsScreen.routeName: (ctx) => AdminShowroomsScreen(),
          ManageShowroom.routeName: (ctx) => ManageShowroom(),
          Carlist.routeName: (ctx) => Carlist(),
          AdShCarList.routeName: (ctx) => AdShCarList(),
          History.routeName: (ctx) => History(user: user,),
          // '/history': (context) => History(),
          // '/showrooms': (context) => Carshowroom(),
          // '/settings': (context) => Settings(
          //       user: user,
          //     ),
          // '/about': (context) => About(),
        },
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  final User user;

  MyApp({@required this.user});
  @override
  _MyAppstate createState() => _MyAppstate(user: user);
}

class _MyAppstate extends State<MyApp> with TickerProviderStateMixin {
  String _scanBarcode = 'Unknown';
  AnimationController controller;
  Animation<double> animation;
  var _isLoading = true;
  final User user;
  Car hCar;

  _MyAppstate({@required this.user});

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      user.readUser().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    controller = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
  }

  startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            "#ff6666", "Cancel", true, ScanMode.BARCODE)
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanned;
    try {
      barcodeScanned = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancel", true, ScanMode.QR);
      print(barcodeScanned);
      hCar=new Car.emptyConst(id: barcodeScanned);
      await Provider.of<HistoryProvider>(context, listen: false).carScannedHistory(hCar, user.fireID);
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CarDetails(
            carId: barcodeScanned,
            loggedUser: user,
          ),
        ),
      );
    } on PlatformException {
      barcodeScanned = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanned;
    });
  }

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        titlex: new Text(
          'Car Showroom',
          style: TextStyle(fontSize: 22.0),
        ),
        history: () => Navigator.pushNamed(context, '/history'),
        showrooms: () => Navigator.pushNamed(context, '/showrooms'),
        settings: () => Navigator.pushNamed(context, '/settings'),
        about: () => Navigator.pushNamed(context, '/about'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: FadeTransition(
                    opacity: animation,
                    child: Text(
                      "All Your Car Details In Just A Scan",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(color: Colors.blue),
                        fontSize: 45,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: FadeTransition(
                    opacity: animation,
                    child: Image(
                      image: AssetImage('assets/images/homelogo.png'),
                      height: 250.0,
                      width: 300.0,
                    ),
                  ),
                ),
                Center(
                  child: FadeTransition(
                    opacity: animation,
                    child: RaisedButton(
                      padding: EdgeInsets.all(15),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () {
                        scanQR();
                      },
                      child: Text(
                        'Start Scanning',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(color: Colors.white),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
      drawer: AppDrawer(user: user),
    );
  }
}
