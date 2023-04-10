import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/shop_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../registration/shop_registration_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class ShopLoginScreen extends StatelessWidget {

  TextEditingController emailController    = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit , ShopLoginStates>(
        listener: (context, state) {
          if(state is ShopLoginSuccessState){
            if(state.shopLoginModel.status){
              print(state.shopLoginModel.data!.token);
              print(state.shopLoginModel.message);
              CacheHelper.saveData(key: 'token' , value: state.shopLoginModel.data!.token).then((value){
                token = state.shopLoginModel.data!.token;
                navigateAndFinish(context: context , widget: ShopLayout());
              });
              showToast(
                text: state.shopLoginModel.message.toString(),
                toastStates: ToastStates.SUCCESS
              );
            }else{
              // print(state.shopLoginModel.message);
              showToast(
                text: state.shopLoginModel.message.toString(),
                toastStates: ToastStates.ERROR
              );
            }
          }
        },
        builder: (context , state){
          ShopLoginCubit cubit = ShopLoginCubit.get(context);
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultTextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validation: (value){
                            if(value!.isEmpty){
                              return 'please enter your email address';
                            }
                          },
                          prefixIcon: Icons.email_outlined,
                          fieldName: 'Email Address',
                          controller: emailController,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            validation: (value){
                              if(value!.isEmpty){
                                return 'please enter your password';
                              }
                            },
                            onSubmit: (value){
                              if(formKey.currentState!.validate()){
                                cubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text
                                );
                              }
                            },
                            prefixIcon: Icons.lock_outline,
                            fieldName: 'Password',
                            controller: passwordController,
                            obscureText: cubit.isPassword,
                            suffixIcon: cubit.suffix,
                            onPressedSuffixIcon: (){
                              cubit.changePasswordVisibility();
                            }
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                              text: 'LOGIN' ,
                              function: (){
                                if(formKey.currentState!.validate()){
                                  cubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text
                                  );
                                }
                              }
                          ),
                          fallback: (context)=> Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                'Don\'t have an account?'
                            ),
                            defaultTextButton(
                                text: 'Register now',
                                function: (){
                                  navigateTo(
                                      context: context ,
                                      widget: ShopRegistrationScreen()
                                  );
                                }
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
