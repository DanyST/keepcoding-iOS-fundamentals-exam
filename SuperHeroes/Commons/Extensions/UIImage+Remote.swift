//
//  UIImage+Remote.swift
//  SuperHeroes
//
//  Created by Luis Herrera Lillo on 30-09-23.
//

import UIKit

extension UIImageView {
    func setImage(for url: URL) {
        downloadImage(url: url) { [weak self] result in
            guard case let .success(image) = result else {
                return
            }
            self?.image = image
        }
    }
    
    private func downloadImage(
        url: URL,
        completion: @escaping (Result<UIImage, Error>) -> Void
    ) {
        let task = URLSession.shared.dataTask(with: url) { data, response, _ in
            let result: Result<UIImage, Error>
            
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            guard let data, let image = UIImage(data: data) else {
                result = .failure(NSError(domain: "No Image", code: -1))
                return
            }
            
            result = .success(image)
        }
        
        task.resume()
    }
}
