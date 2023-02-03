import Foundation

protocol ListPopularMovieViewModelOutput {
    func getPopular()
    func refreshPage()
}

protocol ListPopularMovieViewModelInput {
    var listPopularMovie: Observable<[MovieListLocalModel]> { get }
    var state: Observable<BaseViewState> { get }
}

protocol ListPopularMovieViewModel: ListPopularMovieViewModelInput, ListPopularMovieViewModelOutput { }

final class DefaultListPopularMovieViewModel: ListPopularMovieViewModel {
    
    let listPopularMovie: Observable<[MovieListLocalModel]> = Observable([])
    let state: Observable<BaseViewState> = Observable(.loading)
    
    private let useCase = PopularMovieUseCase()
    
    func refreshPage() {
        self.getPopular()
    }
}

extension DefaultListPopularMovieViewModel {
    func getPopular() {
        self.state.value = .loading
        self.useCase.fetchListPopularMovie(with: 1) { data in
            guard Reachability().isConnectedToNetwork else {
                self.state.value = .noInternet
                return
            }
            
            if data.isEmpty {
                self.state.value = .empty
            }
            
            self.state.value = .normal
            self.listPopularMovie.value = data
        }
    }
}
