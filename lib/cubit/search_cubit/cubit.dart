import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/constant/constant.dart';
import 'package:shop_app/cubit/search_cubit/states.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/networt/end_points.dart';
import 'package:shop_app/networt/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{

  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel model;

  void search(String text){
    emit(SearchLoadingState());
    DioHelper.postData(
        url: SEARCH,
        token: token,
        data: {
      'text' : text,
    }).then((value){
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}