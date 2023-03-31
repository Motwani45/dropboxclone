import 'package:dropboxclone/core/error/file_management/file_management_error.dart';
import 'package:dropboxclone/feature/data/datasources/file_management/remote/remote_datasource.dart';
import 'package:dropboxclone/feature/domain/entity/file_management/remote/remote_file_entity.dart';
import 'package:dropboxclone/feature/domain/repository/file_management/remote_repository.dart';
import 'package:fpdart/src/either.dart';

class RemoteRepositoryImpl extends RemoteRepository{
  final RemoteDataSource dataSource;
  RemoteRepositoryImpl({required this.dataSource});
  @override
  Future<Either<FileManagementError, RemoteFileEntity>> startUpload({required String userId,required String fileName,required String filePath}) {
  return dataSource.startUpload(userId: userId, fileName: fileName, filePath: filePath);
  }

}