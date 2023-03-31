import 'package:flutter_bloc/flutter_bloc.dart';

abstract class RemoteState {
  const RemoteState();
}

class RemoteStateUploadCompleted extends RemoteState{
  const RemoteStateUploadCompleted();
}

class RemoteStateUploadInProgress extends RemoteState{
  final double percentage;
  RemoteStateUploadInProgress(this.percentage);
}

class RemoteStateFileUploadFailed extends RemoteState{
  const RemoteStateFileUploadFailed();
}

class RemoteStateUploadNotStarted extends RemoteState{
  const RemoteStateUploadNotStarted();
}

