import SwiftUI

#if os(iOS)
import UIKit
#endif

public extension View {
    #if os(iOS)
    func snapshot(targetSize: CGSize) -> UIImage? {
        let controller = UIHostingController(rootView: self)
        controller.view.bounds = CGRect(origin: .zero, size: targetSize)
        let renderer = UIGraphicsImageRenderer(size: controller.view.bounds.size)
        let image = renderer.image { context in
            controller.view.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
        return image
    }
    
    func saveSnapshot(targetSize: CGSize, to fileUrl: URL) throws {
        guard
            let image = snapshot(targetSize: targetSize)
        else {
            throw SnapshotError.snapshot
        }

        guard
            let pngData = image.pngData()
        else {
            throw SnapshotError.pngData
        }

        try pngData.write(to: fileUrl)
    }
    #endif
}
