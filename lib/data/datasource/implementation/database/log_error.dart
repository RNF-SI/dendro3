void logError(Exception e, StackTrace stackTrace, String operation,
    Map<String, dynamic> parameters) {
  // Log the error with details
  print('Error in $operation: $e');
  print('Parameters: $parameters');
  print('StackTrace: $stackTrace');
}
