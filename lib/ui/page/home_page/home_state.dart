part of 'home_cubit.dart';

class HomeState {
  bool logout = false;
  bool aboutApp = false;
  List<Product> newProducts;
  // List<Tournament> upcomingTournaments;
  GetCategory getCategories;
  NetworkState networkState;
  String message;

  HomeState(
      {this.logout,
        this.newProducts,
     // this.upcomingTournaments,
      this.networkState = NetworkState.INITIAL,
      this.message,
      this.getCategories});

  HomeState copyWith(
      {bool logout,
      //   List<Tournament> upcomingTournaments,
      List<Product> newProducts,
      NetworkState networkState,
      GetCategory getCategories,

      String message}) {
    return HomeState(
        getCategories: getCategories ?? this.getCategories,
        newProducts: newProducts ?? this.newProducts,
        // upcomingTournaments: upcomingTournaments ?? this.upcomingTournaments,
        networkState: networkState ?? this.networkState,
        message: message ?? this.message,
        logout: logout ?? this.logout);
  }
}
