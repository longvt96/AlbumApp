//
//  PhotoDetailViewController.swift
//  AlbumApp
//
//  Created by Longvu on 3/11/22.
//  Copyright © 2022 . All rights reserved.
//

final class PhotoDetailViewController: UIViewController, Bindable {
    
    // MARK: - IBOutlets
    
    var collectionView: UICollectionView!

    // MARK: - Properties
    
    var viewModel: PhotoDetailViewModel!
    var disposeBag = DisposeBag()

    // MARK: - Config Collection

    enum Section {
      case albumBody
    }

    var dataSource: UICollectionViewDiffableDataSource<Section, Photo>! = nil

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
        title = "Album detail"

        configureCollectionView()
        configureDataSource()

    }

    func bindViewModel() {
        let input = PhotoDetailViewModel.Input(
            loadTrigger: .just(())
        )
        let output = viewModel.transform(input, disposeBag: disposeBag)

        output.$photos
            .asDriver()
            .drive(onNext: { [weak self] photos in
                guard let self = self else {
                    return
                }
                let snapshot = self.snapshotForCurrentState(photos: photos ?? [])
                self.dataSource.apply(snapshot, animatingDifferences: false)
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
extension PhotoDetailViewController {

}

// MARK: - StoryboardSceneBased
extension PhotoDetailViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.album
}

// MARK: - Config Collection

extension PhotoDetailViewController {
    func configureCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        collectionView.contentInset = UIEdgeInsets(top: 8.0, left: 0, bottom: 0, right: 0)
        collectionView.backgroundColor = .white
        collectionView.register(cellType: PhotoCell.self)
        collectionView.showsVerticalScrollIndicator = false
        self.collectionView = collectionView
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource
        <Section, Photo>(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, photo: Photo)
            -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: PhotoCell.self)
            cell.configView(imageURL: photo.thumbnailURL)
            return cell
        }
    }
    
    func generateLayout() -> UICollectionViewLayout {
        // Full
        let fullPhotoItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(2 / 3),
                heightDimension: .fractionalWidth(2 / 3)),
            supplementaryItems: [])
        fullPhotoItem.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)

        let pairItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)))
        pairItem.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        let trailingGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1 / 3),
                heightDimension: .fractionalHeight(1.0)),
            subitem: pairItem,
            count: 2)

        let fullWithTrailingGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(2 / 3)),
            subitems: [fullPhotoItem, trailingGroup])
        
        let mainItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(2 / 3),
                heightDimension: .fractionalWidth(1 / 3)))
        mainItem.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)

        let smallItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1 / 3),
                heightDimension: .fractionalWidth(1 / 3)))
        smallItem.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let mainWithSmallGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(1 / 3)),
            subitems: [mainItem, smallItem])
        
        let trailingWithFullGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(2 / 3)),
            subitems: [trailingGroup, fullPhotoItem])
        
        let smallWithMainGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(1 / 3)),
            subitems: [smallItem, mainItem])
        
        fullPhotoItem.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)

        let subItems: [NSCollectionLayoutItem] = [fullWithTrailingGroup, mainWithSmallGroup,
                                                  trailingWithFullGroup, smallWithMainGroup]
        let nestedGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(2.0)),
            subitems: subItems)
        
        let section = NSCollectionLayoutSection(group: nestedGroup)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    func snapshotForCurrentState(photos: [Photo]) -> NSDiffableDataSourceSnapshot<Section, Photo> {
      var snapshot = NSDiffableDataSourceSnapshot<Section, Photo>()
      snapshot.appendSections([Section.albumBody])
        let items = photos
        snapshot.appendItems(items)
        return snapshot
    }
}
