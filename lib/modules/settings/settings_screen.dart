import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/status.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';


class SettingsScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  TextEditingController nameController  = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ShopCubit cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context, state) {
        // if(state is ShopSuccessGetUserDataState){
        //   nameController.text = state.userModel.data!.name!;
        //   emailController.text = state.userModel.data!.email!;
        //   phoneController.text = state.userModel.data!.phone!;
        // }
      },
      builder: (context , state) {
        nameController.text = cubit.userModel!.data!.name!;
        emailController.text = cubit.userModel!.data!.email!;
        phoneController.text = cubit.userModel!.data!.phone!;
        return ConditionalBuilder(
          condition: cubit.userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if(state is ShopLoadingUpdateUserDataState)
                      LinearProgressIndicator(),
                    defaultTextFormField(
                      controller: nameController,
                      fieldName: 'Name',
                      prefixIcon: Icons.person,
                      validation: (value){
                        if(value!.isEmpty){
                          return 'Name Must not be empty!';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultTextFormField(
                      controller: emailController,
                      fieldName: 'Email Address',
                      prefixIcon: Icons.email,
                      validation: (value){
                        if(value!.isEmpty){
                          return 'Email Address Must not be empty!';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultTextFormField(
                      controller: phoneController,
                      fieldName: 'Phone',
                      prefixIcon: Icons.phone,
                      validation: (value){
                        if(value!.isEmpty){
                          return 'Phone Must not be empty!';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                      text: 'UPDATE PROFILE',
                      function: (){
                        if(formKey.currentState!.validate()){
                          cubit.updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text);
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                      text: 'LOGOUT',
                      function: (){
                        signOut(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}