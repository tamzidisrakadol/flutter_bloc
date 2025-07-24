class Movie {
  int? totalResults;
  int? page;
  int? totalPages;
  List<Results>? results;

  Movie({this.totalResults, this.page, this.totalPages, this.results});

  Movie.fromJson(Map<String, dynamic> json) {
    totalResults = json['totalResults'];
    page = json['page'];
    totalPages = json['totalPages'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalResults'] = this.totalResults;
    data['page'] = this.page;
    data['totalPages'] = this.totalPages;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? mediaType;
  String? title;
  String? originalTitle;
  String? posterPath;
  String? backdropPath;
  String? releaseDate;
  List<String>? genres;
  int? voteAverage;
  String? id;
  String? contentId;
  String? overview;

  Results(
      {this.mediaType,
        this.title,
        this.originalTitle,
        this.posterPath,
        this.backdropPath,
        this.releaseDate,
        this.genres,
        this.voteAverage,
        this.id,
        this.contentId,
        this.overview});

  Results.fromJson(Map<String, dynamic> json) {
    mediaType = json['mediaType'];
    title = json['title'];
    originalTitle = json['originalTitle'];
    posterPath = json['posterPath'];
    backdropPath = json['backdropPath'];
    releaseDate = json['releaseDate'];
    genres = json['genres'].cast<String>();
    voteAverage = json['voteAverage'];
    id = json['id'];
    contentId = json['contentId'];
    overview = json['overview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mediaType'] = this.mediaType;
    data['title'] = this.title;
    data['originalTitle'] = this.originalTitle;
    data['posterPath'] = this.posterPath;
    data['backdropPath'] = this.backdropPath;
    data['releaseDate'] = this.releaseDate;
    data['genres'] = this.genres;
    data['voteAverage'] = this.voteAverage;
    data['id'] = this.id;
    data['contentId'] = this.contentId;
    data['overview'] = this.overview;
    return data;
  }
}
