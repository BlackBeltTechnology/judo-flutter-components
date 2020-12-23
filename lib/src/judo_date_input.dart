part of judo.components;

class JudoDateInput extends StatefulWidget {
  JudoDateInput({
    Key key,
    @required this.col,
    this.row = 1,
    this.label,
    this.icon,
    this.onChanged,
    @required this.initialDate,
    this.readOnly = false,
    this.disabled = false,
    this.firstDate,
    this.lastDate,
    this.padding,
    this.stretch = false,
    this.alignment = Alignment.centerLeft,
  }) : super(key: key);

  final int col;
  final double row;
  final String label;
  final Icon icon;
  final Function onChanged;
  final DateTime initialDate;
  final bool readOnly;
  final bool disabled;
  final DateTime firstDate;
  final DateTime lastDate;
  final bool stretch;
  final Alignment alignment;
  final EdgeInsets padding;

  @override
  _JudoDateInputState createState() => _JudoDateInputState();
}

class _JudoDateInputState extends State<JudoDateInput> {
  final TextEditingController controller = TextEditingController();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    controller.text = widget.initialDate != null ? formatter.format(widget.initialDate) : null;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return JudoContainer(
      color: widget.disabled ? JudoComponentsSettings.disabledColor : null,
      padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 10),
      col: widget.col,
      row: widget.row,
      stretch: widget.stretch,
      alignment: widget.alignment,
      child: TextField(
        controller: controller,
        readOnly: widget.disabled ? true : widget.readOnly,
        enabled: widget.disabled ? false : !widget.readOnly,
        decoration: widget.disabled ?
        InputDecoration(
          labelText: widget.label,
          prefixIcon: widget.icon,
          suffixIcon: iconDatePicker(context),
        )
            : widget.readOnly ?
        InputDecoration(
          labelText: widget.label,
          prefixIcon: widget.icon,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,

        )
            :
        InputDecoration(
          labelText: widget.label,
          prefixIcon: widget.icon,
          suffixIcon: iconDatePicker(context),
        ),
        onChanged: (value) => onChangedHandler(DateTime.parse(value)),
      ),
    );
  }

  Widget iconDatePicker(BuildContext context) {
    var tempDateTime = widget.initialDate ?? DateTime.now();
    return IconButton(
        icon: Icon(
          Icons.calendar_today,
          color: widget.disabled ? JudoComponentsSettings.disabledColor : null,
        ),
        onPressed: widget.disabled ? null : () async {
          tempDateTime = await showDatePicker(
            context: context,
            initialDate: tempDateTime,
            firstDate: widget.firstDate ?? DateTime(1900),
            lastDate: widget.lastDate ?? DateTime(2100),
          );
          onChangedHandler(tempDateTime);
        }
    );

  }

  void onChangedHandler(DateTime value) {
    if (widget.onChanged != null) {
      controller.text = formatter.format(value);
      widget.onChanged(value);
    }
  }
}
