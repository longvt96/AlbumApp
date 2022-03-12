//
//  AlbumViewController.swift
//  AlbumApp
//
//  Created by Longvu on 3/11/22.
//  Copyright © 2022 . All rights reserved.
//

final class AlbumViewController: UIViewController, Bindable {
    
    // MARK: - IBOutlets

    @IBOutlet weak var tableView: UITableView!

    private let backgroundImageView : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img_no_result")
        view.contentMode = .scaleAspectFit
        return view
    }()

    // MARK: - Properties
    
    var viewModel: AlbumViewModel!
    var disposeBag = DisposeBag()
    let searchController = UISearchController(searchResultsController: nil)

    private let searchKeywordTrigger = PublishSubject<String?>()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    deinit {
        logDeinit()
    }
    
    // MARK: - Methods

    private func configView() {
        title = "Album App"

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        searchController.do {
            $0.searchResultsUpdater = self
            $0.hidesNavigationBarDuringPresentation = false
            $0.searchBar.sizeToFit()
        }

        tableView.do {
            $0.register(cellType: AlbumCell.self)
            $0.rowHeight = UITableView.automaticDimension
            $0.estimatedRowHeight = 120
        }
    }

    func bindViewModel() {
        let input = AlbumViewModel.Input(
            loadTrigger: .just(()),
            searchKeywordTrigger: searchKeywordTrigger.asDriverOnErrorJustComplete(),
            selectedTrigger: tableView.rx.itemSelected.asDriver()
        )
        let output = viewModel.transform(input, disposeBag: disposeBag)

        output.$albums
            .asDriver()
            .unwrap()
            .drive(tableView.rx.items) { tableView, index, element in
                let cell = tableView.dequeueReusableCell(
                    for: IndexPath(row: index, section: 0),
                    cellType: AlbumCell.self)
                cell.configView(title: element.title)
                cell.selectionStyle = .none
                return cell
            }
            .disposed(by: disposeBag)

        output.$albums
            .asDriver()
            .unwrap()
            .map { $0.isEmpty }
            .drive(onNext: { [weak self] isEmpty in
                self?.tableView.backgroundView = isEmpty ? self?.backgroundImageView : nil
            })
            .disposed(by: disposeBag)

        output.$isLoading
            .asDriver()
            .drive(rx.isLoading)
            .disposed(by: disposeBag)

        output.$error
            .asDriver()
            .unwrap()
            .drive(rx.error)
            .disposed(by: disposeBag)
    }
}

// MARK: - Binders
extension AlbumViewController {

}

// MARK: - StoryboardSceneBased
extension AlbumViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.album
}

// MARK: - UISearchResultsUpdating

extension AlbumViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchKeywordTrigger.onNext(searchController.searchBar.text)
    }
}
