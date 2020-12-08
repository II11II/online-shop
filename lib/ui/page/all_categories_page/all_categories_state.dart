part of 'all_categories_cubit.dart';


class AllCategoriesState {
  // List<Favourites> favouriteTournaments;
  NetworkState networkState;
  String message;

  AllCategoriesState(
      {
      //this.favouriteTournaments,
      this.networkState,
      this.message});

  AllCategoriesState copyWith(
      {
      // List<Favourites> favouriteTournaments,
      NetworkState networkState,
      String message}) {
    return AllCategoriesState(
      message: message ?? this.message,
      networkState: networkState ?? this.networkState,
      // favouriteTournaments: favouriteTournaments ?? this.favouriteTournaments,
    );
  }
}
