import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modules/search/search_screen.dart';
import '../shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/status.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
      },
      builder: (context, state) {

        ShopCubit cubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: (){
                  navigateTo(
                    context: context,
                    widget: SearchScreen(),
                  );
                },
                icon: Icon(
                    Icons.search
                ),
              ),
            ],
            title: Text(
              'Salla',
            ),
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.blue,
            selectedItemColor: Colors.lightBlue,
            unselectedItemColor: Colors.blue,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                    Icons.home
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.apps,
                ),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                    Icons.favorite
                ),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: 'Settings',
              ),
            ],
            onTap: (index){
              cubit.changeBottomIndex(index);
            },
            currentIndex: cubit.currentIndex,
          ),

        );
      },
    );
  }
}
