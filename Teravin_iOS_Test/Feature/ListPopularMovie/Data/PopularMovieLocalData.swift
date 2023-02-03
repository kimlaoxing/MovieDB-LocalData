import Foundation
import RealmSwift

protocol PopularMovieLocal {
    func saveData(_ objects: [MovieListLocalModel])
    func retriveData() -> [MovieListLocalModel]
    func deleteData()
}

public class PopularMovieLocalData: PopularMovieLocal {
    let realm = try! Realm()
    
    func saveData(_ objects: [MovieListLocalModel]) {
        try! realm.write {
            realm.add(objects)
        }
    }
    
    func retriveData() -> [MovieListLocalModel] {
        var result = [MovieListLocalModel]()
        let local = realm.objects(MovieListLocalModel.self)
        for i in local {
            result.append((MovieListLocalModel(title: i.title,
                                              poster_path: i.poster_path,
                                              release_date: i.release_date,
                                               popularity: i.popularity )))
        }
        return result
    }
    
    func deleteData() {
        try! realm.write {
            let data = realm.objects(MovieListLocalModel.self)
            realm.delete(data)
        }
    }
}
