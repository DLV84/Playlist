//
//  SongController.swift
//  Playlist
//
//  Created by Daniel Villedrouin on 1/11/21.
//

import Foundation

class SongController {
    
    // CRUD Methods
    // Create
  static  func createSong(newSongTitle: String, newSongArtist: String, playlist: Playlist) {
        let newSong = Song(title: newSongTitle, artist: newSongArtist)
        playlist.songs.append(newSong)
        PlaylistController.shared.saveToPersistenceStore()
    }
    
    // Delete
  static func  deleteSong(songToDelete: Song, playlist: Playlist) {
        guard let index = playlist.songs.firstIndex(of: songToDelete) else { return }
        playlist.songs.remove(at: index)
        PlaylistController.shared.saveToPersistenceStore()
    }

}



