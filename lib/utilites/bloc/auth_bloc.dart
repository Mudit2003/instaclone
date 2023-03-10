import 'package:bloc/bloc.dart';
import 'package:instaclone/services/auth/auth_provider.dart';
import 'package:instaclone/utilites/bloc/auth_event.dart';
import 'package:instaclone/utilites/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider)
      : super(
          const AuthStateUninitialized(
            isLoading: true,
          ),
        ) {
    on<AuthEventInitialize>(
      (event, emit) async {
        await provider.initialize();
        final user = provider.currentUser;
        if (user == null) {
          emit(
            const AuthStateLoggedOut(
              exception: null,
              isLoading: false,
            ),
          );
        } else if (!user.isEmailVerified) {
          provider.sendEmailVerification();
          emit(
            const AuthStateNeedsVerification(isLoading: false),
          );
        } else {
          emit(
            AuthStateLoggedIn(
              user: user,
              isLoading: false,
            ),
          );
        }
      },
    );

    on<AuthEventLogin>(
      (event, emit) async {
        emit(
          const AuthStateLoggedOut(
            exception: null,
            isLoading: true,
            loadingText: "Please wait while we log you in ..",
          ),
        );
        final email = event.email;
        final password = event.password;
        try {
          final user = await provider.logIn(
            email: email,
            password: password,
          );
          if (user.isEmailVerified) {
            emit(
              const AuthStateLoggedOut(
                exception: null,
                isLoading: false,
              ),
            );
            // this line of code is to make sure the login dialogue is removed
            emit(
              AuthStateLoggedIn(
                user: user,
                isLoading: false,
              ),
            );
          } else {
            emit(
              const AuthStateLoggedOut(
                exception: null,
                isLoading: false,
              ),
            );
            provider.sendEmailVerification();
            emit(
              const AuthStateNeedsVerification(
                isLoading: true,
              ),
            );
          }
        } on Exception catch (e) {
          emit(
            AuthStateLoggedOut(
              exception: e,
              isLoading: false,
            ),
          );
        }
      },
    );

    on<AuthEventToRegister>(
      (event, emit) {
        emit(
          const AuthStateRegistering(
            isLoading: false,
            exception: null,
          ),
        );
      },
    );

    on<AuthEventRegister>(
      (event, emit) async {
        emit(
          const AuthStateRegistering(
            isLoading: true,
            exception: null,
          ),
        );
        final email = event.email;
        final password = event.password;

        try {
          await provider.register(
            email: email,
            password: password,
          );
          // there should be an extra field of using username and creating a name and that actually is about creating a user with a particular user id and assigning certain data like name and email to him 
          await provider.sendEmailVerification();
          emit(
            const AuthStateNeedsVerification(
              isLoading: true,
            ),
          );
        } on Exception catch (e) {
          emit(
            AuthStateRegistering(
              isLoading: false,
              exception: e,
            ),
          );
        }
      },
    );
    on<AuthEventSendEmailVerification>(
      (event, emit) async {
        await provider.sendEmailVerification();
        // emit(
        //   const AuthStateNeedsVerification(
        //     isLoading: true,
        //   ),
        // ); // this emission becomes useless because we are already in that clause
        emit(state);
      },
    );

    on<AuthEventForgotPassword>(
      (event, emit) {
        emit(
          const AuthStateForgotPassword(
            exception: null,
            hasSentEmail: false,
            isLoading: false,
          ),
        );
        final email = event.email;
        if (email == null) {
          return;
        }

        emit(
          const AuthStateForgotPassword(
            exception: null,
            hasSentEmail: false,
            isLoading: true,
          ),
        );
        Exception? exception;
        bool didSendEmail = false;
        try {
          provider.sendPasswordResetEmail(
            toEmail: email,
          );
          didSendEmail = true;
          exception = null;
        } on Exception catch (e) {
          exception = e;
        }
        emit(
          AuthStateForgotPassword(
              exception: exception,
              hasSentEmail: didSendEmail,
              isLoading: false),
        );
      },
    );
  }
}
