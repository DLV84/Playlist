//
//  SongListTableViewController.swift
//  Playlist
//
//  Created by Daniel Villedrouin on 1/11/21.
//

import UIKit

class SongListTableViewController: UITableViewController {
    //MARK: - Outlets
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        SongController.shared.loadFromPersistenceStore()
    }

    //MARK: - Actions
    @IBAction func addSongButtonTapped(_ sender: Any) {
        guard let songTitle = songTitleTextField.text, !songTitle.isEmpty,
              let artistName = artistNameTextField.text, !artistName.isEmpty else { return }
        
        SongController.shared.createSong(newSongTitle: songTitle, newSongArtist: artistName)
        tableView.reloadData()
        songTitleTextField.text = ""
        artistNameTextField.text = ""
        songTitleTextField.resignFirstResponder()
        artistNameTextField.resignFirstResponder()
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return SongController.shared.songs.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        let song = SongController.shared.songs[indexPath.row]
        
        cell.textLabel?.text = song.title
        cell.detailTextLabel?.text = song.artist

    
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let songToDelete = SongController.shared.songs[indexPath.row]
            SongController.shared.deleteSong(songToDelete: songToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}// End of class
