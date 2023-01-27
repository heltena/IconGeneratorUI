//
//  File.swift
//  
//
//  Created by Heliodoro Tejedor Navarro on 27/1/23.
//

import Foundation

public enum SnapshotError: Error {
    case snapshot
    
    #if os(iOS)
    case pngData
    #endif
    
    #if os(macOS)
    case tiffRepresentation
    case bitmapImageRep
    case pngRepresentation
    #endif
}
