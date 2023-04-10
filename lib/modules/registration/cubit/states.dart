
import '../../../models/login_model.dart';

abstract class ShopRegistrationStates {}

class ShopRegistrationInitialState extends ShopRegistrationStates {}

class ShopRegistrationLoadingState extends ShopRegistrationStates {}

class ShopRegistrationSuccessState extends ShopRegistrationStates {
  final ShopLoginModel shopLoginModel;

  ShopRegistrationSuccessState({required this.shopLoginModel});
}

class ShopRegistrationErrorState extends ShopRegistrationStates {
  final String error;
  ShopRegistrationErrorState({required this.error});
}

class ShopRegistrationChangePasswordVisibility extends ShopRegistrationStates {}
