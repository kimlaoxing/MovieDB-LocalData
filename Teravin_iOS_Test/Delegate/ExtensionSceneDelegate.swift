import Foundation
import UIKit

extension SceneDelegate {
    func willConnectTo(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        let tabs = [ makeHomeTab() ]
        let home = TabBar(vc: tabs)
        home.selectedIndex = 0
        self.window?.rootViewController = home
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene

    }
    
    public func makeHomeTab() -> UIViewController {
        let vc = ListPopularMovieViewController()
        let vm = DefaultListPopularMovieViewModel()
        vc.viewModel = vm
        vc.navigationItem.backButtonTitle = ""
        
        let navigation = UINavigationController(rootViewController: vc)
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .white
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigation.navigationBar.standardAppearance = navBarAppearance
        navigation.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigation.navigationBar.tintColor = .white
        navigation.tabBarItem.title = "Genre"
        navigation.tabBarItem.image = UIImage(systemName: "list.bullet")
        navigation.navigationBar.prefersLargeTitles = false
        navigation.navigationBar.barStyle = .default
        navigation.navigationBar.backgroundColor = .gray
        return navigation
    }
}
