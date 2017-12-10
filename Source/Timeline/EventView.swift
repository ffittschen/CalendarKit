import UIKit
import DateToolsSwift
import Neon

protocol EventViewDelegate: class {
  func eventViewDidTap(_ eventView: EventView)
  func eventViewDidLongPress(_ eventview: EventView)
}

public protocol EventDescriptor: class {
  var datePeriod: TimePeriodProtocol {get}
  var text: String {get}
  var attributedText: NSAttributedString? {get}
  var font : UIFont {get}
  var color: UIColor {get}
  var textColor: UIColor {get}
  var backgroundColor: UIColor {get}
  var frame: CGRect {get set}
}

open class EventView: UIView {

  weak var delegate: EventViewDelegate?
  public var descriptor: EventDescriptor?

  public var color = UIColor.lightGray
  public var eventStyle: EventStyle = EventStyle()

  var contentHeight: CGFloat {
    return textView.height
  }

  lazy var textView: UITextView = {
    let view = UITextView()
    view.isUserInteractionEnabled = false
    view.backgroundColor = .clear
    view.isScrollEnabled = false
    return view
  }()

    lazy var fadeBottomMask: CAGradientLayer = {
        let mask = CAGradientLayer()
        mask.startPoint = CGPoint(x: 0.0, y: 1.0)
        mask.endPoint = CGPoint(x: 0.0, y: 0.0)
        let whiteColor = UIColor.white
        mask.colors = [
            whiteColor.withAlphaComponent(0.0).cgColor,
            whiteColor.withAlphaComponent(1.0).cgColor,
            whiteColor.withAlphaComponent(1.0).cgColor
        ]
        mask.locations = [0.0, 0.2, 1.0]
        mask.frame = bounds
        return mask
    }()

  lazy var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
  lazy var longPressGestureRecognizer: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configure()
  }

  func configure() {
    clipsToBounds = true
    [tapGestureRecognizer, longPressGestureRecognizer].forEach {addGestureRecognizer($0)}

    color = tintColor
    addSubview(textView)
  }

  func updateWithDescriptor(event: EventDescriptor) {
    if let attributedText = event.attributedText {
      textView.attributedText = attributedText
    } else {
      textView.text = event.text
      textView.textColor = event.textColor
      textView.font = event.font
    }
    descriptor = event
    backgroundColor = event.backgroundColor
    color = event.color
    setNeedsDisplay()
    setNeedsLayout()
  }

  public func updateStyle(_ newStyle: EventStyle) {
    eventStyle = newStyle
    textView.textAlignment = newStyle.textAlignment
    layer.cornerRadius = newStyle.cornerRadius
    layer.borderWidth = newStyle.borderStyle == .allSides ? 1 : 0
    layer.borderColor = newStyle.borderStyle == .allSides ? Optional(UIColor.gray.cgColor) : Optional<CGColor>.none

    if newStyle.fadeBottom {
        layer.mask = fadeBottomMask
    }

    setNeedsDisplay()
  }

  @objc func tap() {
    delegate?.eventViewDidTap(self)
  }

  @objc func longPress() {
    delegate?.eventViewDidLongPress(self)
  }

  override open func draw(_ rect: CGRect) {
    super.draw(rect)
    guard eventStyle.borderStyle == .leftSide else { return }

    let context = UIGraphicsGetCurrentContext()
    context!.interpolationQuality = .none
    context?.saveGState()
    context?.setStrokeColor(color.cgColor)
    context?.setLineWidth(3)
    context?.translateBy(x: 0, y: 0.5)
    let x: CGFloat = 0
    let y: CGFloat = 0
    context?.beginPath()
    context?.move(to: CGPoint(x: x, y: y))
    context?.addLine(to: CGPoint(x: x, y: (bounds).height))
    context?.strokePath()
    context?.restoreGState()
  }

  override open func layoutSubviews() {
    super.layoutSubviews()
    textView.fillSuperview()

    if eventStyle.fadeBottom {
        fadeBottomMask.frame = bounds
    }
  }
}
