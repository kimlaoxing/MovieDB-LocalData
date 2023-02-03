import Foundation

protocol PopularMovieDomain {
    mutating func fetchListPopularMovie(with page: Int, completion: @escaping ([MovieListLocalModel]) -> Void)
}

final class PopularMovieUseCase: PopularMovieDomain {
    
    private var repository: PopularMovieRepository

    init() {
        self.repository = PopularMovieRepositoryData()
    }
    
    func fetchListPopularMovie(with page: Int, completion: @escaping ([MovieListLocalModel]) -> Void) {
        self.repository.fetchListPopularMovie(with: page) { data in
            completion(data)
        }
    }
}
