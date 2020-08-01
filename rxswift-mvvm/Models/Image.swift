/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation

struct Image: Codable {
	let id : Int?
	let pageURL : String?
	let type : String?
	let tags : String?
	let previewURL : String?
	let previewWidth : Int?
	let previewHeight : Int?
	let webformatURL : String?
	let webformatWidth : Int?
	let webformatHeight : Int?
	let largeImageURL : String?
	let imageWidth : Int?
	let imageHeight : Int?
	let imageSize : Int?
	let views : Int?
	let downloads : Int?
	let favorites : Int?
	let likes : Int?
	let comments : Int?
	let user_id : Int?
	let user : String?
	let userImageURL : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case pageURL = "pageURL"
		case type = "type"
		case tags = "tags"
		case previewURL = "previewURL"
		case previewWidth = "previewWidth"
		case previewHeight = "previewHeight"
		case webformatURL = "webformatURL"
		case webformatWidth = "webformatWidth"
		case webformatHeight = "webformatHeight"
		case largeImageURL = "largeImageURL"
		case imageWidth = "imageWidth"
		case imageHeight = "imageHeight"
		case imageSize = "imageSize"
		case views = "views"
		case downloads = "downloads"
		case favorites = "favorites"
		case likes = "likes"
		case comments = "comments"
		case user_id = "user_id"
		case user = "user"
		case userImageURL = "userImageURL"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		pageURL = try values.decodeIfPresent(String.self, forKey: .pageURL)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		tags = try values.decodeIfPresent(String.self, forKey: .tags)
		previewURL = try values.decodeIfPresent(String.self, forKey: .previewURL)
		previewWidth = try values.decodeIfPresent(Int.self, forKey: .previewWidth)
		previewHeight = try values.decodeIfPresent(Int.self, forKey: .previewHeight)
		webformatURL = try values.decodeIfPresent(String.self, forKey: .webformatURL)
		webformatWidth = try values.decodeIfPresent(Int.self, forKey: .webformatWidth)
		webformatHeight = try values.decodeIfPresent(Int.self, forKey: .webformatHeight)
		largeImageURL = try values.decodeIfPresent(String.self, forKey: .largeImageURL)
		imageWidth = try values.decodeIfPresent(Int.self, forKey: .imageWidth)
		imageHeight = try values.decodeIfPresent(Int.self, forKey: .imageHeight)
		imageSize = try values.decodeIfPresent(Int.self, forKey: .imageSize)
		views = try values.decodeIfPresent(Int.self, forKey: .views)
		downloads = try values.decodeIfPresent(Int.self, forKey: .downloads)
		favorites = try values.decodeIfPresent(Int.self, forKey: .favorites)
		likes = try values.decodeIfPresent(Int.self, forKey: .likes)
		comments = try values.decodeIfPresent(Int.self, forKey: .comments)
		user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
		user = try values.decodeIfPresent(String.self, forKey: .user)
		userImageURL = try values.decodeIfPresent(String.self, forKey: .userImageURL)
	}

}
