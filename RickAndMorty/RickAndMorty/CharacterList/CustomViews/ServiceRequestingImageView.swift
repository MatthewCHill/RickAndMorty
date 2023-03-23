//
//  ServiceRequestingImageView.swift
//  RickAndMorty
//
//  Created by Matthew Hill on 3/23/23.
//

import UIKit

class ServiceRequestingImageView: UIImageView {

    func fetchImage(using url: URL) {
        let service = APIService()
        let request = URLRequest(url: url)
        service.perform(request) { result in
            switch result {
                
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    self.setDefaultImage()
                    return
                }
                DispatchQueue.main.async {
                    self.image = image
                }
            case .failure(let error):
                print(error.errorDescription)
                self.setDefaultImage()
            }
        }
    }

    func setDefaultImage() {
        self.image = UIImage(systemName: "ifNoPhoto")
    }
}
