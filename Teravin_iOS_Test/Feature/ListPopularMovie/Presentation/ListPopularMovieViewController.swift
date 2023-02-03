import Declayout

final class ListPopularMovieViewController: UIViewController {
    
    var data: [MovieListLocalModel]?
    var viewModel: ListPopularMovieViewModel?
    private let refreshControl = UIRefreshControl()
    private var timer: Timer?
    private var count = 60
    
    private lazy var container = UIStackView.make {
        $0.backgroundColor = .white
        $0.axis = .vertical
        $0.edges(to: view)
    }
    
    private lazy var tableView = UITableView.make {
        $0.delegate = self
        $0.dataSource = self
        $0.register(PopularMovieTableViewCell.self, forCellReuseIdentifier: "PopularMovieTableViewCell")
        $0.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List Popular Movie"
        subViews()
        bind()
        refresh()
        viewModel?.getPopular()
        startTimer()
        
    }
    
    private func startTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    private func refresh() {
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = refreshControl
        } else {
            self.tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    private func bind() {
        viewModel?.listPopularMovie.observe(on: self) { [weak self] data in
            guard let self = self else { return }
            self.data = data
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
        
        viewModel?.state.observe(on: self) { [weak self] state in
            guard let self = self else { return }
            self.handleState(with: state)
        }
    }
    
    private func subViews() {
        view.addSubviews([
            container.addArrangedSubviews([
                tableView
            ])
        ])
    }
    
    private func handleState(with state: BaseViewState) {
        switch state {
        case .loading:
            self.manageLoadingActivity(isLoading: true)
        case .normal:
            self.manageLoadingActivity(isLoading: false)
        case .empty:
            self.manageLoadingActivity(isLoading: false)
        case .noInternet:
            self.noInternet()
            self.manageLoadingActivity(isLoading: false)
        }
    }
    
    @objc private func refreshData() {
        self.viewModel?.refreshPage()
    }
    
    @objc func updateCounter() {
        if count > 0 {
            count -= 1
        } else {
            self.count += 60
            self.viewModel?.getPopular()
            view.makeToast("Penyimpanan Local Telah Diperbarui")
        }
    }
}

extension ListPopularMovieViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopularMovieTableViewCell",
                                                 for: indexPath) as! PopularMovieTableViewCell
        if let data = self.data {
            cell.setContent(with: data[indexPath.row])
        }
        return cell
    }
}

