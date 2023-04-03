import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class RemoteState {
  const RemoteState();
}

class RemoteStateUploadCompleted extends RemoteState{
  const RemoteStateUploadCompleted();
}

class RemoteStateUploadInProgress extends RemoteState{
  final double percentage;
  final String fileName;
  RemoteStateUploadInProgress({
    required this.percentage,
    required this.fileName
});
}

class RemoteStateFileUploadFailed extends RemoteState{
  const RemoteStateFileUploadFailed();
}

class RemoteStateUploadNotStarted extends RemoteState{
  const RemoteStateUploadNotStarted();
}

