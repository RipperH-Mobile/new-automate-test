import 'package:fpdart/fpdart.dart';

abstract class UseCase<T, Params> {
  Future<Either<dynamic, T>> call(Params params);
}

abstract class SimpleUseCase<T, Params> {
  Future<T> call(Params params);
}

abstract class SimpleUseCaseSync<T, Params> {
  T call(Params params);
}

class NoParams {}
