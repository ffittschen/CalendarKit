

public enum DateStyle {
    ///Times should be shown in the 12 hour format
    case twelveHour
    
    ///Times should be shown in the 24 hour format
    case twentyFourHour
    
    ///Times should be shown according to the user's system preference.
    case system
}

public struct CalendarStyle {
    public var header: DayHeaderStyle
    public var timeline: TimelineStyle

    public init(header: DayHeaderStyle = DayHeaderStyle(),
                timeline: TimelineStyle = TimelineStyle()) {
        self.header = header
        self.timeline = timeline
    }
}

public struct DayHeaderStyle {
    public var daySymbols: DaySymbolsStyle
    public var daySelector:  DaySelectorStyle
    public var swipeLabel:  SwipeLabelStyle
    public var backgroundColor: UIColor

    public init(daySymbols: DaySymbolsStyle = DaySymbolsStyle(),
                daySelector: DaySelectorStyle = DaySelectorStyle(),
                swipeLabel: SwipeLabelStyle = SwipeLabelStyle(),
                backgroundColor: UIColor = UIColor(white: 247/255, alpha: 1)) {
        self.daySymbols = daySymbols
        self.daySelector = daySelector
        self.swipeLabel = swipeLabel
        self.backgroundColor = backgroundColor
    }
}

public struct DaySelectorStyle {
    public var activeTextColor: UIColor
    public var selectedBackgroundColor: UIColor

    public var weekendTextColor: UIColor
    public var inactiveTextColor: UIColor
    public var inactiveBackgroundColor: UIColor

    public var todayInactiveTextColor: UIColor
    public var todayActiveBackgroundColor: UIColor
    
    public var font: UIFont
    public var todayFont: UIFont

    public init(activeTextColor: UIColor = .white,
                selectedBackgroundColor: UIColor = .black,
                weekendTextColor: UIColor = .gray,
                inactiveTextColor: UIColor = .black,
                inactiveBackgroundColor: UIColor = .clear,
                todayInactiveTextColor: UIColor = .red,
                todayActiveBackgroundColor: UIColor = .red,
                font: UIFont = .systemFont(ofSize: 18),
                todayFont: UIFont = .boldSystemFont(ofSize: 18)) {
        self.activeTextColor = activeTextColor
        self.selectedBackgroundColor = selectedBackgroundColor
        self.weekendTextColor = weekendTextColor
        self.inactiveTextColor = inactiveTextColor
        self.inactiveBackgroundColor = inactiveBackgroundColor
        self.todayInactiveTextColor = todayInactiveTextColor
        self.todayActiveBackgroundColor = todayActiveBackgroundColor
        self.font = font
        self.todayFont = todayFont
    }
}

public struct DaySymbolsStyle {
    public var weekendColor: UIColor
    public var weekDayColor: UIColor
    public var font: UIFont

    public init(weekendColor: UIColor = .lightGray,
                weekDayColor: UIColor = .black,
                font: UIFont = .systemFont(ofSize: 10)) {
        self.weekendColor = weekendColor
        self.weekDayColor = weekDayColor
        self.font = font
    }
}

public struct SwipeLabelStyle {
    public var textColor: UIColor
    public var font: UIFont

    public init(textColor: UIColor = .black,
                font: UIFont = .systemFont(ofSize: 15)) {
        self.textColor = textColor
        self.font = font
    }
}

public struct TimelineStyle {
    public var timeIndicator: CurrentTimeIndicatorStyle
    public var timeColor: UIColor
    public var lineColor: UIColor
    public var backgroundColor: UIColor
    public var font: UIFont
    public var dateStyle: DateStyle
    public var eventStyle: EventStyle

    public init(timeIndicator: CurrentTimeIndicatorStyle = CurrentTimeIndicatorStyle(),
                timeColor: UIColor = .lightGray,
                lineColor: UIColor = .lightGray,
                backgroundColor: UIColor = .white,
                font: UIFont = .boldSystemFont(ofSize: 11),
                dateStyle: DateStyle = .system,
                eventStyle: EventStyle = EventStyle()) {
        self.timeIndicator = timeIndicator
        self.timeColor = timeColor
        self.lineColor = lineColor
        self.backgroundColor = backgroundColor
        self.font = font
        self.dateStyle = dateStyle
        self.eventStyle = eventStyle
    }
}

public struct CurrentTimeIndicatorStyle {
    public var color: UIColor
    public var font: UIFont
    public var dateStyle: DateStyle

    public init(color: UIColor = .red,
                font: UIFont = .systemFont(ofSize: 11),
                dateStyle: DateStyle = .system) {
        self.color = color
        self.font = font
        self.dateStyle = dateStyle
    }
}

public struct EventStyle {
    public enum BorderStyle {
        case leftSide
        case allSides
    }

    public var cornerRadius: CGFloat
    public var maxWidth: CGFloat?
    public var borderStyle: BorderStyle
    public var textAlignment: NSTextAlignment

    public init(cornerRadius: CGFloat = 0,
                maxWidth: CGFloat? = nil,
                borderStyle: BorderStyle = .leftSide,
                textAlignment: NSTextAlignment = .left) {
        self.cornerRadius = cornerRadius
        self.maxWidth = maxWidth
        self.borderStyle = borderStyle
        self.textAlignment = textAlignment
    }
}
