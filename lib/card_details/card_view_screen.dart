import 'package:flutter/material.dart';

class TicketDetailScreen extends StatelessWidget {
  final Ticket ticket; // Angenommen, wir haben ein Ticket-Model

  const TicketDetailScreen({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket #${ticket.id}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Ticket bearbeiten
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status und Priorität
              Row(
                children: [
                  Chip(
                    label: Text(ticket.status),
                    backgroundColor: _getStatusColor(ticket.status),
                  ),
                  const SizedBox(width: 8),
                  Chip(
                    label: Text(ticket.priority),
                    backgroundColor: _getPriorityColor(ticket.priority),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Titel und Beschreibung
              Text(
                ticket.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                ticket.description,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),

              // Labels
              if (ticket.labels.isNotEmpty) ...[
                const Text('Labels:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Wrap(
                  spacing: 8,
                  children: ticket.labels
                      .map((label) => Chip(label: Text(label)))
                      .toList(),
                ),
                const SizedBox(height: 16),
              ],

              // Anhänge
              if (ticket.attachments.isNotEmpty) ...[
                const Text('Anhänge:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: ticket.attachments.length,
                  itemBuilder: (context, index) {
                    final attachment = ticket.attachments[index];
                    return ListTile(
                      leading: const Icon(Icons.attachment),
                      title: Text(attachment.name),
                      subtitle: Text('${attachment.size} MB'),
                      onTap: () {
                        // Anhang öffnen
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),
              ],

              // Kommentare
              const Text('Kommentare:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ticket.comments.length,
                itemBuilder: (context, index) {
                  final comment = ticket.comments[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(comment.authorAvatar),
                                radius: 16,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                comment.authorName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              Text(
                                _formatDate(comment.createdAt),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(comment.content),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Neuen Kommentar hinzufügen
          _showCommentDialog(context);
        },
        child: const Icon(Icons.comment),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'offen':
        return Colors.blue;
      case 'in bearbeitung':
        return Colors.orange;
      case 'erledigt':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'hoch':
        return Colors.red;
      case 'mittel':
        return Colors.orange;
      case 'niedrig':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year} ${date.hour}:${date.minute}';
  }

  void _showCommentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Neuer Kommentar'),
        content: TextField(
          maxLines: 5,
          decoration: const InputDecoration(
            hintText: 'Kommentar eingeben...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () {
              // Kommentar speichern
              Navigator.pop(context);
            },
            child: const Text('Speichern'),
          ),
        ],
      ),
    );
  }
}

// Beispiel-Modelle (in der Praxis würden diese in separate Dateien ausgelagert)
class Ticket {
  final String id;
  final String title;
  final String description;
  final String status;
  final String priority;
  final List<String> labels;
  final List<Attachment> attachments;
  final List<Comment> comments;

  Ticket({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.labels,
    required this.attachments,
    required this.comments,
  });
}

class Attachment {
  final String name;
  final double size;

  Attachment({
    required this.name,
    required this.size,
  });
}

class Comment {
  final String authorName;
  final String authorAvatar;
  final String content;
  final DateTime createdAt;

  Comment({
    required this.authorName,
    required this.authorAvatar,
    required this.content,
    required this.createdAt,
  });
}
