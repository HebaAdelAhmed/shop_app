import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../layout/shop_layout.dart';
import '../login/cubit/states.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopRegistrationScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  TextEditingController emailController    = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController     = TextEditingController();
  TextEditingController phoneController    = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegistrationCubit(),
      child: BlocConsumer<ShopRegistrationCubit , ShopRegistrationStates>(
        listener: (context, state) {
          if(state is ShopRegistrationSuccessState){
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
          ShopRegistrationCubit cubit = ShopRegistrationCubit.get(context);
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
                          'Registration',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultTextFormField(
                          keyboardType: TextInputType.text,
                          validation: (value){
                            if(value!.isEmpty){
                              return 'please enter your name';
                            }
                          },
                          prefixIcon: Icons.person,
                          fieldName: 'Username',
                          controller: nameController,
                        ),
                        SizedBox(
                          height: 15,
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
                          keyboardType: TextInputType.number,
                          validation: (value){
                            if(value!.isEmpty){
                              return 'please enter your phone number';
                            }
                          },
                          prefixIcon: Icons.call,
                          fieldName: 'Phone Number',
                          controller: phoneController,
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
                                cubit.userRegister(
                                    phone: phoneController.text,
                                    name: nameController.text,
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
                                  cubit.userRegister(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text,
                                      password: passwordController.text
                                  );
                                }
                              }
                          ),
                          fallback: (context)=> Center(child: CircularProgressIndicator()),
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
