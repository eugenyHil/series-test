//
//  ViewController.swift
//  SeriesTest
//
//  Created by anduser on 29.09.21.
//

import UIKit
import Combine

final class SeriesViewController: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView!
  
  private let searchController = UISearchController(searchResultsController: nil)
  private var subscriptions = Set<AnyCancellable>()
  
  private var isFiltering: Bool {
    let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
    return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
  }
  
  private var isSearchBarEmpty: Bool {
    searchController.searchBar.text?.isEmpty ?? true
  }
  
  private let viewModel = SeriesViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupControls()
    setupObservers()
    
    viewModel.fetchPopularSeries()
  }
}

// MARK: - UITableViewDataSource
extension SeriesViewController: UITableViewDataSource {
  
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    viewModel.seriesCount(isFiltering: isFiltering)
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell: SeriesTableViewCell = tableView.dequeueReusableCell(for: indexPath)
    
    let serie = viewModel.serie(
      at: indexPath.row,
      isFiltering: isFiltering)
      
    cell.setup(with: serie)
    
    return cell
  }
}

// MARK: - UITableViewDelegate
extension SeriesViewController: UITableViewDelegate {
  
  func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    let serie = viewModel.serie(
      at: indexPath.row,
      isFiltering: isFiltering)
    
    let detailsVC: SeriesDetailsViewController = UIStoryboard
      .storyboard(storyboard: .main)
      .instantiateViewController()
    detailsVC.viewModel = SeriesDetailsViewModel(serie: serie)
    
    navigationController?.pushViewController(detailsVC, animated: true)
  }
}

// MARK: - UITableViewDataSourcePrefetching
extension SeriesViewController: UITableViewDataSourcePrefetching {
  
  func tableView(
    _ tableView: UITableView,
    prefetchRowsAt indexPaths: [IndexPath]
  ) {
    viewModel.fetchNextPageIfNeeded(
      indexes: indexPaths.map { $0.row },
      isFiltering: isFiltering)
  }
}

// MARK: - UISearchResultsUpdating
extension SeriesViewController: UISearchResultsUpdating {
  
  func updateSearchResults(for searchController: UISearchController) {
    viewModel.filterContent(for: searchController.searchBar.text!)
  }
}

// MARK: - UISearchBarDelegate
extension SeriesViewController: UISearchBarDelegate {
  
  func searchBar(
    _ searchBar: UISearchBar,
    selectedScopeButtonIndexDidChange selectedScope: Int
  ) {
    viewModel.filterContent(for: searchBar.text!)
  }
}

// MARK: - Observers
private extension SeriesViewController {
  
  func setupObservers() {
    setupOutputObserver()
  }
  
  func setupOutputObserver() {
    viewModel.output.sink { [weak self] in
      switch $0 {
      case .refreshTable:
        self?.tableView.reloadData()
      }
    }
    .store(in: &subscriptions)
  }
}

// MARK: - Private
private extension SeriesViewController {
  
  func setupControls() {
    setupSearchController()
  }
  
  func setupSearchController() {
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search Series"
    navigationItem.searchController = searchController
    definesPresentationContext = true
    searchController.searchBar.delegate = self
  }
}
