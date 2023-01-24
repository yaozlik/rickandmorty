import Foundation

struct CharactersResponse: Codable {
    var info: InfoModel
    var characters: [CharacterModel]
    
    enum CodingKeys: String, CodingKey {
        case info = "info"
        case characters = "results"
    }
}

struct CharacterModel: Codable, Identifiable {
    
    var id: Int
    var name: String?
    var status: String?
    var species: String?
    var gender: String?
    var image: String?
    var episode: [String]
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case status = "status"
        case species = "species"
        case gender = "gender"
        case image = "image"
        case episode = "episode"
        case url = "url"
    }
}

struct InfoModel: Codable {
    var count: Int
    var pages: Int
    var next: String?

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case pages = "pages"
        case next = "next"
    }
}
