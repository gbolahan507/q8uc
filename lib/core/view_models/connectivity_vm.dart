import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:q8uc/core/view_models/base_vm.dart';
import 'package:q8uc/ui/constants/messages.dart';
import 'package:q8uc/ui/widgets/snackbar.dart';



class ConnectionViewModel extends BaseModel {
  startMonitoring(BuildContext context) async {
    await isconnectivity(context);
    connectivity.onConnectivityChanged.listen((result) async {
      if (result == ConnectivityResult.none) {
        isOnline = false;
        showSnackBar(context, 'Error', 'No internet connection');
        notifyListeners();
      } else {
        await _updateConnectionStus(context).then((isConnected) {
          isOnline = isConnected;
          notifyListeners();
        });
      }
    });
  }

  Future<void> isconnectivity(BuildContext context) async {
    try {
      var status = await connectivity.checkConnectivity();
      if (status == ConnectivityResult.none) {
        isOnline = false;
        showSnackBar(context, 'Error', 'No internet connection');

        notifyListeners();
      } else {
        isOnline = true;
        notifyListeners();
      }
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  Future<bool> _updateConnectionStus(BuildContext context) async {
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup(kBaseUrl);
      if (result.isNotEmpty && result[0].address.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      isConnected = false;
      notifyListeners();
    }
    return isConnected;
  }
}
