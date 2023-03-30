import 'package:dropboxclone/feature/domain/entity/file_management/file_entity.dart';
import 'package:flutter/material.dart';
class FileListTile extends StatefulWidget {
  final FileEntity file;
  const FileListTile({required this.file,Key? key}) : super(key: key);

  @override
  State<FileListTile> createState() => _FileListTileState();
}

class _FileListTileState extends State<FileListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.file.fileName),
    );
  }
}
