abstract class DownloadDispositifDataUseCase {
  Future<void> execute(
    final int id,
    Function(double) onProgressUpdate,
  );
}
