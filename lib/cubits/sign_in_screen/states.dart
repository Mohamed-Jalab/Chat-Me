abstract class SignInStates {}

class SignInInitialState extends SignInStates {}

class SignInLoadingState extends SignInStates {}

class SignInSuccessState extends SignInStates {}

class SignInErrorState extends SignInStates {
  final String error;
  SignInErrorState(this.error);
}
