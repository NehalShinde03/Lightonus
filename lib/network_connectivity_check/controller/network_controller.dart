import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../snackbars/snackbars.dart';


class NetworkController extends GetxController{

  final snackbar = SnackBarss();

  //0=no internet , 1=connected to wifi , 2=connected to internet
  var connectionStatus=0;

  //instance of connectivity
  final Connectivity _connectivity = Connectivity();

  //stream to keep listening to n/w change state
  late StreamSubscription internetStream;

  void onInit(){
    GetConnectionType();
    internetStream = _connectivity.onConnectivityChanged.listen(_updateState);
  }

  GetConnectionType() async{
    var connectionResult;
    try{
      connectionResult = await(_connectivity.checkConnectivity());
    }on PlatformException catch(e){
      print(e);
    }
    return _updateState(connectionResult);
  }

  _updateState(ConnectivityResult result){
    switch(result){

      case ConnectivityResult.wifi:
        connectionStatus=1;
        update();
        break;

      case ConnectivityResult.mobile:
        connectionStatus=2;
        update();
        break;

      case ConnectivityResult.none:
        connectionStatus=0;
        update();
        break;

      default: snackbar.snackBar('Network Error', 'Failed to get Network Status',1);
      break;
    }
  }

  @override
  void onClose(){
    internetStream.cancel();
  }
}