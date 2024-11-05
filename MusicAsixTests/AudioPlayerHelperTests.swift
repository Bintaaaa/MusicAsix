//
//  AudioPlayerHelperTests.swift
//  MusicAsix
//
//  Created by Bijantyum on 06/11/24.
//


import XCTest
import AVFoundation
@testable import MusicAsix

class AudioPlayerHelperTests: XCTestCase {

    var audioPlayerHelper: AudioPlayerHelper!

    override func setUp() {
        super.setUp()
        audioPlayerHelper = AudioPlayerHelper.shared
    }

    override func tearDown() {
        audioPlayerHelper = nil
        super.tearDown()
    }

    func testPlayTrack() {
        let url = URL(string: "https://www.example.com/audio.mp3")!
        audioPlayerHelper.playTrack(with: url)

        let expectation = self.expectation(description: "Wait..")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if let status = self.audioPlayerHelper.player?.timeControlStatus {
                XCTAssertTrue(status == .playing || status == .waitingToPlayAtSpecifiedRate, "Player should be playing or waiting to play.")
            } else {
                XCTFail("Player might nil")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testPause() {
        let url = URL(string: "https://www.example.com/audio.mp3")!
        audioPlayerHelper.playTrack(with: url)
        
        audioPlayerHelper.pause()
        
        XCTAssertEqual(audioPlayerHelper.player?.timeControlStatus, .paused)
    }

    func testTogglePlayPause() {

    }
}
