import 'dart:io';
import 'dart:math';

extension FileSize on File{
  Future<String> getFileSize() async{
    final bytes=await length();
    const suffixes = ["b", "kb", "mb", "gb", "tb"];
    var i = (log(bytes) / log(1000)).floor();
    return ((bytes / pow(1000, i)).toStringAsFixed(1)) + suffixes[i];
  }
}