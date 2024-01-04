import 'package:flutter/material.dart';
import 'package:kima/src/data/models/classifieds/ticket.dart';
import 'package:kima/src/screens/classifieds/widgets/text_fields.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';

class TicketSection extends StatefulWidget {
  final void Function(List<Ticket>) onChanged;

  const TicketSection({required this.onChanged, super.key});

  @override
  State createState() => _TicketSectionState();
}

class _TicketSectionState extends State<TicketSection> {
  static final List<Ticket> _ticketList = [const Ticket()];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _ticketList.length,
          separatorBuilder: (context, index) => const VerticalSpace(10.0),
          itemBuilder: (context, index) {
            var ticket = _ticketList[index];
            final showAddButton = index == 0;

            return Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TicketField(
                    key: UniqueKey(),
                    hint: 'Enter name',
                    initialValue: ticket.title,
                    onChanged: (value) => _ticketList[index] = _ticketList[index].copyWith(title: value),
                  ),
                ),
                const HorizontalSpace(10.0),
                Expanded(
                  child: TicketField(
                    key: UniqueKey(),
                    hint: 'Price',
                    initialValue: (ticket.price ?? '').toString(),
                    onChanged: (value) => _ticketList[index] = _ticketList[index].copyWith(price: double.parse(value)),
                  ),
                ),
                const HorizontalSpace(10.0),
                InkWell(
                  onTap: () {
                    setState(
                      () => showAddButton ? _ticketList.add(const Ticket()) : _ticketList.removeAt(index),
                    );
                    widget.onChanged(_ticketList);
                  },
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width * 0.12,
                    height: MediaQuery.of(context).size.width * 0.12,
                    decoration: BoxDecoration(
                      color: showAddButton ? AppColors.powderBlue : AppColors.pink,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Icon(
                      showAddButton ? Icons.add : Icons.delete_outline,
                      size: 23,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class TicketField extends StatefulWidget {
  final String? initialValue;
  final String hint;
  final void Function(String) onChanged;

  const TicketField({
    super.key,
    this.initialValue,
    required this.hint,
    required this.onChanged,
  });

  @override
  State createState() => _TicketFieldState();
}

class _TicketFieldState extends State<TicketField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleTextField(
      controller: _controller,
      field: TextFieldProps(
        onChanged: widget.onChanged,
        textHints: widget.hint,
        keyboardType: widget.hint == 'Price' ? TextInputType.number : null,
      ),
    );
  }
}
