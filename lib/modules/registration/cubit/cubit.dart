import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../shared/network/remote/end_points.dart';
import '../../../models/login_model.dart';
import '../../../shared/network/remote/dio_helper.dart';
import 'states.dart';

class ShopRegistrationCubit extends Cubit<ShopRegistrationStates>{

  ShopRegistrationCubit() : super(ShopRegistrationInitialState());

  static ShopRegistrationCubit get(context) => BlocProvider.of(context);

  ShopLoginModel ? shopLoginModel;
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility(){

    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegistrationChangePasswordVisibility());
  }

  void userRegister({
    required String email ,
    required String password,
    required String name,
    required String phone,
  }){
    emit(ShopRegistrationLoadingState());
    DioHelper.postData(
        url: REGISTER ,
        data:
        {
          'name' : name,
          'phone': phone,
          'email' : email,
          'password' : password,
        }
    ).then((value) {
      print(value.data);
      shopLoginModel = ShopLoginModel.fromJson(value.data);
      print(shopLoginModel?.message);
      print(shopLoginModel?.status);
      print(shopLoginModel?.data?.token);
      emit(ShopRegistrationSuccessState(shopLoginModel: shopLoginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegistrationErrorState(error: error.toString()));
    });
  }
}