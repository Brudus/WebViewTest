//
//  NetworkService.swift
//  WebViewTest
//
//  Created by Manuel Schulze on 12.02.18.
//  Copyright © 2018 Manuel Schulze. All rights reserved.
//

import UIKit
import Alamofire

class NetworkService {
    static let shared = NetworkService()
    
    // Thread-safe
    private init() {}
    
    func getFile(path: String, completion: @escaping() -> Void) {
        let destination: DownloadRequest.DownloadFileDestination = {_, _ in
            let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

            let fileURL = documentURL.appendingPathComponent(path)
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        Alamofire.download("https://manuelschulze.com/" + path, to: destination)
            .responseData { response in
                if let error = response.result.error {
                    print("Error: \(error.localizedDescription)")
                }
                
               completion()
        }
    }
}
