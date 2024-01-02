import 'package:dictionary_app_1110/bloc/bloc_app/bloc_app.dart';
import 'package:dictionary_app_1110/models/new_word_model.dart';
import 'package:dictionary_app_1110/views/gen/generic_typedef_func.dart';
import 'package:dictionary_app_1110/views/entry_tile/word_tile.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  final AppBloc appBloc;
  final Iterable<DictionaryEntry> data;
  // final int dataLength;
  final TileTap func;
  const HomePage({
    super.key,
    required this.appBloc,
    required this.data,
    // required this.dataLength,
    required this.func,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  late int dataLength;

  @override
  void initState() {
    super.initState();
    initialDataLength();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  void initialDataLength() {
    if (widget.data.length <= 30) {
      setState(() {
        dataLength = widget.data.length;
      });
    } else {
      setState(() {
        dataLength = 30;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_scrollListener);
  }

  // void getDataLength() {
  //   // index = ? dataLength : 30;
  //   if (dataLength < 20) {
  //     return index = dataLength;
  //   } else {
  //     return index = 30;
  //   }
  // }

  void _scrollListener() {
    if ((dataLength > widget.data.length ||
                dataLength + 10 > widget.data.length) &&
            dataLength != widget.data.length ||
        dataLength == 0) {
      setState(() {
        dataLength = widget.data.length;
      });
    } else if (_scrollController.position.extentAfter < 100 &&
        dataLength < widget.data.length) {
      setState(() {
        dataLength = dataLength + 10;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // bool isSearching = widget.appBloc.state is SearchingState;
    // dataLength = dataLength < 20 ? dataLength : 30;
    // print(dataLength);
    print("yes");
    print(dataLength);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ListView.builder(
        key: ObjectKey(widget.data),
        controller: _scrollController,
        itemCount: dataLength,
        itemBuilder: (context, index) {
          return wordTile(
            widget.data.elementAt(index),
            widget.func,
          );
        },
      ),
    );
  }
}
