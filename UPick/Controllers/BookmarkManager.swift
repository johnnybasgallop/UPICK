//
//  BookmarkManager.swift
//  UPick
//
//  Created by johnny basgallop on 13/11/2023.
//

import Foundation

class MovieManager: ObservableObject {
    @Published var bookmarkedMovies: [Movie] = []

    init() {
       bookmarkedMovies = loadBookmarkedMovies()
    }

    private func saveBookmarkedMovies() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(bookmarkedMovies) {
            UserDefaults.standard.set(encoded, forKey: "bookmarkedMovies")
        }
    }

    private func loadBookmarkedMovies() -> [Movie] {
        if let data = UserDefaults.standard.data(forKey: "bookmarkedMovies") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Movie].self, from: data) {
                return decoded
            }
        }
        return []
    }

    func toggleBookmark(movie: Movie) {
        if let index = bookmarkedMovies.firstIndex(where: { $0.id == movie.id }) {
            bookmarkedMovies.remove(at: index)
        } else {
            bookmarkedMovies.append(movie)
        }
    }
}
