import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/status.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context , index) => buildCatItem(cubit.categoryModel!.data!.data , index),
            separatorBuilder: (context , index) => SizedBox(height: 10,),
            itemCount: cubit.categoryModel!.data!.data.length,
          ),
        );
      },
    );
  }

  Widget buildCatItem(List<Map<String , dynamic>> model , int index){
    return  Row(
      children: [
        Image(
          image: NetworkImage(model[index]['image']),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 15,
        ),
        Text(
          model[index]['name'],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Icon(
          Icons.arrow_forward_ios,
        ),
      ],
    );
  }
}