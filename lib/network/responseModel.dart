class ResponseModel<T> {
  late Status status;
  late String message;
  late T data;

  ResponseModel.loading(this.message): status = Status.LOADING;
  ResponseModel.complete(this.data): status = Status.COMPLETED;
  ResponseModel.error(this.message): status = Status.ERROR;

  @override
  String toString(){
    return "Status: $status\n Message: $message\n Data: $data";
  }
}

// ignore: constant_identifier_names
enum Status { LOADING, COMPLETED, ERROR }
