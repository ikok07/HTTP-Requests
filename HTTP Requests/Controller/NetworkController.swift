//
//  NetworkController.swift
//  HTTP Requests
//
//  Created by Kaloyan Petkov on 18.07.23.
//

import Foundation

class NetworkController: ObservableObject {
    
    @Published var responseData: String = "Response text"
    
    let defaultUrl = URL(string: "https://dummyjson.com/products/1")!
    let postUrl = URL(string: "https://dummyjson.com/products/add")!
    let putURL = URL(string: "https://dummyjson.com/products/1")!
    
    
    func getPostBody(title: String, price: Double) -> [String: Any]{
        return ["title": title, "price": price]
    }
    
    func performRequest(type: String, body: [String: Any]?, productID: Int? = nil) {
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: defaultUrl)
        
        if type == "POST" {
            request = URLRequest(url: postUrl)
        } else if type == "PUT" {
            request = URLRequest(url: putURL)
        } else if type == "DELETE" {
            if let safeID = productID {
                let deleteUrl = URL(string: "https://dummyjson.com/products/\(safeID)")!
                request = URLRequest(url: deleteUrl)
            }
        }
        
        if let bodyData = body {
            let transformedBody = try? JSONSerialization.data(withJSONObject: bodyData)
            request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "content-type")
            request.httpBody = transformedBody
            request.httpMethod = type
        }
        
        resumeTask(session: session, request: request)
    }
    
    private func resumeTask(session: URLSession, request: URLRequest) {
        
        let task = session.dataTask(with: request) { [self] data, response, error in
            if error != nil {
                print(error!)
            } else if let safeData = data {
                self.parseJSON(newData: safeData)
            } else {
                print("Response: \(response!)")
            }
        }
        task.resume()

    }
    
    private func parseJSON(newData: Data){
        let decoder = JSONDecoder()
        var decodedData: DecodedData?
        do {
            decodedData = try decoder.decode(DecodedData.self, from: newData)
        } catch {
            print("Failed decoding data: \(error)")
        }

        if let safeData = decodedData {
            
            DispatchQueue.main.async {
                self.responseData = "id: \(safeData.id), title: \(safeData.title), price: \(safeData.price)"
            }
        }
    }
}
