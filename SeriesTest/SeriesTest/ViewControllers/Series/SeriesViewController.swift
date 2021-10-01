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
  
  private let imageLoaderService = ImageLoaderService()
  private var subscriptions = Set<AnyCancellable>()
  private let searchController = UISearchController(searchResultsController: nil)
  private let viewModel = SeriesViewModel()
  
  private var isFiltering: Bool {
    let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
    return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
  }
  
  var isSearchBarEmpty: Bool {
    searchController.searchBar.text?.isEmpty ?? true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupSearchController()
    setupTableView()
    
    viewModel.fetchPopularSeries() { [weak self] in
      self?.tableView.reloadData()
    }
  }
}

// MARK: - UITableViewDataSource
extension SeriesViewController: UITableViewDataSource {
  
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    isFiltering
    ? viewModel.filteredSeries.count
    : viewModel.series.count
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell: SeriesTableViewCell = tableView.dequeueReusableCell(for: indexPath)
    
    var serie = isFiltering
    ? viewModel.filteredSeries[indexPath.row]
    : viewModel.series[indexPath.row]
      
    cell.setup(with: serie)
    
    if let posterImage = serie.posterImage {
      cell.set(image: posterImage)
    } else if let posterPath = serie.posterPath,
                let posterUrl = URL(string: "https://image.tmdb.org/t/p/original" + posterPath) {
      imageLoaderService.loadImage(from: posterUrl)
       .receive(on: RunLoop.main)
       .sink { [weak self] image in
         self?.viewModel.series[indexPath.row].posterImage = image
         cell.set(image: image)
       }
       .store(in: &subscriptions)
    }
    
    return cell
  }
}

// MARK: - UITableViewDataSource
extension SeriesViewController: UITableViewDelegate {
  
  func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    let serie = isFiltering
    ? viewModel.filteredSeries[indexPath.row]
    : viewModel.series[indexPath.row]
    
    let detailsVC: SeriesDetailsViewController = UIStoryboard
      .storyboard(storyboard: .main)
      .instantiateViewController()
    detailsVC.viewModel = SeriesDetailsViewModel(serie: serie)
    
    navigationController?.pushViewController(detailsVC, animated: true)
  }
}

// MARK: - UITableViewDataSourcePrefetching
extension SeriesViewController: UITableViewDataSourcePrefetching {
  
  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    if indexPaths.contains(where: isLoadingCell) {
      viewModel.fetchPopularSeries() {
        tableView.reloadData()
      }
    }
  }
  
  func isLoadingCell(for indexPath: IndexPath) -> Bool {
    if isFiltering {
      return indexPath.row >= viewModel.filteredSeries.count - 1
    } else {
      return indexPath.row >= viewModel.series.count - 1
    }
  }
}

// MARK: - UISearchResultsUpdating
extension SeriesViewController: UISearchResultsUpdating {
  
  func updateSearchResults(for searchController: UISearchController) {
    viewModel.filterContentForSearchText(searchController.searchBar.text!) {
      tableView.reloadData()
    }
  }
}

// MARK: - UISearchBarDelegate
extension SeriesViewController: UISearchBarDelegate {
  
  func searchBar(
    _ searchBar: UISearchBar,
    selectedScopeButtonIndexDidChange selectedScope: Int
  ) {
    viewModel.filterContentForSearchText(searchBar.text!) {
      tableView.reloadData()
    }
  }
}

// MARK: - Private
private extension SeriesViewController {
  
  func setupSearchController() {
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search Series"
    navigationItem.searchController = searchController
    definesPresentationContext = true
    searchController.searchBar.delegate = self
  }
  
  func setupTableView() {
    tableView.prefetchDataSource = self
  }
}
