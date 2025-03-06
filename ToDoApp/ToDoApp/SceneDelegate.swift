import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Создаем окно
        window = UIWindow(windowScene: windowScene)

        // Создаем TaskListViewController
        let taskListVC = TaskListViewController()

        // Создаем UINavigationController с TaskListViewController в качестве корневого контроллера
        let navigationController = UINavigationController(rootViewController: taskListVC)

        // Настраиваем окно
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        // Настраиваем зависимости для TaskListViewController
        setupTaskListModule(with: taskListVC)
    }

    private func setupTaskListModule(with view: TaskListViewController) {
        let presenter = TaskListPresenter()
        let interactor = TaskListInteractor()
        let router = TaskListRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.view = view
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}
