import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:instaclone/models/auth/auth_exceptions.dart';
import 'package:instaclone/models/auth/auth_provider.dart';
import 'package:instaclone/models/cloud/cloud_user.dart';
import 'package:instaclone/models/cloud/firebase_cloud_storage.dart';
import 'package:instaclone/models/bloc/auth_bloc/auth_event.dart';
import 'package:instaclone/models/bloc/auth_bloc/auth_state.dart';

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
        } else if (user.profile == null) {
          emit(
              const AuthStateToCreateProfile(isLoading: true, exception: null));
        } else {
          final profile = await provider.profile;
          if (profile == null) {
            emit(const AuthStateToCreateProfile(
                isLoading: true, exception: null));
          }

          // final await an instance of cloud
          // await if user.id document can be found out in the collection user
          // if not then const AuthStateCreateProfile
          // emit(
          //   AuthStateLoggedIn(
          //     user: user,
          //     isLoading: false,
          //   ),
          // );
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
          if (!user.isEmailVerified) {
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
          } else if (user.profile == null) {
            emit(const AuthStateLoggedOut(
              exception: null,
              isLoading: false,
            )); // this step is there to remove the logging in dialog

            emit(const AuthStateToCreateProfile(
              isLoading: true,
              exception: null,
            ));
          } else {
            // this means that user profile was not null
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

    on<AuthEventRegister>((event, emit) async {
      emit(const AuthStateRegistering(
        isLoading: true,
        exception: null,
      ));
      final email = event.email;
      final password = event.password;
      try {
        await provider.register(
          email: email,
          password: password,
        );
        await provider.sendEmailVerification();
        emit(const AuthStateNeedsVerification(isLoading: true));
      } on Exception catch (e) {
        emit(AuthStateRegistering(
          isLoading: false,
          exception: e,
        ));
        log("Exception");
        log(e.toString());
      }
    });

    // on<AuthEventRegister>(
    //   (event, emit) async {
    //     // emit(
    //     //   const AuthStateRegistering(
    //     //     isLoading: true,
    //     //     exception: null,
    //     //   ),
    //     // );
    //     log("this is the bloc");
    //     // final email = event.email;
    //     // final password = event.password;

    //     // try {
    //     //   await provider.register(
    //     //     email: email,
    //     //     password: password,
    //     //   );
    //     //   // there should be an extra field of using username and creating a name and that actually is about creating a user with a particular user id and assigning certain data like name and email to him
    //     //   log('create a profile');
    //     //   emit(
    //     //     const AuthStateToCreateProfile(isLoading: true),
    //     //   );
    //     //   await provider.sendEmailVerification();

    //     // emit(
    //     //   const AuthStateNeedsVerification(
    //     //     isLoading: true,
    //     //   ),
    //     // );
    //     // } on Exception catch (e) {
    //     //   emit(
    //     //     AuthStateRegistering(
    //     //       isLoading: false,
    //     //       exception: e,
    //     //     ),
    //     //   );
    //     // }
    //   },
    // );
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
    on<AuthEventLogOut>(
      (event, emit) {
        Exception? exception;
        try {
          provider.logOut();
        } on Exception catch (e) {
          exception = e;
        }
        emit(AuthStateLoggedOut(
          exception: exception,
          isLoading: false,
        ));
      },
    );

    on<AuthEventCreateProfile>(
      (event, emit) {
        try {
          final cloud = FirebaseCloud();
          final user = provider.currentUser;
          if (user != null) {
            final userName = event.username;
            final name = event.name;
            final bio = event.bio;
            final followers = event.followers;
            final followings = event.following;
            cloud.createNewUserProfile(
                profile: UserProfile(
                  userName: userName,
                  name: name,
                  bio: bio,
                  followers: followers,
                  followings: followings,
                ),
                uId: user.id);

            emit(AuthStateLoggedIn(
              user: user,
              isLoading: false,
            ));
          } else {
            emit(AuthStateLoggedOut(
              exception: UserNotLoggedInAuthException(),
              isLoading: false,
            ));
          }
        } on Exception catch (e) {
          emit(AuthStateToCreateProfile(
            isLoading: true,
            exception: e,
          ));
        }
      },
    );
  }
}
