import Cocoa
import SwiftUI

public enum SnapshotError: Error {
    case snapshot
    case tiffRepresentation
    case bitmapImageRep
    case pngRepresentation
}

public extension View {
    func snapshot(targetSize: CGSize) -> NSImage? {
        let controller = NSHostingController(rootView: self)
        let contentRect = NSRect(origin: .zero, size: targetSize)

        let window = NSWindow(
            contentRect: contentRect,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )
        window.contentView = controller.view

        guard
            let bitmapRep = controller.view.bitmapImageRepForCachingDisplay(in: contentRect)
        else { return nil }

        controller.view.cacheDisplay(in: contentRect, to: bitmapRep)
        let image = NSImage(size: bitmapRep.size)
        image.addRepresentation(bitmapRep)
        return image
    }

    func saveSnapshot(targetSize: CGSize, to fileUrl: URL) throws {
        guard
            let image = snapshot(targetSize: targetSize)
        else {
            throw SnapshotError.snapshot
        }

        guard
            let data = image.tiffRepresentation
        else {
            throw SnapshotError.tiffRepresentation
        }

        guard
            let rep = NSBitmapImageRep(data: data)
        else {
            throw SnapshotError.bitmapImageRep
        }

        guard
            let pngData = rep.representation(using: .png, properties: [:])
        else {
            throw SnapshotError.pngRepresentation
        }

        try pngData.write(to: fileUrl)
    }
}
