import 'package:dictionary_app_1110/bloc/bloc_app/bloc_app.dart';
import 'package:dictionary_app_1110/bloc/data_in_cubit.dart';
import 'package:dictionary_app_1110/firebase_options.dart';
import 'package:dictionary_app_1110/models/chat_model.dart';
import 'package:dictionary_app_1110/models/new_word_model.dart';
import 'package:dictionary_app_1110/repositories/url_entry.dart';
import 'package:dictionary_app_1110/services/hive_service/local_data_service.dart';
import 'package:dictionary_app_1110/views/main_control_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await initialHive();

  await LocalDataService().initial(url: urlEnglish);
  var appBloc = AppBloc();
  await initialData(appBloc);

  return runApp(AppBarApp(
    appBloc: appBloc,
  ));
}

Future<void> initialHive() async {
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(DictionaryEntryAdapter());
  Hive.registerAdapter(MeaningAdapter());
  Hive.registerAdapter(PronunciationAdapter());
  Hive.registerAdapter(ChatMessageAdapter());
  Hive.registerAdapter(MessageTypeAdapter());
}

Future<void> initialData(AppBloc appBloc) async {
  appBloc.allDataCubit = AllDataCubit();
  appBloc.settingsCubit = SettingsCubit();
  appBloc.favoriteCubit = FavoriteCubit();
  appBloc.historyCubit = HistoryCubit();

  await appBloc.initialSettings();
  await appBloc.initialCubitData();
}

class AppBarApp extends StatelessWidget {
  final AppBloc appBloc;
  const AppBarApp({super.key, required this.appBloc});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => AppBloc(),
        child: ControlView(appBloc: appBloc),
      ),
    );
  }
}
