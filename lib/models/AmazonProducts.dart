// To parse this JSON data, do
//
//     final amazonProductsListing = amazonProductsListingFromJson(jsonString);

import 'dart:convert';

List<AmazonProductsListing> amazonProductsListingFromJson(String str) => List<AmazonProductsListing>.from(json.decode(str).map((x) => AmazonProductsListing.fromJson(x)));

String amazonProductsListingToJson(List<AmazonProductsListing> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AmazonProductsListing {
    Position? position;
    String? asin;
    String? productTitle;
    Price? price;
    Reviews? reviews;
    String? url;
    int? score;
    bool? sponsored;
    bool? amazonChoice;
    bool? bestSeller;
    bool? amazonPrime;
    String? thumbnail;

    AmazonProductsListing({
        this.position,
        this.asin,
        this.productTitle,
        this.price,
        this.reviews,
        this.url,
        this.score,
        this.sponsored,
        this.amazonChoice,
        this.bestSeller,
        this.amazonPrime,
        this.thumbnail,
    });

    factory AmazonProductsListing.fromJson(Map<String, dynamic> json) => AmazonProductsListing(
        position: json["position"] == null ? null : Position.fromJson(json["position"]),
        asin: json["asin"],
        productTitle: json["productTitle"],
        price: json["price"] == null ? null : Price.fromJson(json["price"]),
        reviews: json["reviews"] == null ? null : Reviews.fromJson(json["reviews"]),
        url: json["url"],
        score: json["score"],
        sponsored: json["sponsored"],
        amazonChoice: json["amazonChoice"],
        bestSeller: json["bestSeller"],
        amazonPrime: json["amazonPrime"],
        thumbnail: json["thumbnail"],
    );

    Map<String, dynamic> toJson() => {
        "position": position?.toJson(),
        "asin": asin,
        "productTitle": productTitle,
        "price": price?.toJson(),
        "reviews": reviews?.toJson(),
        "url": url,
        "score": score,
        "sponsored": sponsored,
        "amazonChoice": amazonChoice,
        "bestSeller": bestSeller,
        "amazonPrime": amazonPrime,
        "thumbnail": thumbnail,
    };
}

class Position {
    int? page;
    int? position;
    int? globalPosition;

    Position({
        this.page,
        this.position,
        this.globalPosition,
    });

    factory Position.fromJson(Map<String, dynamic> json) => Position(
        page: json["page"],
        position: json["position"],
        globalPosition: json["global_position"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "position": position,
        "global_position": globalPosition,
    };
}

class Price {
    bool? discounted;
    double? currentPrice;
    Currency? currency;
    double? beforePrice;
    double? savingsAmount;
    double? savingsPercent;

    Price({
        this.discounted,
        this.currentPrice,
        this.currency,
        this.beforePrice,
        this.savingsAmount,
        this.savingsPercent,
    });

    factory Price.fromJson(Map<String, dynamic> json) => Price(
        discounted: json["discounted"],
        currentPrice: json["current_price"]?.toDouble(),
        currency: currencyValues.map[json["currency"]]!,
        beforePrice: json["before_price"]?.toDouble(),
        savingsAmount: json["savings_amount"]?.toDouble(),
        savingsPercent: json["savings_percent"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "discounted": discounted,
        "current_price": currentPrice,
        "currency": currencyValues.reverse[currency],
        "before_price": beforePrice,
        "savings_amount": savingsAmount,
        "savings_percent": savingsPercent,
    };
}

enum Currency {
    USD
}

final currencyValues = EnumValues({
    "USD": Currency.USD
});

class Reviews {
    int? totalReviews;
    double? rating;

    Reviews({
        this.totalReviews,
        this.rating,
    });

    factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
        totalReviews: json["total_reviews"],
        rating: json["rating"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "total_reviews": totalReviews,
        "rating": rating,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
