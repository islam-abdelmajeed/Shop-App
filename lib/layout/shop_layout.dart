import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/component/component.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shop_cubit/cubit.dart';
import 'package:shop_app/shop_cubit/states.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopCubit()..getHomeDate()..getCategories()..getFavorites()..getUserData(),
      child: BlocConsumer<ShopCubit , ShopStates>(
          builder: (context, state){
        var cubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Salla'),
            /*actions: [
              IconButton(icon: Icon(Icons.search), onPressed: (){
                navigateTo(context, SearchScreen());
              }),
            ],*/
          ),
          body: cubit.bottomScreens[cubit.currentIndex ] ,
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),
              label: 'Home',),
              BottomNavigationBarItem(icon: Icon(Icons.apps),
              label: 'Categories',),
              BottomNavigationBarItem(icon: Icon(Icons.favorite),
              label: 'Favorites',),
              BottomNavigationBarItem(icon: Icon(Icons.settings),
              label: 'Settings',),
            ],
          ),
        );
      }, listener: (context , state){}),
    );
  }
}
