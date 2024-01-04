sealed class BookingState {}

final class PaymentInitial extends BookingState {}

final class PaymentSuccessState extends BookingState {}

final class PaymentErrorState extends BookingState {
  final String message;

  PaymentErrorState({required this.message});
}

final class FetchedVehicleData extends BookingState{}

final class PaymentFailedState extends BookingState {}

/// cancel
final class BookingLoadingState extends BookingState {}

final class CancelSuccsessState extends BookingState {}

final class CancelFailedState extends BookingState {
 final String message;

  CancelFailedState({required this.message});
}
// Payment Refund

// final class PaymentRefundLoadingState extends BookingState {}

// final class PaymentRefundSuccessState extends BookingState {}

// final class PaymentRefundErrorState extends BookingState {
//   final String message;

//   PaymentRefundErrorState({required this.message});
//}


