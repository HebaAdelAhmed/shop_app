
import '../../../models/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {
  final ShopLoginModel shopLoginModel;

  ShopLoginSuccessState({required this.shopLoginModel});
}

class ShopLoginErrorState extends ShopLoginStates {
  final String error;
  ShopLoginErrorState({required this.error});
}

class ShopChangePasswordVisibility extends ShopLoginStates {}
