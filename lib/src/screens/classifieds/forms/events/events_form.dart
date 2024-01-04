import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/src/blocs/main/classifieds/classifieds_bloc.dart';
import 'package:kima/src/data/models/classifieds/classifieds.dart';
import 'package:kima/src/data/models/classifieds/events.dart';
import 'package:kima/src/data/models/classifieds/ticket.dart';
import 'package:kima/src/data/models/classifieds_model.dart';
import 'package:kima/src/screens/classifieds/forms/events/ticket_section.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/widgets/common/gallery_widget.dart';
import 'package:kima/src/utils/widgets/customs/custom_loader.dart';
import 'package:kima/src/utils/widgets/customs/custom_snackbar.dart';
import '../generic_widgets.dart';

class EventsForm extends StatefulWidget {
  const EventsForm({super.key});

  @override
  State<EventsForm> createState() => _EventsFormState();
}

class _EventsFormState extends State<EventsForm> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _locationController = TextEditingController();
  late ClassifiedsBloc _classifiedsBloc;

  String selectedDate = '';
  String selectedTime = '';

  List<File> selectedFiles = [];
  List<Ticket> tickets = [];
  List<FieldEntity> priceItems = [
    FieldEntity(title: 'Free', key: 'free'),
    FieldEntity(title: 'Paid', key: 'paid'),
  ];
  String selectedPrice = 'paid';

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
              inputField(
                label: 'Title',
                textHints: 'Post Title',
                controller: _titleController,
              ),
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
              inputDateField(
                  label: 'Date',
                  value: selectedDate,
                  onChanged: (val) {
                    setState(() {
                      selectedDate = val;
                    });
                  },
                  context: context),
              inputTimeField(
                  label: 'Time',
                  value: selectedTime,
                  onChanged: (val) {
                    setState(() {
                      selectedTime = val;
                    });
                  },
                  context: context),
              inputPrice(
                  context: context,
                  label: 'Event Price',
                  selectedItem: selectedPrice,
                  items: priceItems,
                  onCallback: (String val) {
                    setState(() {
                      selectedPrice = val;
                    });
                  }),
              selectedPrice == 'paid'
                  ? TicketSection(onChanged: (value) => setState(() => tickets = value))
                  : const SizedBox(),
              publishButton(
                onTap: () {
                  final classifiedAd = Classifieds(
                    title: _titleController.text,
                    description: _descController.text,
                    location: _locationController.text,
                    category: ClassifiedsCategory.events.name,
                    eventDetails: Events(
                      eventType: selectedPrice,
                      date: selectedDate,
                      time: selectedTime,
                      tickets: tickets,
                    ),
                  );

                  context.read<ClassifiedsBloc>().add(
                        CreateClassifiedsEvent(
                          classifiedAd: classifiedAd,
                          gallery: selectedFiles,
                        ),
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
