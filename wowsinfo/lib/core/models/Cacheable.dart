/// For models that are going to be cached locally
/// - The output can be a json map or a json string
abstract class Cacheable {
  /// Check if the data is valid and whether it is corrupted
  bool isValid();
  /// Convert itself to a json map
  Map<String, dynamic> toJson();
  /// This is the final output to be saved
  dynamic output();
}
