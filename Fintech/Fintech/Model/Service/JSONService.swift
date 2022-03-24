//
//  JSONService.swift
//  Fintech
//
//  Created by User on 2022/3/20.
//

import Foundation


class JSONService: NSObject {
    
    func fetchNASAData(url:String, complete: @escaping ( _ success: Bool, _ NASAData: [DataCodable.Data], _ error: Error? )->() ){
        HttpManager.shared.loadJson(fromURLString: url)
        { result in
            
            switch result {
            case .success(let data):

                        let decoder = JSONDecoder()
                        let baseModel = try? decoder.decode(DataCodable.self, from: data)

                complete( true, (baseModel?.data)!, nil )

                break
                
            case .failure(let error):
                print(error)
                complete( false, [DataCodable.Data]() , error )

                break
            }
        }
    }
}
