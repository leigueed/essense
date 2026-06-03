import 'package:flutter/material.dart';
import 'package:essence/core/theme.dart';

class NoteBar extends StatelessWidget {
  final String topNote;
  final String heartNote;
  final String baseNote;

  const NoteBar({
    super.key,
    required this.topNote,
    required this.heartNote,
    required this.baseNote,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _NoteRow(
            label: 'Topo',
            notes: topNote,
            widthFactor: 0.7,
            color: AppTheme.primary.withValues(alpha: 0.4)),
        const SizedBox(height: 6),
        _NoteRow(
            label: 'Coração',
            notes: heartNote,
            widthFactor: 1.0,
            color: AppTheme.primary.withValues(alpha: 0.7)),
        const SizedBox(height: 6),
        _NoteRow(
            label: 'Fundo',
            notes: baseNote,
            widthFactor: 0.5,
            color: AppTheme.primary),
      ],
    );
  }
}

class _NoteRow extends StatelessWidget {
  final String label;
  final String notes;
  final double widthFactor;
  final Color color;

  const _NoteRow({
    required this.label,
    required this.notes,
    required this.widthFactor,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(
            label,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: AppTheme.textSecondary),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: FractionallySizedBox(
            widthFactor: widthFactor,
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
