typedef UpdateOptions = bool Function(String text);
typedef CloseOptions = bool Function();

class LoadingController {
  final CloseOptions closeOptions;
  final UpdateOptions updateOptions;

  const LoadingController({
    required this.closeOptions,
    required this.updateOptions,
  });
}
