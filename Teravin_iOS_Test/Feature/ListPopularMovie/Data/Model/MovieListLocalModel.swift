import RealmSwift

class MovieListLocalModel: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String = ""
    @Persisted var poster_path: String = ""
    @Persisted var release_date: String
    @Persisted var popularity: Double
    
    convenience init(
        title: String,
        poster_path: String,
        release_date: String,
        popularity: Double
    ) {
        self.init()
        self.title = title
        self.poster_path = poster_path
        self.release_date = release_date
        self.popularity = popularity
    }
}
