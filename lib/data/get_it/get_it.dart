import 'package:carnova_user/blocs/login/login_bloc.dart';
import 'package:carnova_user/modals/user_modal.dart';
import 'package:get_it/get_it.dart';


final locator = GetIt.instance;

UserModal logedUser = locator<LoginBloc>().logedUser;

void setupLocator() {
  locator.registerLazySingleton(() => LoginBloc());
}
