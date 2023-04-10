import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/status.dart';
import '../../shared/styles/colors.dart';


class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.homeModel != null && cubit.categoryModel != null,
            builder: (context) => productsBuilder(
                cubit.homeModel!.data!.banners ,
                cubit.homeModel!.data!.products ,
                cubit.categoryModel!.data!.data,
                context
            ),
            fallback: (context) => const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  Widget productsBuilder(
      List<Map<String , dynamic>> banner ,
      List<Map<String , dynamic>> product ,
      List<Map<String , dynamic>> category,
      BuildContext context
      ){
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: banner.map((e) => Image(
              image: NetworkImage(e['image'].toString()),
                fit: BoxFit.cover,
              width: double.infinity,
            )).toList(),
            options: CarouselOptions(
              height: 200.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1.0,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 100.0,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: category.length,
                    itemBuilder: (context , index) => buildCategoryItem(category , index),
                    separatorBuilder: (context , index) => const SizedBox(
                      width: 10,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.7,
              children: List.generate(product.length ,
                      (index)=> buildGridProduct(product , index , context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryItem(List<Map<String , dynamic>> category , int index) => Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage(category[index]['image']),
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(0.8),
        width: 100.0,
        child: Text(
          category[index]['name'],
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );

  Widget buildGridProduct(List<Map<String , dynamic>> product , int index , BuildContext context){

    int id = product[index]['id'];
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(product[index]['image']),
                width: double.infinity,
                height: 180,
              ),
              if(product[index]['discount'] != 0)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.white,
                    backgroundColor: Colors.red,
                  ),
              ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product[index]['name'].toString(),
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.4
                    ),
                    maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      product[index]['price'].toString(),
                      style: const TextStyle(
                          fontSize: 12.0,
                        color: defaultColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if(product[index]['discount'] != 0)
                      Text(
                      product[index]['old_price'].toString(),
                      style: const TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: (){
                        ShopCubit.get(context).changeFavorites(product[index]['id']);
                        // print(product[index]['id']);
                        print('FAAAAAVVVVVVVVVVV###### :${ShopCubit.get(context).favorite.toString()}');
                        print('FAAAAAVVVVVVVVVVV :${ShopCubit.get(context).favorite[product[index]['id']].toString()}');
                      },
                      icon: CircleAvatar(
                        backgroundColor: ShopCubit.get(context).favorite[product[index]['id']]! ? defaultColor : Colors.grey ,
                        radius: 26,
                          child: const Icon(
                              Icons.favorite_border,
                            color: Colors.white,
                          ),
                      ),
                      iconSize: 24,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
