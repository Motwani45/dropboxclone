import 'package:bloc_test/bloc_test.dart';
import 'package:dropboxclone/feature/bloc/file_management/internet_connection/internet_cubit.dart';
import 'package:dropboxclone/feature/bloc/file_management/internet_connection/internet_state.dart';
import 'package:dropboxclone/feature/bloc/file_management/local/local_cubit.dart';
import 'package:dropboxclone/feature/bloc/file_management/local/local_state.dart';
import 'package:dropboxclone/feature/presentation/pages/file_management/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLocalCubit extends MockCubit<LocalState> implements LocalCubit {}

class MockInternetCubit extends MockCubit<InternetState> implements InternetCubit{}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  group("Home Page Test", () {
    String dummyUserId = "abed";
    late InternetCubit internetCubit;
    late LocalCubit localCubit;
    late BuildContext context;
    setUp(() {
      internetCubit=MockInternetCubit();
      localCubit = MockLocalCubit();
      context = MockBuildContext();

    });
    testWidgets(
      "Floating ActionButton",
      (widgetTester) async {
        await widgetTester.pumpWidget(
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (_){
                return internetCubit;
              }),
              BlocProvider(
                create: (_) {
                  return localCubit;
                },
              ),
            ],
            child: MaterialApp(
              home: HomePage(
                userId: dummyUserId,
              ),
            ),
          ),
        );
        when(() {
          return localCubit.addFile(context);
        });
        widgetTester.tap(find.byType(FloatingActionButton));
        verify(() {
          return localCubit.addFile(context);
        }).called(1);
      },
    );
  });
}
