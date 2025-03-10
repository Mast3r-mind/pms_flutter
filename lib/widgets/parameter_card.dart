class ParameterCard extends StatelessWidget {
  final VitalParameter parameter;
  final bool isDragging;

  const ParameterCard({
    Key? key,
    required this.parameter,
    this.isDragging = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      elevation: isDragging ? 8 : 0,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: parameter.color,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Drag Handle
            Container(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.drag_handle,
                color: parameter.color,
              ),
            ),
            // Parameter Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          parameter.name,
                          style: TextStyle(
                            color: parameter.color,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (parameter.name == 'NIBP')
                          Text(
                            '15:30',
                            style: TextStyle(
                              color: parameter.color,
                              fontSize: 14,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          parameter.value,
                          style: TextStyle(
                            color: parameter.color,
                            fontSize: parameter.name == 'NIBP' ? 24 : 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (parameter.unit != null)
                          Text(
                            parameter.unit!,
                            style: TextStyle(
                              color: parameter.color,
                              fontSize: 14,
                            ),
                          ),
                      ],
                    ),
                    if (parameter.subValue != null)
                      Text(
                        parameter.subValue!,
                        style: TextStyle(
                          color: parameter.color,
                          fontSize: 14,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 