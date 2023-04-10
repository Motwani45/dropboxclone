
import 'dart:math';

extension FileSize on int{
  String getFileSize() {
    // when length of file exceeds the range of int and give NAN error
    if(this==0){
      return "1b";
    }
    const suffixes = ["b", "kb", "mb", "gb", "tb"];
    var i = (log(this) / log(1000)).floor();
    return ((this / pow(1000, i)).toStringAsFixed(1)) + suffixes[i];
  }
}