import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';




class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AdMob Learnistan'),
      ),
      body: Center(
        child: AdmobBanner(
          adUnitId: 'ca-app-pub-3940256099942544/6300978111',
          adSize: AdmobBannerSize.BANNER,
        ),
      ),
    );
  }
}
