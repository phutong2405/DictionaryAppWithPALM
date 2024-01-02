// import 'package:dictionary_app_1110/views/gen/generic_typedef_func.dart';

// class SystemLanguage {
//   SystemLanguage._shareInstance();
//   static final SystemLanguage _shared = SystemLanguage._shareInstance();
//   factory SystemLanguage.instance() => _shared;

//   late final String stringErrorState;
//   late final String stringNoItems;
//   late final String stringNoChat;
//   late final String stringChatTitle;
//   late final String stringNavigationHistory;
//   late final String stringNavigationFavorite;
//   late final String stringNavigationSettings;
//   late final String stringNavigationTranslate;
//   late final String stringNavigationHome;
//   late final String dictionariesTitle;
//   late final String stringLookUp;
//   late final String stringItemDefinition;
//   late final String stringItemExamples;
//   late final String stringButtonSharing;
//   late final String stringButtonAsk;
//   late final String stringButtonPlaySound;
//   late final String stringButtonFavorite;

//   SystemLanguage({required bool isEnglish}) {
//     stringErrorState = stringErrorStateMap[isEnglish] ?? "";
//     stringNoItems = stringNoItemsMap[isEnglish] ?? "";
//     stringNoChat = stringNoChatMap[isEnglish] ?? "";
//     stringChatTitle = stringChatTitleMap[isEnglish] ?? "";
//     stringNavigationHistory = stringNavigationHistoryMap[isEnglish] ?? "";
//     stringNavigationFavorite = stringNavigationFavoriteMap[isEnglish] ?? "";
//     stringNavigationSettings = stringNavigationSettingsMap[isEnglish] ?? "";
//     stringNavigationTranslate = stringNavigationTranslateMap[isEnglish] ?? "";
//     stringNavigationHome = stringNavigationHomeMap[isEnglish] ?? "";
//     dictionariesTitle = dictionariesTitleMap[isEnglish] ?? "";
//     stringLookUp = stringLookUpMap[isEnglish] ?? "";
//     stringItemDefinition = stringItemDefinitionMap[isEnglish] ?? "";
//     stringItemExamples = stringItemExamplesMap[isEnglish] ?? "";
//     stringButtonSharing = stringButtonSharingMap[isEnglish] ?? "";
//     stringButtonAsk = stringButtonAskMap[isEnglish] ?? "";
//     stringButtonPlaySound = stringButtonPlaySoundMap[isEnglish] ?? "";
//     stringButtonFavorite = stringButtonFavoriteMap[isEnglish] ?? "";
//   }

//   Future<void> setLanguage({required bool isEnglish}) async {
//     print("set");
//     SystemLanguage._shared; // Đảm bảo thể hiện đã được khởi tạo
//     print(_shared.stringErrorState);
//   }
// }

// Map<Languages, String> stringErrorStateMap = {
//   Languages.english: "Please, choose others.",
//   Languages.vietnamese: "Vui lòng chọn một từ điển."
// };

// Map<Languages, String> stringNoItemsMap = {
//   Languages.english: "no items.",
//   Languages.vietnamese: "trống."
// };

// Map<Languages, String> stringNoChatMap = {
//   Languages.english: "ask some  ?? " "",
//   Languages.vietnamese: "hỏi gì đê  ?? " ""
// };

// Map<Languages, String> stringChatTitleMap = {
//   Languages.english: "Assistant",
//   Languages.vietnamese: "Assistant"
// };

// Map<Languages, String> stringNavigationHistoryMap = {
//   Languages.english: "History",
//   Languages.vietnamese: "Lịch sử"
// };

// Map<Languages, String> stringNavigationFavoriteMap = {
//   Languages.english: "Favorites",
//   Languages.vietnamese: "Yêu thích"
// };

// Map<Languages, String> stringNavigationSettingsMap = {
//   Languages.english: "Settings",
//   Languages.vietnamese: "Tùy chỉnh"
// };

// Map<Languages, String> stringNavigationTranslateMap = {
//   Languages.english: "Languages",
//   Languages.vietnamese: "Ngôn ngữ"
// };

// Map<Languages, String> stringNavigationHomeMap = {
//   Languages.english: "Home",
//   Languages.vietnamese: "Trang chủ"
// };

// Map<Languages, String> dictionariesTitleMap = {
//   Languages.english: "Dictionaries",
//   Languages.vietnamese: "Loại từ điển"
// };

// Map<Languages, String> stringLookUpMap = {
//   Languages.english: "Look up for this word and give some examples: ",
//   Languages.vietnamese: "Look up for this word and give some examples: "
// };

// Map<Languages, String> stringItemDefinitionMap = {
//   Languages.english: "definition",
//   Languages.vietnamese: "định nghĩa"
// };

// Map<Languages, String> stringItemExamplesMap = {
//   Languages.english: "examples",
//   Languages.vietnamese: "ví dụ"
// };

// Map<Languages, String> stringButtonSharingMap = {
//   Languages.english: "Share",
//   Languages.vietnamese: "Share"
// };

// Map<Languages, String> stringButtonAskMap = {
//   Languages.english: "Ask AI",
//   Languages.vietnamese: "Hỏi AI"
// };

// Map<Languages, String> stringButtonPlaySoundMap = {
//   Languages.english: "Play Sounds",
//   Languages.vietnamese: "Phát âm"
// };

// Map<Languages, String> stringButtonFavoriteMap = {
//   Languages.english: "Favorite",
//   Languages.vietnamese: "Thích"
// };

const String stringErrorState = 'Please, choose others.';
const String stringNoItems = 'no items';
const String stringNoChat = 'ask some !';

const String stringChatTitle = 'Assistant';
const String stringNavigationHistory = 'History';
const String stringNavigationFavorite = 'Favorites';
const String stringNavigationSettings = 'Settings';
const String stringNavigationTranslate = 'Translations';
const String stringNavigationHome = 'Home';

const String stringLookUp = 'Look up for this word and give some examples: ';

const String stringItemDefinition = 'definition:';
const String stringItemExamples = 'examples:';

const String stringButtonSharing = 'Share';
const String stringButtonAsk = 'Ask AI';
const String stringButtonPlaySound = 'Play Sounds';
const String stringButtonFavorite = 'Favorite';
