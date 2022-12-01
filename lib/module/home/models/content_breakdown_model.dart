// To parse this JSON data, do
//
//     final contentBreakdownModel = contentBreakdownModelFromJson(jsonString);

import 'dart:convert';

ContentBreakdownModel contentBreakdownModelFromJson(String str) => ContentBreakdownModel.fromJson(json.decode(str));

String contentBreakdownModelToJson(ContentBreakdownModel data) => json.encode(data.toJson());

class ContentBreakdownModel {
    ContentBreakdownModel({
        required this.posts,
    });

    List<Post> posts;

    factory ContentBreakdownModel.fromJson(Map<String, dynamic> json) => ContentBreakdownModel(
        posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
    };
}

class Post {
    Post({
        required this.socialNetworkId,
        required this.caption,
        required this.picture,
        required this.date,
        required this.link,
        required this.totalComments,
        required this.totalReactions,
        required this.totalImpressions,
        required this.totalEngagements,
        required this.totalShares,
    });

    int socialNetworkId;
    String caption;
    String picture;
    DateTime date;
    String link;
    int totalComments;
    int totalReactions;
    int totalImpressions;
    int totalEngagements;
    int totalShares;

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        socialNetworkId: json["social_network_id"],
        caption: json["caption"],
        picture: json["picture"],
        date: DateTime.parse(json["date"]),
        link: json["link"],
        totalComments: json["total_comments"],
        totalReactions: json["total_reactions"],
        totalImpressions: json["total_impressions"],
        totalEngagements: json["total_engagements"],
        totalShares: json["total_shares"],
    );

    Map<String, dynamic> toJson() => {
        "social_network_id": socialNetworkId,
        "caption": caption,
        "picture": picture,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "link": link,
        "total_comments": totalComments,
        "total_reactions": totalReactions,
        "total_impressions": totalImpressions,
        "total_engagements": totalEngagements,
        "total_shares": totalShares,
    };
}
