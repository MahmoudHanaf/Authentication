
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/Shared/network/remote/dio_helper.dart';
import 'package:flutter_app/modules/shop_app/logIn/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Shared/network/end_points/end_points.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
  {
  ShopLoginCubit() : super(ShopLoginInitialStates());

  static ShopLoginCubit get(context)=> BlocProvider.of(context);

  void userLogin (
  {
    String? email,
     String? password,
  }
  ){
    emit(ShopLoginLoadingStates());
    DioHelper.postData(
       url: LOGIN,
        data: {
          'email':email,
          "password":password,
        },
    ).then((value){
      print(value.data);
      print("sedf");
      emit(ShopLoginSuccessStates());
    }).catchError((error){
      emit(ShopLoginErrorStates(error.toString()));
    });
  }


  IconData suffix = Icons.remove_red_eye_outlined;
  bool isPassword = true ;

  void changePasswordVisibility (){
    isPassword=!isPassword;
    suffix = isPassword ? Icons.remove_red_eye_outlined : Icons.visibility_off ;

    emit(ShopChangePasswordVisibilityStates());
  }

}

