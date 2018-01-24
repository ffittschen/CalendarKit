import UIKit

protocol TimelineContainerDelegate: class {
    func timelineContainerDidZoom(_ timelineContainer: TimelineContainer)
}

public class TimelineContainer: UIScrollView, ReusableView {
  
  public let timeline: TimelineView

    private var maxContentOffsetY: CGFloat {
        return contentSize.height - bounds.height
    }
    private lazy var zoomPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(zoom(_:)))
    weak var zoomDelegate: TimelineContainerDelegate?

  public init(_ timeline: TimelineView) {
    self.timeline = timeline
    super.init(frame: .zero)
    addGestureRecognizer(zoomPinchGestureRecognizer)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override public func layoutSubviews() {
    timeline.frame = CGRect(x: 0, y: 0, width: width, height: timeline.fullHeight)
  }
  
  public func prepareForReuse() {
    timeline.prepareForReuse()
  }
  
  public func scrollToFirstEvent() {
    if let yToScroll = timeline.firstEventYPosition {
      setContentOffset(CGPoint(x: contentOffset.x, y: yToScroll - 15), animated: true)
    }
  }
  
  public func scrollTo(hour24: Float) {
    let percentToScroll = CGFloat(hour24 / 24)
    let yToScroll = contentSize.height * percentToScroll
    let padding: CGFloat = 8
    setContentOffset(CGPoint(x: contentOffset.x, y: yToScroll - padding), animated: true)
  }

    @objc private func zoom(_ gestureRecognizer: UIPinchGestureRecognizer) {
        switch gestureRecognizer.state {
        case .began, .changed:
            let calculatedVerticalDiff = timeline.verticalDiff * gestureRecognizer.scale
            let newVerticalDiff = calculatedVerticalDiff.clamped(to: timeline.style.minOneHourHeight...timeline.style.maxOneHourHeight)
            let offsetScale = calculatedVerticalDiff == newVerticalDiff ? gestureRecognizer.scale : 1
            let calculatedContentOffsetY = ((contentOffset.y + gestureRecognizer.pinchCenter.y) * offsetScale) - gestureRecognizer.pinchCenter.y
            let newContentOffsetY = calculatedContentOffsetY.clamped(to: 0...maxContentOffsetY)
            let newContentOffset = CGPoint(x: contentOffset.x, y: newContentOffsetY)

            timeline.verticalDiff = newVerticalDiff
            contentSize = timeline.frame.size
            contentOffset = newContentOffset
            gestureRecognizer.scale = 1
        case .ended:
            zoomDelegate?.timelineContainerDidZoom(self)
        default:
            break
        }
    }
}

private extension UIGestureRecognizer {
    var pinchCenter: CGPoint {
        guard let view = view else { return .zero }
        return CGPoint(x: location(in: view).x - view.bounds.midX, y: location(in: view).y - view.bounds.midY)
    }
}
