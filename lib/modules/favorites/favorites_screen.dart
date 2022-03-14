import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/component/component.dart';
import 'package:shop_app/shop_cubit/cubit.dart';
import 'package:shop_app/shop_cubit/states.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context , state){},
      builder: (context , state){
        return state is! ShopLoadingGetFavoritesState? ListView.separated(
          itemBuilder: (context , index)=> buildListProduct(ShopCubit.get(context).favoritesModel!.data.data[index].product, context),
          separatorBuilder: (context , index)=> myDivider(),
          itemCount: ShopCubit.get(context).favoritesModel!.data.data.length,
        ) : Center(child: CircularProgressIndicator());
      },
    ) ;
  }

}
