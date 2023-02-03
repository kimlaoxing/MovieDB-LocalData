import Foundation

protocol PopularMovieRepository {
    func fetchListPopularMovie(with page: Int, completion: @escaping ([MovieListLocalModel]) -> Void)
}

final class PopularMovieRepositoryData: PopularMovieRepository {
    
    private var remoteData: PopularMovieRemoteData
    private var localData: PopularMovieLocalData
    
    init(
        remoteData: PopularMovieRemoteData = PopularMovieRemoteData(),
        localData: PopularMovieLocalData = PopularMovieLocalData()
    ) {
        self.remoteData = remoteData
        self.localData = localData
    }
    
    func fetchListPopularMovie(with page: Int, completion: @escaping ([MovieListLocalModel]) -> Void) {
        self.remoteData.fetchListPopularMovie(with: page) { data in
            var array = [MovieListLocalModel]()
            for i in data {
                array.append((MovieListLocalModel(title: i.title.orEmpty,
                                                  poster_path: i.poster_path.orEmpty,
                                                  release_date: i.release_date.orEmpty,
                                                  popularity: i.popularity ?? 0)))
            }
            DispatchQueue.main.async {
                self.localData.deleteData()
                self.localData.saveData(array)
                let result = self.localData.retriveData()
                completion(result)
            }
        }
    }
}
