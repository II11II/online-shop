part of 'favorite_cubit.dart';


class FavoriteState {
  List<Product> favoriteProducts;
  NetworkState state;
  String message;

  FavoriteState({this.favoriteProducts, this.state, this.message});

  FavoriteState copyWith(
      { List<Product>  favoriteProducts, String message, NetworkState state}) {
    return FavoriteState(
        favoriteProducts: favoriteProducts ?? this.favoriteProducts,
        state: state ?? this.state,
        message: message ?? this.message);
  }
}