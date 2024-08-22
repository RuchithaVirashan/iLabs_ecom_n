import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/order_model.dart';
import '../../../presentation/components/status/error.dart';
import '../../../presentation/components/status/sucess.dart';
import '../../bloc/cart/cart_bloc.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  List<OrderModel> orders = [];

  UserDataCubit() : super(UserDataInitial());

  void placeOrder(OrderModel orderData, BuildContext context) {
    try {
      orders.add(orderData);
      BlocProvider.of<CartBloc>(context).add(ClearCart(context: context));

      showSuccessDialog(
          context,
          'Successfully added order from ${orderData.customerName} at ${orderData.orderDate}',
          '/');
    } catch (e) {
      emit(UserDataError(message: e.toString()));
      showErrorDialog(context, e.toString());
    }
  }
}
