import UIKit

class ScrollSynchronizer: NSObject, UIScrollViewDelegate {

  var timelineContainers = [TimelineContainer]()

  init(timelineContainers: [TimelineContainer] = [TimelineContainer]()) {
    self.timelineContainers = timelineContainers
    super.init()
    timelineContainers.forEach { container in
        container.delegate = self
        container.zoomDelegate = self
    }
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    guard let timelineContainer = scrollView as? TimelineContainer else { return }
    for container in timelineContainers {
      if container == scrollView { continue }
      container.contentOffset = timelineContainer.contentOffset
    }
  }
}

extension ScrollSynchronizer: TimelineContainerDelegate {
    func timelineContainerDidZoom(_ timelineContainer: TimelineContainer) {
        for view in timelineContainers {
            if view == timelineContainer {continue}
            view.contentSize = timelineContainer.contentSize
            view.timeline.verticalDiff = timelineContainer.timeline.verticalDiff
        }
    }
}
