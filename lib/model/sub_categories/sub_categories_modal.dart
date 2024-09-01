class ParentObject {
  final dynamic failReason;
  final dynamic failReasonContent;
  final List<SuccessContent> successContents;

  ParentObject({
    this.failReason,
    this.failReasonContent,
    required this.successContents,
  });

  factory ParentObject.fromJson(Map<String, dynamic> json) {
    return ParentObject(
      failReason: json['failReason'],
      failReasonContent: json['failReasonContent'],
      successContents: (json['successContents'] as List)
          .map((item) => SuccessContent.fromJson(item))
          .toList(),
    );
  }
}

class SuccessContent {
  final int id;
  final int parentId;
  final int level;
  final String name;
  final int orderLevel;
  final int commissionRate;
  final dynamic banner;
  final dynamic icon;
  final int featured;
  final int top;
  final int digital;
  final String slug;
  final String? metaTitle;
  final String? metaDescription;
  final dynamic metaKeywords;
  final String createdAt;
  final String updatedAt;

  SuccessContent({
    required this.id,
    required this.parentId,
    required this.level,
    required this.name,
    required this.orderLevel,
    required this.commissionRate,
    this.banner,
    this.icon,
    required this.featured,
    required this.top,
    required this.digital,
    required this.slug,
    this.metaTitle,
    this.metaDescription,
    this.metaKeywords,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SuccessContent.fromJson(Map<String, dynamic> json) {
    return SuccessContent(
      id: json['id'],
      parentId: json['parent_id'],
      level: json['level'],
      name: json['name'],
      orderLevel: json['order_level'],
      commissionRate: json['commision_rate'],
      banner: json['banner'],
      icon: json['icon'],
      featured: json['featured'],
      top: json['top'],
      digital: json['digital'],
      slug: json['slug'],
      metaTitle: json['meta_title'],
      metaDescription: json['meta_description'],
      metaKeywords: json['meta_keywords'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
