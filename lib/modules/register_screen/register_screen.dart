import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/component/component.dart';
import 'package:shop_app/components/constant/constant.dart';
import 'package:shop_app/cubit/register_cubit/cubit.dart';
import 'package:shop_app/cubit/register_cubit/state.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/networt/local/cache_helper.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit , RegisterStates>(
        listener: (context , state){
          if(state is RegisterSuccessState){
            if(state.loginModel.status){
              print(state.loginModel.message);
              print(state.loginModel.data.token);

              CacheHelper.saveData(
                  key: 'token',
                  value: state.loginModel.data.token
              ).then((value){
                token = state.loginModel.data.token;

                navigateAndFinish(context,ShopLayout());
              });
            }
            else{
              print(state.loginModel.message);

              showToast(text: state.loginModel.message,state: ToastStates.ERROR);
            }
          }
        },
        builder: (context , state){
          return Scaffold(
            appBar: AppBar(),
            body:Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register'.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Register now to browser our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.text,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter your name';
                            }
                          },
                          label: 'Name',
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter your email address';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          onSubmit: (value){
                          /*  if(formKey.currentState.validate()){

                              RegisterCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }*/
                          },
                          type: TextInputType.visiblePassword,
                          suffix: RegisterCubit.get(context).suffix,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Password is too short';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outlined,
                          isPassword: RegisterCubit.get(context).isPassword,
                          suffixPressed: RegisterCubit.get(context).changePasswordVisibility,
                        ),
                        SizedBox(height: 15.0,),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                          },
                          label: 'Phone Number',
                          prefix: Icons.phone,
                        ),

                        SizedBox(
                          height: 30.0,
                        ),

                        state is! RegisterLoadingState ? defaultButton(
                          function: () {
                            if(formKey.currentState!.validate()){

                              RegisterCubit.get(context).userRegister(
                                  name : nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone:phoneController.text
                              );
                            }

                          },
                          text: 'register',
                          isUpperCase: true,
                        ) : Center(child: CircularProgressIndicator())

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
