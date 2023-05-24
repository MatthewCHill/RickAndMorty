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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CharacterListViewModel(delegate: self)
        characterListTableView.dataSource = self
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

extension CharacterListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as? CharacterTableViewCell else { return UITableViewCell()}
        
        let character = viewModel.characters[indexPath.row]
        cell.configure(with: character)
        
        return cell
    }
}

extension CharacterListViewController: CharacterListViewModelDelegate {
    func charactersFetchedSuccessfully() {
        DispatchQueue.main.async {
            self.characterListTableView.reloadData()
        }
    }
}
