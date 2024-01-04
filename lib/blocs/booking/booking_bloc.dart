import 'dart:async';
import 'package:carnova_user/blocs/booking/booking_event.dart';
import 'package:carnova_user/blocs/booking/booking_state.dart';
import 'package:carnova_user/data/get_it/get_it.dart';
import 'package:carnova_user/modals/booked_vehicle.dart';
import 'package:carnova_user/repositories/booking_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(PaymentInitial()) {
    on<PaymentInitialEvent>(paymentinitialEvent);
    on<PaymentSuccessEvent>(paymentSuccessEvent);
    on<UpdateBookedVehiclesList>(updateBookedVehiclesList);
    on<CancelBooking>(cancelBooking);
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
      'name': 'Carnova .pvt',
      'description': 'Rental Car Solution',
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

  FutureOr<void> updateBookedVehiclesList(
      UpdateBookedVehiclesList event, Emitter<BookingState> emit) async {
    final userBooking = await BookingRepo().userBookings();
    userBooking.fold((left) {
      replaceBookedList([]);
      replaceBookedHistory([]);
      replaceActive([]);
    }, (right) {
      DateTime currentDate = DateTime.now();
      DateFormat('yyyy-MM-dd').format(currentDate);
      final List vehicleList = right as List;
      final datas = vehicleList.map((e) => BookedVehicle.fromJson(e)).toList();
      replaceBookedHistory(datas);
      //////////////////// DIVIED BOOKED AND NOT BOOKED////////////////////////////////
      final bookedonly =
          datas.where((element) => element.status == "Booked").toList();
      replaceBookedList(bookedonly);
      ////////////////// ACTIVE VEHICLE SORTING/////////////////////////////////
      final data2 = datas.where((element) {
        final startDate = DateTime.parse(element.startDate);
        final endDate = DateTime.parse(element.endDate);
        return startDate.isBefore(currentDate) && endDate.isAfter(currentDate);
      }).toList();
      replaceActive(data2);
      emit(FetchedVehicleData());
    });
  }

  FutureOr<void> cancelBooking(
      CancelBooking event, Emitter<BookingState> emit) async {
    emit(BookingLoadingState());
    final data = {
      "reason": event.reason,
      "amount": event.ammount,
      "userId": event.userId
    };
    final response = await BookingRepo().cancelBooking(event.bookId, data);

    response.fold((left) {
      emit(CancelFailedState(message: left.message));
    }, (right) {
      emit(CancelSuccsessState());
    });
  }
}
