
import 'package:dropboxclone/core/utils/loading/loading_screen.dart';
import 'package:dropboxclone/feature/bloc/file_management/file_cubit.dart';
import 'package:dropboxclone/feature/bloc/file_management/file_state.dart';
import 'package:dropboxclone/feature/presentation/widgets/file_management/filelisttile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class HomePage extends StatefulWidget {
  final String userId;
  const HomePage({Key? key,required this.userId}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          title: const Text("DropBox Clone"),
        ),
        body: BlocConsumer<FileCubit,FileState>(
          builder: (context,state){
            if(state is FileStateInitialState){
              return const Center(child: Text("No Files Uploaded Till Now!"),);
            }
            if(state is FileStateGetFiles){
              if(state.files.isEmpty){
                return const Center(child: Text("No Files Uploaded Till Now!"),);
              }
              return ListView.builder(itemBuilder: (context,index){
                return FileListTile(file: state.files[index]);
              },
              itemCount: state.files.length,);
            }
            return Container();
          },
          listener: (context,state){
            if(state.isLoading){
              LoadingScreen.instance().show(context: context, text: "Adding Your File");
            }
            else{
              LoadingScreen.instance().hide();
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<FileCubit>().addFile();
          },
          child: const Icon(Icons.add),
        ),
      );
  }
}