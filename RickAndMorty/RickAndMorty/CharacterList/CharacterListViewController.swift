//
//  CharacterListViewController.swift
//  RickAndMorty
//
//  Created by Matthew Hill on 3/7/23.
//

import UIKit

class CharacterListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var characterListTableView: UITableView!
    
    // MARK: - Properties
    var viewModel: CharacterListViewModel!
    let activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CharacterListViewModel(delegate: self)
        characterListTableView.dataSource = self
        characterListTableView.delegate = self
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCharacterDetail" {
            if let indexPath = characterListTableView.indexPathForSelectedRow {
                guard let destinationVC = segue.destination as? CharacterDetailViewController,
                      let cell = sender as? CharacterTableViewCell else { return }
                
                let image = cell.characterImageView.image
                let character = viewModel.characters[indexPath.row]
                
                destinationVC.updateView(character: character, image: image)
            }
        }
    }
}

// MARK: - Extensions

extension CharacterListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as? CharacterTableViewCell else { return UITableViewCell()}
        
        let character = viewModel.characters[indexPath.row]
        cell.configure(with: character)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let topLevelDict = viewModel.topLevelDict,
        let nextURL = URL(string: topLevelDict.info.next) else { return }
        characterListTableView.tableFooterView = activityIndicator
        let endOfCharacterList = viewModel.characters.count - 2
        if indexPath.row == endOfCharacterList {
            viewModel.fetchNextCharacters(with: nextURL)
        }
    }
}

extension CharacterListViewController: CharacterListViewModelDelegate {
    func charactersFetchedSuccessfully() {
        DispatchQueue.main.async {
            self.characterListTableView.reloadData()
        }
    }
}
