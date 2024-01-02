// import 'dart:io';
// import 'package:bloc/bloc.dart';
// import 'package:dictionary_app_1110/services/authentication/auth_error.dart';
// import 'package:dictionary_app_1110/bloc/bloc_login/login_events.dart';
// import 'package:dictionary_app_1110/bloc/bloc_login/login_states.dart';
// import 'package:dictionary_app_1110/ultil/upload_files.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   LoginBloc()
//       : super(
//           const LoginStateLoggedOut(
//             isLoading: false,
//           ),
//         ) {
//     on<LoginEventGoToRegistration>((event, emit) {
//       emit(
//         const LoginStateIsInRegistrationView(/
//           isLoading: false,
//         ),
//       );
//     });
//     on<LoginEventLogIn>(
//       (event, emit) async {
//         emit(
//           const LoginStateLoggedOut(
//             isLoading: true,
//           ),
//         );
//         // log the user in
//         try {
//           final email = event.email;
//           final password = event.password;
//           final userCredential =
//               await FirebaseAuth.instance.signInWithEmailAndPassword(
//             email: email,
//             password: password,
//           );
//           // get images for user
//           final user = userCredential.user!;
//           final images = await _getImages(user.uid);

//           emit(
//             LoginStateLoggedIn(
//               isLoading: false,
//               user: user,
//               images: images,
//             ),
//           );
//         } on FirebaseAuthException catch (e) {
//           emit(
//             LoginStateLoggedOut(
//               isLoading: false,
//               authError: AuthError.from(e),
//             ),
//           );
//         }
//       },
//     );
//     on<LoginEventGoToLogin>(
//       (event, emit) {
//         emit(
//           const LoginStateLoggedOut(
//             isLoading: false,
//           ),
//         );
//       },
//     );
//     on<LoginEventRegister>(
//       (event, emit) async {
//         // start loading
//         emit(
//           const LoginStateIsInRegistrationView(
//             isLoading: true,
//           ),
//         );
//         final email = event.email;
//         final password = event.password;
//         try {
//           // create the user
//           final credentials =
//               await FirebaseAuth.instance.createUserWithEmailAndPassword(
//             email: email,
//             password: password,
//           );
//           emit(
//             LoginStateLoggedIn(
//               isLoading: false,
//               user: credentials.user!,
//               images: const [],
//             ),
//           );
//         } on FirebaseAuthException catch (e) {
//           emit(
//             LoginStateIsInRegistrationView(
//               isLoading: false,
//               authError: AuthError.from(e),
//             ),
//           );
//         }
//       },
//     );
//     on<LoginEventInitialize>(
//       (event, emit) async {
//         // get the current user
//         final user = FirebaseAuth.instance.currentUser;

//         if (user == null) {
//           emit(
//             const LoginStateLoggedOut(
//               isLoading: false,
//             ),
//           );
//         } else {
//           // go grab the user's uploaded images
//           final images = await _getImages(user.uid);

//           emit(
//             LoginStateLoggedIn(
//               isLoading: false,
//               user: user,
//               images: images,
//             ),
//           );
//         }
//       },
//     );
//     // log out event
//     on<LoginEventLogOut>(
//       (event, emit) async {
//         // start loading
//         emit(
//           const LoginStateLoggedOut(
//             isLoading: true,
//           ),
//         );
//         // log the user out
//         await FirebaseAuth.instance.signOut();
//         // log the user out in the UI as well
//         emit(
//           const LoginStateLoggedOut(
//             isLoading: false,
//           ),
//         );
//       },
//     );
//     // handle account deletion
//     on<LoginEventDeleteAccount>(
//       (event, emit) async {
//         final user = FirebaseAuth.instance.currentUser;
//         // log the user out if we don't have a current user
//         if (user == null) {
//           emit(
//             const LoginStateLoggedOut(
//               isLoading: false,
//             ),
//           );
//           return;
//         }
//         // start loading
//         emit(
//           LoginStateLoggedIn(
//             isLoading: true,
//             user: user,
//             images: state.images ?? [],
//           ),
//         );
//         // delete the user folder
//         try {
//           // delete user folder
//           final folderContents =
//               await FirebaseStorage.instance.ref(user.uid).listAll();
//           for (final item in folderContents.items) {
//             await item.delete().catchError((_) {}); // maybe handle the error?
//           }
//           // delete the folder itself
//           await FirebaseStorage.instance
//               .ref(user.uid)
//               .delete()
//               .catchError((_) {});

//           // delete the user
//           await user.delete();
//           // log the user out
//           await FirebaseAuth.instance.signOut();
//           // log the user out in the UI as well
//           emit(
//             const LoginStateLoggedOut(
//               isLoading: false,
//             ),
//           );
//         } on FirebaseAuthException catch (e) {
//           emit(
//             LoginStateLoggedIn(
//               isLoading: false,
//               user: user,
//               images: state.images ?? [],
//               authError: AuthError.from(e),
//             ),
//           );
//         } on FirebaseException {
//           // we might not be able to delete the folder
//           // log the user out
//           emit(
//             const LoginStateLoggedOut(
//               isLoading: false,
//             ),
//           );
//         }
//       },
//     );

//     // handle uploading images
//     on<LoginEventUploadImage>(
//       (event, emit) async {
//         final user = state.user;
//         // log user out if we don't have an actual user in app state
//         if (user == null) {
//           emit(
//             const LoginStateLoggedOut(
//               isLoading: false,
//             ),
//           );
//           return;
//         }
//         // start the loading process
//         emit(
//           LoginStateLoggedIn(
//             isLoading: true,
//             user: user,
//             images: state.images ?? [],
//           ),
//         );
//         // upload the file
//         final file = File(event.filePathToUpload);
//         await uploadImage(
//           file: file,
//           userId: user.uid,
//         );
//         // after upload is complete, grab the latest file references
//         final images = await _getImages(user.uid);
//         // emit the new images and turn off loading
//         emit(
//           LoginStateLoggedIn(
//             isLoading: false,
//             user: user,
//             images: images,
//           ),
//         );
//       },
//     );
//   }

//   Future<Iterable<Reference>> _getImages(String userId) =>
//       FirebaseStorage.instance
//           .ref(userId)
//           .list()
//           .then((listResult) => listResult.items);
// }
