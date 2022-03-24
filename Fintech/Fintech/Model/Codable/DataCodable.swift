//
//  DataCodable.swift
//  Fintech
//
//  Created by User on 2022/3/19.
//

import Foundation

struct DataCodable : Codable {

    let data : [Data]?

    init(from decoder: Decoder) throws {
        let values = try decoder.singleValueContainer()
        data = try values.decode([Data].self)
    }

    
    struct Data : Codable {
        
        let description : String?
        let copyright : String?
        let title : String?
        let url : String?
        let apod_site : String?
        let date : String?
        let media_type : String?
        let hdurl : String?

        enum CodingKeys: String, CodingKey {
            case description = "description"
            case copyright = "copyright"
            case title = "title"
            case url = "url"
            case apod_site = "apod_site"
            case date = "date"
            case media_type = "media_type"
            case hdurl = "hdurl"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            description = try values.decodeIfPresent(String.self, forKey: .description)
            copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
            title = try values.decodeIfPresent(String.self, forKey: .title)
            url = try values.decodeIfPresent(String.self, forKey: .url)
            apod_site = try values.decodeIfPresent(String.self, forKey: .apod_site)
            date = try values.decodeIfPresent(String.self, forKey: .date)
            media_type = try values.decodeIfPresent(String.self, forKey: .media_type)
            hdurl = try values.decodeIfPresent(String.self, forKey: .hdurl)
        }

    }
    
}
