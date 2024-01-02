import 'dart:async';
import 'package:carnova_user/blocs/booking/booking_event.dart';
import 'package:carnova_user/blocs/booking/booking_state.dart';
import 'package:carnova_user/repositories/booking_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(PaymentInitial()) {
    on<PaymentInitialEvent>(paymentinitialEvent);
    on<PaymentSuccessEvent>(paymentSuccessEvent);
    // on<PaymentFailedEvent>(paymentFailedEvent);
    // on<PaymentRefundEvent>(paymentRefundEvent);
  }
  Map<String, dynamic> bookingData = {};

  final _razorpay = Razorpay();

  FutureOr<void> paymentinitialEvent(
      PaymentInitialEvent event, Emitter<BookingState> emit) {
    bookingData['userId'] = event.userId;
    bookingData['vehicleId'] = event.vehicleId;
    bookingData['pickup'] = event.pickup;
    bookingData['dropoff'] = event.dropoff;
    bookingData['startDate'] = event.startDate;
    bookingData['endDate'] = event.endDate;
    bookingData['total'] = event.total;
    bookingData['grandTotal'] = event.grandTotal;

    var options = {
      'key': 'rzp_test_CpkZtj1kfifRZ7',
      'amount': event.grandTotal * 100,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8848917803', 'email': 'test@razorpay.com'}
    };
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    _razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    bookingData['razorId'] = response.paymentId;
    add(PaymentSuccessEvent());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    add(PaymentFailedEvent());
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    
  }

  FutureOr<void> paymentSuccessEvent(
      PaymentSuccessEvent event, Emitter<BookingState> emit) async {
    final response = await BookingRepo().bookvehicle(bookingData);
    response.fold((error) {
      emit(PaymentErrorState(message: error.message));
    }, (response) {
      emit(PaymentSuccessState());
    });
  }
}
