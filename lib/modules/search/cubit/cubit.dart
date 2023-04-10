import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/search_model.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/network/remote/end_points.dart';
import 'states.dart';


class ShopSearchCubit extends Cubit<ShopSearchStates>{
  ShopSearchCubit() : super(ShopSearchInitialState());

  static ShopSearchCubit get(BuildContext context) => BlocProvider.of(context);

  SearchModel ? searchModel;

  void search({
    required String text,
}){
    emit(ShopSearchLoadingState());
    DioHelper.postData(
      url: PRODUCTS_SEARCH,
      token: token,
      data: {
        'text' : text,
      }
    ).then((value){

      searchModel = SearchModel.fromJson(value.data);
      emit(ShopSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopSearchErrorState());
    });
  }
}