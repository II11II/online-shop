part of 'category_cubit.dart';
class CategoryState {
  bool logout = false;
  bool aboutApp = false;
  List<Product> newProducts;


  NetworkState networkState;
  String message;

  CategoryState(
      {this.logout,
        this.newProducts,

        this.networkState = NetworkState.INITIAL,
        this.message,
        });

  CategoryState copyWith(
      {bool logout,

        List<Product> newProducts,
        NetworkState networkState,


        String message}) {
    return CategoryState(

        newProducts: newProducts ?? this.newProducts,

        networkState: networkState ?? this.networkState,
        message: message ?? this.message,
        logout: logout ?? this.logout);
  }
}
