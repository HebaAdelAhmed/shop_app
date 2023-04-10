import '../../models/login_model.dart';

abstract class ShopStates {}

class ShopInitiateState extends ShopStates {}

class ShopChangeBottomNavigationBarState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {
  final String error;
  ShopErrorHomeDataState({required this.error});
}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {
  final String error;
  ShopErrorCategoriesState({required this.error});
}

class ShopSuccessChangeFavoriteState extends ShopStates {}

class ShopSuccessFavoriteState extends ShopStates {}

class ShopErrorChangeFavoriteState extends ShopStates {
  final String error;
  ShopErrorChangeFavoriteState({required this.error});
}

class ShopSuccessGetFavoriteState extends ShopStates {}

class ShopErrorGetFavoriteState extends ShopStates {}

class ShopLoadingGetUserDataState extends ShopStates {}

class ShopSuccessGetUserDataState extends ShopStates {
  final ShopLoginModel userModel;

  ShopSuccessGetUserDataState(this.userModel);
}

class ShopErrorGetUserDataState extends ShopStates {}

class ShopLoadingUpdateUserDataState extends ShopStates {}

class ShopSuccessUpdateUserDataState extends ShopStates {
  final ShopLoginModel userModel;

  ShopSuccessUpdateUserDataState(this.userModel);
}

class ShopErrorUpdateUserDataState extends ShopStates {}