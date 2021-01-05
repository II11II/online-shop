part of 'product_cubit.dart';

class ProductState  {
  Payment payment;
  bool isLiked;
  NetworkState networkState;
  String message;
  Product tournament;
  final List<String> nameTournament = ["per_kill", "top_10", "winner_gets"];
  bool isInstructionExpanded;
  bool isDescriptionExpanded;

  ProductState(this.tournament,

      {this.payment = Payment.PAY_ME,
        this.networkState=NetworkState.INITIAL,
      this.isLiked = false,
        this.message,
      this.isDescriptionExpanded = false,
      this.isInstructionExpanded = false});

  ProductState copyWith({
    Product tournament,
    Payment payment,
    String message,
    NetworkState networkState,
    bool isLiked,
    bool isInstructionExpanded,
    bool isDescriptionExpanded,
  }) {
    return ProductState(tournament ?? this.tournament,
        isLiked: isLiked??this.isLiked,
        message: message??this.message,
        networkState: networkState??this.networkState,
        isDescriptionExpanded:
            isDescriptionExpanded ?? this.isDescriptionExpanded,
        isInstructionExpanded:
            isInstructionExpanded ?? this.isInstructionExpanded,
        payment: payment ?? this.payment);
  }
}

enum Payment { PAY_ME, CLICK }
