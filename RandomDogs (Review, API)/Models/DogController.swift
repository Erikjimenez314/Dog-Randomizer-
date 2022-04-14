//
//  DogController.swift
//  RandomDogs (Review, API)
//
//  Created by Erik Jimenez on 2/17/22.
//

import Foundation
import UIKit

public class TopLevelObjectController {
    
    
    // shared instance, cache
    
    static let shared = TopLevelObjectController()

    
    static let cache = NSCache<NSString, UIImage>()
    
    // Mind this error, important. You need to declare, your model array (obv going to be an array if you're going through an api of dogs here in this case, you need to put that object as an array in the fetch function in order to declare it as an array when decoding the data. 
    
    // Construct URL
    static func fetchDogs(completion: @escaping  (Result<TopLevelObject, UserError>) -> Void) {
        
        let baseURL = URL(string: "https://dog.ceo/api/breeds/image/random")
        
        guard let finalURL = baseURL else {return completion(.failure(.invalidURL)) }
        
        print(finalURL)
        
        // Network Call
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                return (completion(.failure(.thrownError(error)))) }
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    print("Post Status Code \(response.statusCode)")
                }
            }
            guard let data = data else {
                return completion(.failure(.noData))}
            
            // Decode Json Data
            
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
               
        
                completion(.success(topLevelObject))
            } catch {
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    // Fetch Image (Message)
    
    static func fetchMessage (messageURL: String, completion: @escaping (Result<UIImage, UserError>) -> Void) {
        
        let cacheKey = NSString(string: messageURL)
        
        if let image = cache.object(forKey: cacheKey) {
            return completion(.success(image))
        }
        guard let finalURL = URL(string: messageURL) else {
            return completion(.failure(.invalidURL))
        }
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else {return (completion(.failure(.noData))) }
            guard let message = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
            self.cache.setObject(message, forKey: NSString(string: messageURL))
            completion(.success(message))
        }.resume()
        
    }
    
}


// For this project the main problem in the beggining was that I was used to making network calls with arrays, and array of things to be fetched but for this project it was just a single instance, of dog. then (what i figured out later) was that in order to randomize it again i would need to call the function again inside any button i would set as the randomizer, in this case refresh. But i managed to work this projct out by using logic to set code as not array and fixing this where ever need be, cross referencing code and making sure everything matched. yes you can do it, yes.

        
