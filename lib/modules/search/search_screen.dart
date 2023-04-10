import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/styles/colors.dart';
import '../../models/favorite_model.dart';
import '../../shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var formKey = GlobalKey<FormState>();
    TextEditingController searchController = TextEditingController();

    return BlocProvider(
      create: (context) => ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit , ShopSearchStates>(
        listener: (context, state) {

        },
        builder: (context , state){

          ShopSearchCubit cubit = ShopSearchCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultTextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      validation: (value){
                        if(value!.isEmpty){
                          return 'Enter text to search';
                        }
                        return null;
                      },
                      fieldName: 'Search',
                      prefixIcon: Icons.search,
                      onSubmit: (value){
                        cubit.search(text: value);
                      },
                      onChange: (value){
                        cubit.search(text: value);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if(state is ShopSearchLoadingState)
                      LinearProgressIndicator(),
                    if(state is ShopSearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),



                        itemBuilder: (context, index) => buildProductItem(cubit.searchModel!.data!.data[index] as Product, context),
                        separatorBuilder: (context, index) =>
                            SizedBox(
                              height: 4,
                            ),
                        itemCount: cubit.searchModel!.data!.data.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildProductItem(Product model , BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                  model.image.toString()
              ),
              width: 120,
              height: 180,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name.toString(),
                    style: const TextStyle(
                        fontSize: 14.0,
                        height: 1.4
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}