abstract class DataState {
  final int status;

  DataState(this.status);
}


class DataFailure extends DataState {
  final String message;
  DataFailure(super.status, this.message);
}
class DataFailedOffline extends DataState {
  final String message;
  DataFailedOffline(super.status, this.message);
}
