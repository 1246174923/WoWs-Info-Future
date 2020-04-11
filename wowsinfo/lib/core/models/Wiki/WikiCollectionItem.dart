/// This is the `WikiCollectionItem` class
class WikiCollectionItem {
  Map<String, CollectionItem> item;

  WikiCollectionItem.fromJson(Map<String, dynamic> json) {
    this.item = json;
  }

  Map<String, dynamic> toJson() => this.item;
}

/// This is the `CollectionItem` class
class CollectionItem {
  Image image;
  int collectionId;
  String description;
  String name;
  int cardId;

  CollectionItem.fromJson(Map<String, dynamic> json) {
    this.image = Image.fromJson(json['images']);
    this.collectionId = json['collection_id'];
    this.description = json['description'];
    this.name = json['name'];
    this.cardId = json['card_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'images': this.image,
      'collection_id': this.collectionId,
      'description': this.description,
      'name': this.name,
      'card_id': this.cardId,
    };
  }
}

/// This is the `Image` class
class Image {
  String small;

  Image.fromJson(Map<String, dynamic> json) {
    this.small = json['small'];
  }

  Map<String, dynamic> toJson() {
    return {
      'small': this.small,
    };
  }
}
