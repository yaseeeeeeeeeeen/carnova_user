

sealed class BookingState {}

final class PaymentInitial extends BookingState {}

final class PaymentSuccessState extends BookingState {}

final class PaymentErrorState extends BookingState {
  final String message;

  PaymentErrorState({required this.message});
}

final class PaymentFailedState extends BookingState {}

// Payment Refund

final class PaymentRefundLoadingState extends BookingState {}

final class PaymentRefundSuccessState extends BookingState {}

final class PaymentRefundErrorState extends BookingState {
  final String message;

  PaymentRefundErrorState({required this.message});
}

final class PaymentRefundFailedState extends BookingState {}