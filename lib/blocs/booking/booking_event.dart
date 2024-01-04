abstract class BookingEvent {}

final class PaymentInitialEvent extends BookingEvent {
  final int total;
  final String userId;
  final String vehicleId;
  final String pickup;
  final String dropoff;
  final String startDate;
  final String endDate;
  final int grandTotal;

  PaymentInitialEvent(
      {required this.total,
      required this.userId,
      required this.vehicleId,
      required this.pickup,
      required this.dropoff,
      required this.startDate,
      required this.endDate,
      required this.grandTotal});
}

final class CheckBoxClickedEvent extends BookingEvent {}

final class PaymentRefundEvent extends BookingEvent {
  final String paymentId;
  final double amount;
  final String reason;

  PaymentRefundEvent(
      {required this.paymentId, required this.amount, required this.reason});
}

final class PaymentStartEvent extends BookingEvent {}

final class PaymentSuccessEvent extends BookingEvent {}

final class PaymentFailedEvent extends BookingEvent {}

final class UpdateBookedVehiclesList extends BookingEvent {}

final class CancelBooking extends BookingEvent {
 final String bookId;
 final String userId;
 final String reason;
 final num ammount;

  CancelBooking({required this.bookId, required this.userId, required this.reason, required this.ammount});
}
