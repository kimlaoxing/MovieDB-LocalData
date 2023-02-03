import Alamofire

protocol PopularMovieRemote {
    mutating func fetchListPopularMovie(with page: Int, completion: @escaping ([MovieListResponse.Result]) -> Void)
}

struct PopularMovieRemoteData: PopularMovieRemote {
    mutating func fetchListPopularMovie(with page: Int, completion: @escaping ([MovieListResponse.Result]) -> Void) {
        let endpoint = "\(APIService.basePath)\(APIService.discover)"
        let params = [ "page" : "\(page)",
                       "api_key" : "\(APIService.apiKey)"
        ]
        print(endpoint)
        AF.request(
            endpoint,
            method: .get,
            parameters: params,
            encoding: URLEncoding.queryString
        )
            .validate(statusCode: 200..<300)
            .responseDecodable(of: MovieListResponse.self) { data in
                switch data.result {
                case .success(let data):
                    if let result = data.results {
                        completion(result)
                    }
                case .failure(_):
                    break
                }
            }
    }
}
