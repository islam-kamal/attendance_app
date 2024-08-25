class Task{
  final String? id, header , description ,timeStamp;
   bool?  status;
  Task({this.id , required this.header,required this.description,required this.timeStamp , this.status});

  // Implement equality and hashcode to compare tasks by id
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Task && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
