//
//  SongController.swift
//  Playlist
//
//  Created by Daniel Villedrouin on 1/11/21.
//

import Foundation

class SongController {
    
    // Shared Instance
    static let shared = SongController()
    
    // Source Of Truth (S.O.T)
    var songs: [Song] = []
    
    
    // CRUD Methods
    // Create
    func createSong(newSongTitle: String, newSongArtist: String) {
        let newSong = Song(title: newSongTitle, artist: newSongArtist)
        songs.append(newSong)
        saveToPersistenceStore()
    }
    
    // TODO: - Update
    
    // Delete
    func  deleteSong(songToDelete: Song) {
        guard let index = songs.firstIndex(of: songToDelete) else { return }
        songs.remove(at: index)
        saveToPersistenceStore()
    }
    //MARK: - Persistence
    
    // fileURL
    func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Playlist.json")
        return fileURL
    }
    
    // save
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(songs)
            try data.write(to: fileURL())
        } catch {
            print(error)
            print(error.localizedDescription)
        }
        
    }
    
    // load
    func loadFromPersistenceStore () {
        
        do {
            let data = try Data(contentsOf: fileURL())
            let foundSongs = try JSONDecoder().decode([Song].self, from: data)
            songs = foundSongs
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
}



