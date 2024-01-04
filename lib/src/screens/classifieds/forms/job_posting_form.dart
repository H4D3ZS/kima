import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:kima/src/blocs/main/classifieds/classifieds_bloc.dart';
import 'package:kima/src/data/models/classifieds/classifieds.dart';
import 'package:kima/src/data/models/classifieds/job_posting.dart';
import 'package:kima/src/data/models/classifieds_model.dart';
import 'package:kima/src/data/models/dynamic_model.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/widgets/common/gallery_widget.dart';
import 'package:kima/src/utils/widgets/customs/custom_loader.dart';
import 'package:kima/src/utils/widgets/customs/custom_snackbar.dart';

import 'generic_widgets.dart';

class JobPostingForm extends StatefulWidget {
  const JobPostingForm({super.key});

  @override
  State<JobPostingForm> createState() => _JobPostingFormState();
}

class _JobPostingFormState extends State<JobPostingForm> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _locationController = TextEditingController();
  final _salaryController = TextEditingController();
  late ClassifiedsBloc _classifiedsBloc;

  List<FieldEntity> radioListSalary = [
    FieldEntity(title: 'Undisclosed', key: 'undisclosed'),
    FieldEntity(title: 'Post salary', key: 'postSalary'),
  ];
  String selectedSalary = 'undisclosed';

  List<String> employmentType = ['Full-time', 'Part-time', 'Contractual', 'Freelance'];
  String selectedEmpType = '';

  int sectionCount = 1;
  int rowCount = 1;

  List<DynamicField> dynamicFields = [];
  List<File> selectedFiles = [];

  @override
  void initState() {
    _classifiedsBloc = BlocProvider.of<ClassifiedsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClassifiedsBloc>.value(
      value: _classifiedsBloc,
      child: BlocListener<ClassifiedsBloc, ClassifiedsState>(
        listener: (context, state) {
          final status = state.status;

          if (status == Status.loading) {
            showLoader(context);
          }
          if (status == Status.failed) {
            closeLoader(context);
            CustomSnackBar.error(context, state.error!.message);
          }
          if (status == Status.success) {
            closeLoader(context);
            Navigator.pop(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              inputField(label: 'Title', textHints: 'Post Title', controller: _titleController),
              inputField(
                  label: 'Description',
                  textHints: 'Post Description',
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  controller: _descController),
              GalleryWidget(
                label: 'Gallery',
                onChanged: (files) => setState(() => selectedFiles = files),
              ),
              inputField(label: 'Location', textHints: 'Enter location here', controller: _locationController),
              inputDropdownSelection(
                  label: 'Employment Type',
                  textHints: 'Select Employment Type',
                  items: employmentType,
                  selected: selectedEmpType,
                  onChanged: (dynamic val) {
                    setState(() {
                      selectedEmpType = val;
                    });
                  }),
              inputSalary(
                items: radioListSalary,
                selectedSalary: selectedSalary,
                controller: _salaryController,
                label: 'Salary',
                textHints: 'Enter salary here',
                onChanged: (dynamic val) {
                  setState(() {
                    selectedSalary = val!;
                  });
                },
                context: context,
              ),
              inputSection(
                  label: 'Section',
                  rowCount: rowCount,
                  sectionCount: sectionCount,
                  onAdd: () => setState(() {
                        rowCount++;
                      }),
                  onDelete: () => setState(() {
                        rowCount--;
                      }),
                  onAddSection: () => setState(() {
                        sectionCount++;
                      }),
                  onDeleteSection: () => setState(() {
                        sectionCount--;
                      }),
                  dynamicFields: dynamicFields),
              publishButton(
                onTap: () {
                  final classifiedAd = Classifieds(
                    title: _titleController.text,
                    description: _descController.text,
                    location: _locationController.text,
                    category: ClassifiedsCategory.job_posting.name,
                    jobPostingDetails: JobPosting(
                      employmentType: selectedEmpType,
                      salary: selectedSalary == 'undisclosed' ? null : double.parse(selectedSalary),
                      // TODO: Section input
                      sections: const [],
                    ),
                  );

                  context.read<ClassifiedsBloc>().add(
                        CreateClassifiedsEvent(
                          classifiedAd: classifiedAd,
                          gallery: selectedFiles,
                        ),
                      );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
