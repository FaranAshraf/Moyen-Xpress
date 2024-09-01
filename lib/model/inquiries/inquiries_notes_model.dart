class InquiryNotesModel {
   num? inquiryId;
   List<Note> notes;

  InquiryNotesModel({
    required this.inquiryId,
    required this.notes,
  });

  factory InquiryNotesModel.fromJson(Map<String, dynamic> json) {
    return InquiryNotesModel(
      inquiryId: json['inquiry_id'],
      notes: (json['notes'] as List<dynamic>)
          .map((noteJson) => Note.fromJson(noteJson))
          .toList(),
    );
  }
}

class Note {
   num? id;
   String? note;
   num? senderId;
   String? senderName;
   String? image;
   num? receiverId;
   num? isSeen;

  Note({
     this.id,
     this.note,
     this.senderId,
     this.senderName,
     this.image,
     this.receiverId,
     this.isSeen,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      note: json['note']==null?"":json["note"],
      senderId: json['sender_id'],
      image: json['image'],
      senderName: json['sender_name'],
      receiverId: json['receiver_id'],
      isSeen: json['is_seen'],
    );
  }
}
