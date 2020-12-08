part of 'my_orders_cubit.dart';

class MyTicketsState {
  CustomerOrder customerOrders;
  NetworkState state;
  String message;

  MyTicketsState({this.customerOrders, this.state, this.message});

  MyTicketsState copyWith(
      {CustomerOrder customerOrders, String message, NetworkState state}) {
    return MyTicketsState(
        customerOrders: customerOrders ?? this.customerOrders,
        state: state ?? this.state,
        message: message ?? this.message);
  }
}
