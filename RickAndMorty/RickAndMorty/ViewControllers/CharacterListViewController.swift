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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        characterListTableView.dataSource = self
        fetchCharacterList()
    }
    
    // MARK: - Properties
    var topLevelCharacterDict: TopLevelCharacterDict?
    var characters: [Character] = []
    
    
    // MARK: - Functions
    
    func fetchCharacterList() {
        
        NetworkService.fetchCharacterList { [weak self] result in
            switch result {
                
            case .success(let topLevel):
                self?.topLevelCharacterDict = topLevel
                self?.characters.append(contentsOf: topLevel.results)
                DispatchQueue.main.async {
                    self?.characterListTableView.reloadData()
                }
            case .failure(let error):
                print(error.errorDescription ?? "Unknown Error")
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Extensions

extension CharacterListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as? CharacterTableViewCell else { return UITableViewCell()}
        
        let character = characters[indexPath.row]
        cell.fetchCharacterImage(forCharacter: character)
        
        return cell
    }
    
    
}
