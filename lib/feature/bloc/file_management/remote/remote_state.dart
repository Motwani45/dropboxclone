import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class RemoteState {
  final String fileName;
  const RemoteState({
    required this.fileName
});
}

class RemoteStateUploadCompleted extends RemoteState{

  const RemoteStateUploadCompleted({
    required super.fileName
});
}

class RemoteStateUploadInProgress extends RemoteState{
  final double percentage;
  RemoteStateUploadInProgress({
    required this.percentage,
    required super.fileName
});
}

class RemoteStateFileUploadFailed extends RemoteState{
  const RemoteStateFileUploadFailed({
    required super.fileName
});
}

class RemoteStateUploadNotStarted extends RemoteState{
  const RemoteStateUploadNotStarted({
    required super.fileName
});
}

