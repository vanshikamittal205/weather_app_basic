import 'package:get/get.dart';

class GlobalController extends GetxController{
  //create various variables
  final RxBool _isLoading= true.obs;
  final RxDouble _latitude= 0.0.obs;
  final RxDouble _longitude= 0.0.obs;

  //instance for them to be called
  RxBool checkLoading() => _isLoading;
  RxDouble getLatitude() => _latitude;
  RxDouble getLongitude() => _longitude;

}
