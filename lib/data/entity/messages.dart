class Messages {
  int id;
  String sender_id;
  String reciever_id;
  String content;
  DateTime date;
  DateTime time;
  String status;

  Messages({required this.id,
    required this.sender_id,
    required this.reciever_id,
    required this.content,
    required this.date,
    required this.time,
    required this.status});

}