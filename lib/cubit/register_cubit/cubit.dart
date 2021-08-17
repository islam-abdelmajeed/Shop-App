import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/register_cubit/state.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/networt/end_points.dart';
import 'package:shop_app/networt/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates>{

  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) =>BlocProvider.of(context);

  LoginModel loginModel;

  void userRegister({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
}){

    emit(RegisterLoadingState());

    DioHelper.postData(url: REGISTER , data:{
      'name':name,
      'email':email,
      'password': password,
      'phone': phone,
    }).then((value){
      print(value.data);
      loginModel =LoginModel.fromJson(value.data);



      emit(RegisterSuccessState(loginModel));
    }).catchError((error){
      emit(RegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility(){
    isPassword = !isPassword;

    suffix = isPassword? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(RegisterChangePasswordVisibility());
  }

}