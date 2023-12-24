// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torath/core/commonWidgets/Loader.dart';
import 'package:torath/core/commonWidgets/pageTemplate/page_template.dart';
import 'package:torath/cubits/filterCubits/getAllPlacesTimesCubit/get_all_places_times_cubit.dart';
import 'package:torath/cubits/filterCubits/getAllPlacesTimesCubit/get_all_places_times_state.dart';
import 'package:torath/cubits/getMahfalCubit/get_mahfal_cubit.dart';
import 'package:torath/cubits/getMahfalCubit/get_mahfal_state.dart';
import 'package:torath/screens/mahfalItemScreen/widgets/mahfal_screen.dart';

class MahfalItemScreen extends StatefulWidget {
  String surahName;

  MahfalItemScreen({super.key, required this.surahName});

  @override
  State<MahfalItemScreen> createState() => _MahfalItemScreenState();
}

class _MahfalItemScreenState extends State<MahfalItemScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetMahfalCubit>().getMahfal(surah: widget.surahName);
  }

  Set<String> places = <String>{};
  Set<String> times = <String>{};

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetAllPlacesCubit, GetAllPlacesState>(
      listener: (filterContext, filterState) {
        if (filterState is GetAllPlacesSuccessState) {
          places = filterState.response.places;
          times = filterState.response.times;
        }
      },
      child: BlocBuilder<GetMahfalCubit, GetMahfalState>(
        builder: (context, state) {
          if (state is GetMahfalSuccessState) {
            return PageTemplate(
              page: MahfalScreen(
                data: state.response.data!,
                filterPlaces: places,
                filterTimes: times,
              ),
            );
          } else if (state is GetMahfalLoadingState) {
            return Loader();
          } else if (state is GetMahfalErrorState) {
            return Container(
              child: Center(
                child: Text(state.message),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
