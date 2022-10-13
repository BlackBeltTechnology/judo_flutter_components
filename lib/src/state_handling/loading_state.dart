part of judo.components.state_handling;

typedef FutureFunction = Future<void> Function();

class LoadingState extends _LoadingState with _$LoadingState {
  LoadingState(Function setDisabledByLoading){
    super.setDisabledByLoading = setDisabledByLoading;
  }
}

abstract class _LoadingState with Store {
    Function setDisabledByLoading;

    @observable
    bool isLoading = false;

    @action
    void setIsLoading (bool loading) {
        this.isLoading = loading;
        setDisabledByLoading(loading);
    }

    @action
    Future<void> onPressed( FutureFunction onPressed ) async {
        isLoading = true;
        setDisabledByLoading(true);
        await onPressed().catchError((_) {
          isLoading = false;
          setDisabledByLoading(false);
        });
        isLoading = false;
        setDisabledByLoading(false);
    }
}
