import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/status.dart';
import '../../models/favorite_model.dart';
import '../../shared/styles/colors.dart';


class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShopCubit cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: cubit.favoriteModel != null,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildFavoriteItem(cubit.favoriteModel!.data!.data[index] , context),
            separatorBuilder: (context, index) =>
                SizedBox(
                  height: 4,
                ),
            itemCount: cubit.favoriteModel!.data!.data.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildFavoriteItem(FavoritesData model , BuildContext context) {
    ShopCubit cubit = ShopCubit.get(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                    model.product!.image.toString()
                  ),
                  width: 120,
                  height: 180,
                ),
                if(model.product!.discount != 0)
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
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.product!.name.toString(),
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
                        model.product!.price.toString(),
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if(model.product!.discount != 0)
                        Text(
                          model.product!.oldPrice.toString(),
                          style: const TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          cubit.changeFavorites(model.product!.id!);
                        },
                        icon: CircleAvatar(
                          backgroundColor: Colors.grey ,
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
      ),
    );
  }
}