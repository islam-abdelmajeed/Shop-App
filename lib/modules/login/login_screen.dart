import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/component/component.dart';
import 'package:shop_app/components/constant/constant.dart';
import 'package:shop_app/cubit/login_cubit/cubit.dart';
import 'package:shop_app/cubit/login_cubit/state.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/register_screen/register_screen.dart';
import 'package:shop_app/networt/local/cache_helper.dart';

class LoginScreen extends StatelessWidget { // ignore: must_be_immutable


  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {



    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit , LoginStates>(
        listener: (context, state) {
          if(state is LoginSuccessState){
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
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'login'.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'login now to browser our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30.0,
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
                            if(formKey.currentState.validate()){

                              LoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          type: TextInputType.visiblePassword,
                          suffix: LoginCubit.get(context).suffix,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Password is too short';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outlined,
                          isPassword: LoginCubit.get(context).isPassword,
                          suffixPressed: LoginCubit.get(context).changePasswordVisibility,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (BuildContext context)=>defaultButton(
                            function: () {
                              if(formKey.currentState.validate()){

                                LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }

                            },
                            text: 'Login',
                            isUpperCase: true,
                          ),
                          fallback:(BuildContext context)=> Center(child: CircularProgressIndicator()) ,

                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            defaultTextButton(
                              function: () {
                                navigateTo(context, RegisterScreen());
                              },
                              text: 'Register',
                            ),
                          ],
                        ),
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
