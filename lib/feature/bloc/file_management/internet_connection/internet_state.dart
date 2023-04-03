abstract class InternetState{
  const InternetState();
}

class InternetStateInitialState extends InternetState{
  const InternetStateInitialState();
}
class InternetStateOnConnected extends InternetState{
  const InternetStateOnConnected();
}
class InternetStateNotConnected extends InternetState{
  const InternetStateNotConnected();
}