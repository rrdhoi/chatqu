import 'package:chatqu/app/app.dart';
import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/presentation/presentation.dart';

part 'upload_image_profile_state.dart';

class UploadImageProfileCubit extends Cubit<UploadImageProfileState> {
  final UploadImageProfileUseCase _uploadImageProfileUseCase;

  UploadImageProfileCubit(this._uploadImageProfileUseCase)
      : super(UploadImageProfileInitial());

  void uploadImageProfile(File image, String userId) async {
    emit(UploadImageProfileLoading());
    final result = await _uploadImageProfileUseCase.execute(image, userId);
    result.fold(
      (failure) => emit(UploadImageProfileFailure(failure.message)),
      (message) => emit(UploadImageProfileSuccess(message)),
    );
  }
}
